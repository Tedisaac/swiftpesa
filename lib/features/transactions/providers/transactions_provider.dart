import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/transactions.dart';
import '../../home/providers/home_provider.dart';

/// Transaction filter options
enum TransactionFilter {
  all,
  sent,
  received,
  bills,
  airtime,
}

/// Date grouping for transactions
enum DateGroup {
  today,
  yesterday,
  thisWeek,
  earlier,
}

/// Grouped transactions by date
class GroupedTransactions {
  const GroupedTransactions({
    required this.group,
    required this.transactions,
  });

  final DateGroup group;
  final List<Transaction> transactions;
}

/// Transactions state containing filter and search query
class TransactionsState {
  const TransactionsState({
    this.filter = TransactionFilter.all,
    this.searchQuery = '',
  });

  final TransactionFilter filter;
  final String searchQuery;

  TransactionsState copyWith({
    TransactionFilter? filter,
    String? searchQuery,
  }) {
    return TransactionsState(
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

/// Transactions notifier managing filter and search state
class TransactionsNotifier extends Notifier<TransactionsState> {
  @override
  TransactionsState build() {
    return const TransactionsState();
  }

  /// Set active filter
  void setFilter(TransactionFilter filter) {
    state = state.copyWith(filter: filter);
  }

  /// Set search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Reset all filters
  void resetFilters() {
    state = const TransactionsState();
  }

  /// Get filtered transactions based on current state
  List<Transaction> getFilteredTransactions() {
    final homeState = ref.watch(homeProvider);
    List<Transaction> transactions = homeState.transactions;

    // Apply type filter
    if (state.filter != TransactionFilter.all) {
      transactions = transactions.where((tx) {
        switch (state.filter) {
          case TransactionFilter.sent:
            return tx.type == TransactionType.sent;
          case TransactionFilter.received:
            return tx.type == TransactionType.received;
          case TransactionFilter.bills:
            return tx.type == TransactionType.bill;
          case TransactionFilter.airtime:
            return tx.type == TransactionType.airtime;
          case TransactionFilter.all:
            return true;
        }
      }).toList();
    }

    // Apply search filter
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      transactions = transactions.where((tx) {
        return tx.name.toLowerCase().contains(query) ||
            tx.note?.toLowerCase().contains(query) == true;
      }).toList();
    }

    return transactions;
  }

  /// Group transactions by date
  List<GroupedTransactions> getGroupedTransactions() {
    final transactions = getFilteredTransactions();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final weekAgo = today.subtract(const Duration(days: 7));

    final Map<DateGroup, List<Transaction>> grouped = {
      DateGroup.today: [],
      DateGroup.yesterday: [],
      DateGroup.thisWeek: [],
      DateGroup.earlier: [],
    };

    for (final tx in transactions) {
      final txDate = DateTime(tx.date.year, tx.date.month, tx.date.day);

      if (txDate.isAtSameMomentAs(today)) {
        grouped[DateGroup.today]!.add(tx);
      } else if (txDate.isAtSameMomentAs(yesterday)) {
        grouped[DateGroup.yesterday]!.add(tx);
      } else if (txDate.isAfter(weekAgo) && txDate.isBefore(yesterday)) {
        grouped[DateGroup.thisWeek]!.add(tx);
      } else {
        grouped[DateGroup.earlier]!.add(tx);
      }
    }

    // Convert to list of GroupedTransactions, excluding empty groups
    final result = <GroupedTransactions>[];
    for (final entry in grouped.entries) {
      if (entry.value.isNotEmpty) {
        result.add(
          GroupedTransactions(
            group: entry.key,
            transactions: entry.value,
          ),
        );
      }
    }

    return result;
  }
}

/// Provider for transactions state
final transactionsProvider =
    NotifierProvider<TransactionsNotifier, TransactionsState>(
  TransactionsNotifier.new,
);

/// Provider for filtered transactions list
final filteredTransactionsProvider = Provider<List<Transaction>>((ref) {
  final notifier = ref.watch(transactionsProvider.notifier);
  return notifier.getFilteredTransactions();
});

/// Provider for grouped transactions
final groupedTransactionsProvider =
    Provider<List<GroupedTransactions>>((ref) {
  final notifier = ref.watch(transactionsProvider.notifier);
  return notifier.getGroupedTransactions();
});

/// Provider for current filter
final currentFilterProvider = Provider<TransactionFilter>((ref) {
  return ref.watch(transactionsProvider).filter;
});
