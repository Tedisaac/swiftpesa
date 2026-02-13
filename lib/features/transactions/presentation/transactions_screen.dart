import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_colors.dart';
import '../providers/transactions_provider.dart';
import 'widgets/filter_chips.dart';
import 'widgets/transactions_tile.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final groupedTransactions = ref.watch(groupedTransactionsProvider);

    return Scaffold(
      backgroundColor: AppColors.bgSecondary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement search functionality
                      debugPrint('Search tapped');
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Filter chips
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: FilterChips(),
            ),
            const SizedBox(height: 20),

            // Transaction list
            Expanded(
              child: groupedTransactions.isEmpty
                  ? _buildEmptyState(textTheme)
                  : _buildTransactionList(
                      context,
                      groupedTransactions,
                      textTheme,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build empty state when no transactions match filter
  Widget _buildEmptyState(TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: AppColors.cardBorder,
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: AppColors.textMuted,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions found',
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your filter',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build transaction list with date grouping
  Widget _buildTransactionList(
    BuildContext context,
    List<GroupedTransactions> groupedTransactions,
    TextTheme textTheme,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: groupedTransactions.length,
      itemBuilder: (context, index) {
        final group = groupedTransactions[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date group label
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                _getDateGroupLabel(group.group),
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                ),
              ),
            ),

            // Transactions card container
            Container(
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.cardBorder,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greenGlow.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Column(
                children: [
                  for (int i = 0; i < group.transactions.length; i++) ...[
                    TransactionTile(
                      transaction: group.transactions[i],
                      showStatus: true,
                    ),
                    if (i < group.transactions.length - 1)
                      const Divider(
                        color: AppColors.bgExtra,
                        height: 1,
                        thickness: 1,
                      ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  /// Get label for date group
  String _getDateGroupLabel(DateGroup group) {
    switch (group) {
      case DateGroup.today:
        return 'TODAY';
      case DateGroup.yesterday:
        return 'YESTERDAY';
      case DateGroup.thisWeek:
        return 'THIS WEEK';
      case DateGroup.earlier:
        return 'EARLIER';
    }
  }
}