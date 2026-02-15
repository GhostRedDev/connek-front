import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'providers/wallet_provider.dart';
import '../settings/providers/profile_provider.dart'; // Import ProfileProvider
import 'services/client_wallet_service.dart'; // Import ClientWalletService
import '../../system_ui/core/constants.dart';

class ClientDashboardWallet extends ConsumerWidget {
  const ClientDashboardWallet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF131619) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1D21);

    // Watch Wallet Provider
    final walletAsync = ref.watch(walletProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: walletAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (state) {
          final coupons = state.coupons;
          final transactions = state.transactions;
          final balance = state.balance;

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppBreakpoints.ultraWide,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Billetera y pagos',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Controla tus métodos de pagos y transacciones.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Balance Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD), // Light Blue
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Balance total:',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            NumberFormat.currency(symbol: '\$').format(balance),
                            style: GoogleFonts.inter(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1565C0), // Blue
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      _showDepositDialog(context, ref),
                                  icon: const Icon(Icons.add, size: 18),
                                  label: const Text('Depositar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFF0D1B2A,
                                    ), // Dark Navy
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () => _showWithdrawDialog(
                                    context,
                                    ref,
                                    balance,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_outward,
                                    size: 18,
                                  ),
                                  label: const Text('Retirar'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF0D1B2A),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFF0D1B2A),
                                      width: 1,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Metodos de pago
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131619), // Dark bg
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Métodos de Pago",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () =>
                                  _handleAddPaymentMethod(context, ref),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "+ Agregar método de pago",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Cupones Header
                    Text(
                      'Cupones',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Coupons List (Dynamic)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: coupons.map((coupon) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: _buildCouponCard(
                              context,
                              ref,
                              code: coupon.code,
                              discount: coupon.discount,
                              description: coupon.description,
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Transacciones Header
                    Text(
                      'Transacciones',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Transactions Container
                    Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF131619)
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isDark ? Colors.white10 : Colors.grey.shade200,
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: transactions.isEmpty
                          ? _buildEmptyTransactionsState(isDark)
                          : Column(
                              children: [
                                // Search & Filter
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Buscar transacción',
                                    hintStyle: GoogleFonts.inter(
                                      color: Colors.grey[500],
                                    ),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey[400],
                                    ),
                                    filled: true,
                                    fillColor: isDark
                                        ? const Color(0xFF1E2429)
                                        : Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Filter Chips
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _buildFilterChip('Todos', true),
                                      const SizedBox(width: 8),
                                      _buildFilterChip('Pagos', false),
                                      const SizedBox(width: 8),
                                      _buildFilterChip('Ganancias', false),
                                      const SizedBox(width: 8),
                                      _buildFilterChip('Reembolsos', false),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // List of Transactions
                                ...transactions.map((tx) {
                                  final isNegative = tx.amount < 0;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: _buildTransactionItem(
                                      title: tx.title,
                                      date: DateFormat(
                                        'MMM d, y',
                                      ).format(tx.date),
                                      amount: NumberFormat.currency(
                                        symbol: '\$',
                                      ).format(tx.amount),
                                      amountColor: isNegative
                                          ? (isDark
                                                ? Colors.white
                                                : Colors.black87)
                                          : const Color(
                                              0xFF0F9D58,
                                            ), // Green for deposits
                                      tag: tx.type.toUpperCase(),
                                      tagColor: isNegative
                                          ? Colors.red.withOpacity(0.1)
                                          : Colors.green.withOpacity(0.1),
                                      tagTextColor: isNegative
                                          ? Colors.red
                                          : Colors.green,
                                      icon: tx.type == 'deposit'
                                          ? Icons.arrow_downward
                                          : (tx.type == 'withdrawal'
                                                ? Icons.arrow_upward
                                                : Icons.payment),
                                    ),
                                  );
                                }),
                              ],
                            ),
                    ),
                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleAddPaymentMethod(
    BuildContext context,
    WidgetRef ref,
  ) async {
    try {
      final profileState = ref.read(profileProvider);
      if (profileState.value == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: No se pudo identificar al cliente'),
          ),
        );
        return;
      }
      final clientId = profileState.value!.id;
      final stripeId = profileState.value!.stripeId;

      if (stripeId == null || stripeId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: Cliente no tiene Stripe ID')),
        );
        return;
      }

      final clientService = ref.read(clientWalletServiceProvider);
      final url = await clientService.getPaymentSetupUrl(
        clientId: clientId,
        stripeCustomerId: stripeId,
      );

      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'No se pudo abrir el enlace $url';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar configuración de pago: $e')),
        );
      }
    }
  }

  void _showDepositDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Depositar Fondos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ingresa el monto a depositar:'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixText: '\$ ',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                ref.read(walletProvider.notifier).deposit(amount);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Depósito de \$${amount.toStringAsFixed(2)} exitoso',
                    ),
                  ),
                );
              }
            },
            child: const Text('Depositar'),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog(
    BuildContext context,
    WidgetRef ref,
    double currentBalance,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Retirar Fondos'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Balance disponible: \$${currentBalance.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            const Text('Ingresa el monto a retirar:'),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixText: '\$ ',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0) {
                if (amount > currentBalance) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fondos insuficientes')),
                  );
                  return;
                }
                ref.read(walletProvider.notifier).withdraw(amount);
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Retiro de \$${amount.toStringAsFixed(2)} procesado',
                    ),
                  ),
                );
              }
            },
            child: const Text('Retirar'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTransactionsState(bool isDark) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Buscar transacción',
            hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E2429) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),

        const SizedBox(height: 16),

        // Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('Todos', true),
              const SizedBox(width: 8),
              _buildFilterChip('Pagos', false),
              const SizedBox(width: 8),
              _buildFilterChip('Ganancias', false),
              const SizedBox(width: 8),
              _buildFilterChip('Reembolsos', false),
            ],
          ),
        ),

        const SizedBox(height: 48),

        // Empty State Icon (Using explicit Icon to be sure)
        Icon(Icons.monetization_on_outlined, size: 48, color: Colors.grey[600]),

        const SizedBox(height: 16),

        Text(
          "You haven't made any transactions",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[500],
          ),
        ),

        const SizedBox(height: 48),
      ],
    );
  }

  Widget _buildCouponCard(
    BuildContext context,
    WidgetRef ref, {
    required String code,
    required String discount,
    required String description,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF2979FF), // Blue header
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_offer, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    code,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.bookmark_border,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discount,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      try {
                        await ref
                            .read(walletProvider.notifier)
                            .applyCoupon(code);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cupón $code aplicado con éxito'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('Error: $e')));
                        }
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black87,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Aplicar cupón',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4285F4) : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
    required Color amountColor,
    required String tag,
    required Color tagColor,
    required Color tagTextColor,
    IconData icon = Icons.store_mall_directory_outlined,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold, // Semi-bold
                  fontSize: 14,
                  color: amountColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    date,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: tagColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: tagTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: amountColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
