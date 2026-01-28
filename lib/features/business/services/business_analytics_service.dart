import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';

// Model for Analytics Data
class FinancialStats {
  final List<GraphSpot> incomeSpots;
  final List<GraphSpot> expenseSpots;
  final StatsSummary stats;
  final List<String> labels;
  final Map<String, double> incomeByCategory;

  FinancialStats({
    required this.incomeSpots,
    required this.expenseSpots,
    required this.stats,
    required this.labels,
    required this.incomeByCategory,
  });

  factory FinancialStats.fromJson(Map<String, dynamic> json) {
    return FinancialStats(
      incomeSpots:
          ((json['income_spots'] ?? json['incomeSpots']) as List? ?? [])
              .map((e) => GraphSpot.fromJson(e))
              .toList(),
      expenseSpots:
          ((json['expense_spots'] ?? json['expenseSpots']) as List? ?? [])
              .map((e) => GraphSpot.fromJson(e))
              .toList(),
      stats: StatsSummary.fromJson(json['stats'] ?? {}),
      labels: List<String>.from(json['labels'] ?? []),
      incomeByCategory: Map<String, double>.from(
        (json['income_by_category'] ?? {}).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
    );
  }
}

class GraphSpot {
  final double x;
  final double y;
  final String date;

  GraphSpot({required this.x, required this.y, required this.date});

  factory GraphSpot.fromJson(Map<String, dynamic> json) {
    return GraphSpot(
      x: (json['x'] as num?)?.toDouble() ?? 0.0,
      y: (json['y'] as num?)?.toDouble() ?? 0.0,
      date: (json['date'] as String?) ?? '',
    );
  }
}

class StatsSummary {
  final double totalIncome;
  final double totalExpense;
  final double profit;
  final double margin;
  final double incomeGrowth;
  final double expenseGrowth;
  final double averageTicket;
  final double taxEstimation;
  final double potentialRevenue;
  final double lostRevenue;
  final double walletInjections;

  StatsSummary({
    required this.totalIncome,
    required this.totalExpense,
    required this.profit,
    required this.margin,
    this.incomeGrowth = 0.0,
    this.expenseGrowth = 0.0,
    this.averageTicket = 0.0,
    this.taxEstimation = 0.0,
    this.potentialRevenue = 0.0,
    this.lostRevenue = 0.0,
    this.walletInjections = 0.0,
  });

  factory StatsSummary.fromJson(Map<String, dynamic> json) {
    return StatsSummary(
      totalIncome: (json['totalIncome'] as num?)?.toDouble() ?? 0.0,
      totalExpense: (json['totalExpense'] as num?)?.toDouble() ?? 0.0,
      profit: (json['profit'] as num?)?.toDouble() ?? 0.0,
      margin: (json['margin'] as num?)?.toDouble() ?? 0.0,
      incomeGrowth: (json['incomeGrowth'] as num?)?.toDouble() ?? 0.0,
      expenseGrowth: (json['expenseGrowth'] as num?)?.toDouble() ?? 0.0,
      averageTicket: (json['averageTicket'] as num?)?.toDouble() ?? 0.0,
      taxEstimation: (json['taxEstimation'] as num?)?.toDouble() ?? 0.0,
      potentialRevenue: (json['potentialRevenue'] as num?)?.toDouble() ?? 0.0,
      lostRevenue: (json['lostRevenue'] as num?)?.toDouble() ?? 0.0,
      walletInjections: (json['walletInjections'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

// Service Provider
final businessAnalyticsServiceProvider = Provider((ref) {
  return BusinessAnalyticsService(ref.watch(apiServiceProvider));
});

// Service Class
class BusinessAnalyticsService {
  final ApiService _apiService;

  BusinessAnalyticsService(this._apiService);

  Future<FinancialStats> getFinancialStats(
    int businessId,
    String period,
  ) async {
    try {
      final responseData = await _apiService.get(
        '/payments/analytics/$businessId?period=$period',
      );

      // ApiService throws on error, so if we get here, it success or a 200-range response body.
      final data = responseData as Map<String, dynamic>;

      if (data['success'] == true) {
        final innerData = data['data'];
        return FinancialStats.fromJson(innerData);
      } else {
        throw Exception(data['error'] ?? 'Unknown error fetching analytics');
      }
    } catch (e) {
      throw Exception('Error fetching analytics: $e');
    }
  }

  Future<void> addManualTransaction({
    required int businessId,
    required double amount,
    required String type, // 'income' or 'expense'
    required String category,
    required String description,
    required String date,
  }) async {
    try {
      final response = await _apiService.post(
        '/payments/manual',
        body: {
          'business_id': businessId,
          'amount': amount,
          'type': type,
          'category': category,
          'description': description,
          'date': date,
        },
      );

      final data = response as Map<String, dynamic>;
      if (data['success'] != true) {
        throw Exception(data['error'] ?? 'Failed to add transaction');
      }
    } catch (e) {
      throw Exception('Error adding manual transaction: $e');
    }
  }
}
