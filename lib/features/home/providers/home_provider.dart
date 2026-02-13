import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/transactions.dart';
import '../../../data/mock_data.dart';

/// Home state containing balance and transactions
class HomeState {
  const HomeState({
    required this.balance,
    required this.transactions,
    this.isBalanceVisible = true,
  });

  final double balance;
  final List<Transaction> transactions;
  final bool isBalanceVisible;

  HomeState copyWith({
    double? balance,
    List<Transaction>? transactions,
    bool? isBalanceVisible,
  }) {
    return HomeState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
    );
  }
}

/// Home notifier managing balance and transaction state
class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(
      balance: MockData.initialBalance,
      transactions: MockData.transactions,
    );
  }

  /// Toggle balance visibility
  void toggleBalanceVisibility() {
    state = state.copyWith(isBalanceVisible: !state.isBalanceVisible);
  }

  /// Add a new transaction and update balance
  void addTransaction(Transaction transaction) {
    final newTransactions = [transaction, ...state.transactions];
    double newBalance = state.balance;

    // Update balance based on transaction type
    switch (transaction.type) {
      case TransactionType.sent:
      case TransactionType.bill:
      case TransactionType.airtime:
        newBalance -= transaction.amount;
        break;
      case TransactionType.received:
        newBalance += transaction.amount;
        break;
    }

    state = state.copyWith(
      balance: newBalance,
      transactions: newTransactions,
    );
  }

  /// Get recent transactions (last 5)
  List<Transaction> getRecentTransactions() {
    return state.transactions.take(5).toList();
  }

  /// Get weekly increase amount
  double getWeeklyIncrease() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    final weeklyTransactions = state.transactions.where((tx) {
      return tx.date.isAfter(weekAgo);
    }).toList();

    double increase = 0.0;
    for (final tx in weeklyTransactions) {
      if (tx.type == TransactionType.received) {
        increase += tx.amount;
      }
    }

    return increase;
  }
}

/// Provider for home state
final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);

/// Provider for balance visibility
final balanceVisibilityProvider = Provider<bool>((ref) {
  return ref.watch(homeProvider).isBalanceVisible;
});

/// Provider for recent transactions
final recentTransactionsProvider = Provider<List<Transaction>>((ref) {
  return ref.watch(homeProvider).transactions.take(5).toList();
});

/// Provider for current balance
final currentBalanceProvider = Provider<double>((ref) {
  return ref.watch(homeProvider).balance;
});
