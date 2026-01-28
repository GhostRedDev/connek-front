import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../services/client_wallet_service.dart';
import '../../settings/providers/profile_provider.dart';

// --- Models ---

class CouponModel {
  final String code;
  final String discount;
  final String description;

  const CouponModel({
    required this.code,
    required this.discount,
    required this.description,
  });
}

class TransactionModel {
  final String id;
  final String title;
  final DateTime date;
  final double amount; // in Cents usually, but using double for simple UI now
  final String type; // 'payment', 'refund', 'deposit', 'withdrawal'
  final String status;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.status,
  });
}

class WalletState {
  final double balance;
  final List<TransactionModel> transactions;
  final List<CouponModel> coupons;
  final bool isLoading;

  const WalletState({
    this.balance = 0.0,
    this.transactions = const [],
    this.coupons = const [],
    this.isLoading = false,
  });

  WalletState copyWith({
    double? balance,
    List<TransactionModel>? transactions,
    List<CouponModel>? coupons,
    bool? isLoading,
  }) {
    return WalletState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      coupons: coupons ?? this.coupons,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// --- Notifier ---

class WalletNotifier extends AsyncNotifier<WalletState> {
  @override
  FutureOr<WalletState> build() async {
    // 1. Fetch Real Data
    final clientService = ref.read(clientWalletServiceProvider);

    // Get Client ID from Profile
    final profileState = ref.watch(profileProvider);
    // If loading or null, return loading or empty state
    if (profileState.isLoading || profileState.value == null) {
      return const WalletState(isLoading: true);
    }
    final clientId = profileState.value!.id;

    // START PARALLEL FETCH
    final balanceFuture = clientService.getBalance(clientId: clientId);
    final transactionsFuture = clientService.getTransactions(
      clientId: clientId,
    );
    final methodsFuture = clientService.getPaymentMethods(clientId: clientId);

    final results = await Future.wait([
      balanceFuture,
      transactionsFuture,
      methodsFuture,
    ]);

    final balanceData = results[0] as Map<String, dynamic>?;
    final transactionsData = results[1] as List<dynamic>;
    // final methodsData = results[2] as List<dynamic>;

    // PARSE BALANCE
    double balance = 0.0;
    if (balanceData != null && balanceData.containsKey('total_balance')) {
      balance = (balanceData['total_balance'] as num).toDouble() / 100;
    }

    // PARSE TRANSACTIONS
    // Backend transactions
    List<TransactionModel> backendTransactions = transactionsData
        .map(
          (t) => TransactionModel(
            id: t['id'].toString(),
            title: t['description'] ?? 'Transacción',
            date: DateTime.parse(t['created_at']),
            amount:
                (t['amount_cents'] as num).toDouble() /
                100, // Assuming backend sends cents
            type: t['category'] ?? 'payment', // deposit, withdrawal
            status: 'Successful',
          ),
        )
        .toList();

    // COUPONS (Mock for now)
    final coupons = [
      const CouponModel(
        code: 'ARSFREE45',
        discount: '45% de descuento',
        description: 'En servicios mayor a \$200',
      ),
      const CouponModel(
        code: 'WELCOME20',
        discount: '20% OFF',
        description: 'First booking discount',
      ),
    ];

    return WalletState(
      balance: balance,
      transactions: backendTransactions,
      coupons: coupons,
    );
  }

  Future<void> deposit(double amount) async {
    state = const AsyncLoading();
    // Simulate API call delay if needed (backend calls are async anyway)

    state = await AsyncValue.guard(() async {
      final currentState = state.value!;

      // CALL API
      final clientService = ref.read(clientWalletServiceProvider);
      final profileState = ref.read(profileProvider);
      if (profileState.value == null) throw Exception('Usuario no autenticado');
      final clientId = profileState.value!.id;

      // For deposit we need paymentMethodId.
      final methods = await clientService.getPaymentMethods(clientId: clientId);
      if (methods.isEmpty) throw Exception('No payment methods available');
      final paymentMethodId = methods.first['id']; // Default to first

      await clientService.deposit(
        clientId: clientId,
        amount: amount,
        paymentMethodId: paymentMethodId,
      );

      // Optimistic update
      final newBalance = currentState.balance + amount;
      final newTx = TransactionModel(
        id: const Uuid().v4(),
        title: 'Depósito',
        date: DateTime.now(),
        amount: amount,
        type: 'deposit',
        status: 'Successful',
      );

      final newTransactions = [newTx, ...currentState.transactions];

      return currentState.copyWith(
        balance: newBalance,
        transactions: newTransactions,
      );
    });
  }

  Future<void> withdraw(double amount) async {
    final currentState = state.value;
    if (currentState == null) return;
    if (currentState.balance < amount) {
      throw Exception('Saldo insuficiente');
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final newBalance = currentState.balance - amount;

      // CALL API
      final clientService = ref.read(clientWalletServiceProvider);
      final profileState = ref.read(profileProvider);
      if (profileState.value == null) throw Exception('Usuario no autenticado');
      final clientId = profileState.value!.id;

      await clientService.withdraw(clientId: clientId, amount: amount);

      final newTx = TransactionModel(
        id: const Uuid().v4(),
        title: 'Retiro',
        date: DateTime.now(),
        amount: -amount,
        type: 'withdrawal',
        status: 'Successful',
      );

      final newTransactions = [newTx, ...currentState.transactions];

      return currentState.copyWith(
        balance: newBalance,
        transactions: newTransactions,
      );
    });
  }

  Future<void> applyCoupon(String code) async {
    // Just a mock check
    await Future.delayed(const Duration(milliseconds: 500));
    final currentState = state.value;
    if (currentState != null) {
      final exists = currentState.coupons.any((c) => c.code == code);
      if (!exists) throw Exception('Cupón inválido o expirado');
    }
  }
}

final walletProvider = AsyncNotifierProvider<WalletNotifier, WalletState>(() {
  return WalletNotifier();
});

// Deprecated providers kept for backward compatibility if needed
final couponListProvider = Provider<List<CouponModel>>((ref) {
  return ref.watch(walletProvider).valueOrNull?.coupons ?? [];
});

final walletTransactionListProvider = Provider<List<TransactionModel>>((ref) {
  return ref.watch(walletProvider).valueOrNull?.transactions ?? [];
});
