import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';

final clientWalletServiceProvider = Provider<ClientWalletService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ClientWalletService(apiService);
});

class ClientWalletService {
  final ApiService _apiService;

  ClientWalletService(this._apiService);

  // Get Balance
  Future<Map<String, dynamic>> getBalance({required int clientId}) async {
    final response = await _apiService.get(
      '/payments/balance?client_id=$clientId',
    );
    return response['data'];
  }

  // Get Transactions
  Future<List<dynamic>> getTransactions({required int clientId}) async {
    final response = await _apiService.get(
      '/payments/transactions/client/$clientId',
    );
    if (response['success'] == true) {
      return response['data'] as List<dynamic>;
    }
    return [];
  }

  // Get Payment Methods
  Future<List<dynamic>> getPaymentMethods({required int clientId}) async {
    final response = await _apiService.get(
      '/payments/methods?client_id=$clientId',
    );
    if (response['success'] == true) {
      return response['data'] as List<dynamic>;
    }
    return [];
  }

  // Deposit
  Future<Map<String, dynamic>> deposit({
    required int clientId,
    required double amount, // In dollars
    required int paymentMethodId,
  }) async {
    final amountCents = (amount * 100).toInt();
    final response = await _apiService.post(
      '/payments/deposit',
      body: {
        'client_id': clientId,
        'amount_cents': amountCents,
        'category': 'deposit',
        'payment_method_id': paymentMethodId,
        'business_id': null,
      },
    );
    return response['data'];
  }

  // Withdraw
  Future<Map<String, dynamic>> withdraw({
    required int clientId,
    required double amount, // In dollars
  }) async {
    final amountCents = (amount * 100).toInt();
    // For withdrawals, we might not need a payment method ID immediately if it's not a refund to card
    // But backend expects it for logging? Let's check backend.
    // Backend says: payment_method_id is required for deposits.
    // For withdrawals, Stripe logic is TODO.
    // We will pass 0 or handling it in backend?
    // Backend: if not payment_method_id: return error 'Payment method ID is required for deposits'.
    // It only checks for deposits.

    final response = await _apiService.post(
      '/payments/deposit',
      body: {
        'client_id': clientId,
        'amount_cents':
            amountCents, // withdrawals use positive amount here, backend negates it?
        // Backend: amount_cents=amount_cents if category == 'deposit' else -amount_cents
        // So we send positive cents.
        'category': 'withdrawal',
        'payment_method_id': 0, // Dummy or default?
        'business_id': null,
      },
    );
    return response['data'];
  }

  // Setup Payment Method (Get URL)
  Future<String> getPaymentSetupUrl({
    required int clientId,
    required String stripeCustomerId,
  }) async {
    final response = await _apiService.post(
      '/payments/payment-setup',
      body: {
        'client_id': clientId,
        'customer_id': stripeCustomerId,
        'business_id': null,
      },
    );
    return response['data']['url'];
  }
}
