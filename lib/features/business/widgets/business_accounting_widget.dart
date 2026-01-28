import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/business_analytics_service.dart';
import 'add_manual_transaction_dialog.dart';
import 'business_financial_chart.dart';
import 'business_wallet_widget.dart';
import '../providers/business_provider.dart'; // Assuming we have a provider for current business ID

// Filter Provider
final accountingPeriodProvider = StateProvider<String>((ref) => 'Ano');

// Stats Future Provider
final businessFinancialStatsProvider = FutureProvider.family<FinancialStats, String>((
  ref,
  period,
) async {
  // We need the business ID from the provider.
  // businessProvider returns BusinessDashboardData which contains businessProfile map.
  final businessAsync = ref.watch(businessProvider);
  final businessProfile = businessAsync.value?.businessProfile;

  // Extract ID safely
  final businessId = businessProfile != null
      ? businessProfile['id'] as int?
      : null;

  if (businessId == null) {
    // Return empty stats if business ID is not found (e.g. still loading or error)
    return FinancialStats(
      incomeSpots: [],
      expenseSpots: [],
      stats: StatsSummary(
        totalIncome: 0,
        totalExpense: 0,
        profit: 0,
        margin: 0,
      ),
      labels: [],
      incomeByCategory: {},
    );
  }

  final service = ref.read(businessAnalyticsServiceProvider);
  return service.getFinancialStats(businessId, period);
});

class BusinessAccountingWidget extends ConsumerWidget {
  const BusinessAccountingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPeriod = ref.watch(accountingPeriodProvider);
    final statsAsyncValue = ref.watch(
      businessFinancialStatsProvider(selectedPeriod),
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HEADER & PERIOD FILTER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Resumen Financiero',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (_) => const AddManualTransactionDialog(),
                  );
                  if (result == true) {
                    ref.invalidate(businessFinancialStatsProvider);
                  }
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Time Filter Scrollable List
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _TimeFilterChip(
                  label: 'Diario',
                  value: 'Dia',
                  groupValue: selectedPeriod,
                ),
                _TimeFilterChip(
                  label: '3 Días',
                  value: '3D',
                  groupValue: selectedPeriod,
                ),
                _TimeFilterChip(
                  label: 'Semanal',
                  value: 'Sem',
                  groupValue: selectedPeriod,
                ),
                _TimeFilterChip(
                  label: 'Mensual',
                  value: 'Men',
                  groupValue: selectedPeriod,
                ),
                _TimeFilterChip(
                  label: 'Trimestral',
                  value: 'Tri',
                  groupValue: selectedPeriod,
                ),
                _TimeFilterChip(
                  label: 'Semestral',
                  value: '6M',
                  groupValue: selectedPeriod,
                ),
                _TimeFilterChip(
                  label: 'Anual',
                  value: 'Ano',
                  groupValue: selectedPeriod,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 2. CHART SECTION
          statsAsyncValue.when(
            data: (stats) => Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1D21) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Legends
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _LegendItem(
                            color: const Color(0xFF02d39a),
                            label: 'Ingresos',
                          ),
                          const SizedBox(width: 16),
                          _LegendItem(
                            color: const Color(0xFFFF5252),
                            label: 'Gastos',
                          ),
                        ],
                      ),
                      Expanded(
                        child: BusinessFinancialChart(
                          period: selectedPeriod,
                          incomeSpots: stats.incomeSpots,
                          expenseSpots: stats.expenseSpots,
                          labels: stats.labels,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Income Categories
                if (stats.incomeByCategory.isNotEmpty) ...[
                  Text(
                    'Fuentes de Ingreso',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...stats.incomeByCategory.entries.map((e) {
                    final total = stats.stats.totalIncome > 0
                        ? stats.stats.totalIncome
                        : 1.0;
                    final pct = e.value / total;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e.key,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '\$${e.value.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: pct,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            color: const Color(0xFF02d39a),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],

                const SizedBox(height: 24),

                // Projections & Wallet
                Text(
                  'Proyecciones y Flujo',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Por Cerrar',
                        '\$${stats.stats.potentialRevenue.toStringAsFixed(2)}',
                        Icons.pending_actions,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Dinero Perdido',
                        '\$${stats.stats.lostRevenue.toStringAsFixed(2)}',
                        Icons.money_off,
                        Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildStatCard(
                  context,
                  'Ingresos a Wallet',
                  '\$${stats.stats.walletInjections.toStringAsFixed(2)}',
                  Icons.account_balance_wallet,
                  Colors.blue,
                ),

                const SizedBox(height: 24),

                // 3. STATS CARDS (GRID)
                // 3. STATS CARDS (GRID)
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.4,
                  children: [
                    _StatCard(
                      title: 'Ingresos Totales',
                      value: '\$${stats.stats.totalIncome.toStringAsFixed(2)}',
                      trend:
                          '${stats.stats.incomeGrowth >= 0 ? "+" : ""}${stats.stats.incomeGrowth.toStringAsFixed(1)}%',
                      isPositive: stats.stats.incomeGrowth >= 0,
                      icon: Icons.attach_money,
                      color: Colors.green,
                    ),
                    _StatCard(
                      title: 'Gastos',
                      value: '\$${stats.stats.totalExpense.toStringAsFixed(2)}',
                      trend:
                          '${stats.stats.expenseGrowth >= 0 ? "+" : ""}${stats.stats.expenseGrowth.toStringAsFixed(1)}%',
                      isPositive:
                          stats.stats.expenseGrowth <=
                          0, // Lower expense growth is good, usually. But for visual red/green trend label logic:
                      // If expense grew (+), it's "Negative" (Red). If expense shrank (-), it's "Positive" (Green).
                      // We'll trust the visual helper to handle color based on `isPositive`.
                      icon: Icons.trending_down,
                      color: Colors.redAccent,
                    ),
                    _StatCard(
                      title: 'Ganancia Neta',
                      value: '\$${stats.stats.profit.toStringAsFixed(2)}',
                      trend: '${stats.stats.margin.toStringAsFixed(1)}% Margen',
                      isPositive: stats.stats.profit >= 0,
                      icon: Icons.pie_chart,
                      color: Colors.blueAccent,
                    ),
                    _StatCard(
                      title: 'Ticket Promedio',
                      value:
                          '\$${stats.stats.averageTicket.toStringAsFixed(2)}',
                      isPositive: true,
                      icon: Icons.receipt_long,
                      color: Colors.orangeAccent,
                    ),
                    _StatCard(
                      title: 'Impuestos Est.',
                      value:
                          '\$${stats.stats.taxEstimation.toStringAsFixed(2)}',
                      isPositive: false,
                      icon: Icons.account_balance,
                      color: Colors.purpleAccent,
                      trend: '15% Est.',
                    ),
                  ],
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) =>
                Center(child: Text('Error loading stats: $err')),
          ),

          const SizedBox(height: 32),

          // 4. WALLET PREVIEW
          Text(
            'Billetera Virtual',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const BusinessWalletWidget(),

          // SizedBox for bottom padding
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return _StatCard(
      title: title,
      value: value,
      isPositive: true,
      icon: icon,
      color: color,
    );
  }
}

class _TimeFilterChip extends ConsumerWidget {
  final String label;
  final String value;
  final String groupValue;

  const _TimeFilterChip({
    required this.label,
    required this.value,
    required this.groupValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = value == groupValue;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          if (selected) {
            ref.read(accountingPeriodProvider.notifier).state = value;
          }
        },
        selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final bool isPositive;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    this.trend = '', // Optional
    required this.isPositive,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1D21) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              if (trend.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (isPositive ? Colors.green : Colors.red).withOpacity(
                      0.1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    trend,
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.inter(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
