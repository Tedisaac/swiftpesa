import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/app_colors.dart';
import '../../providers/transactions_provider.dart';

class FilterChips extends ConsumerWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(currentFilterProvider);
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip(
            context: context,
            ref: ref,
            label: 'All',
            filter: TransactionFilter.all,
            isActive: currentFilter == TransactionFilter.all,
            textTheme: textTheme,
          ),
          const SizedBox(width: 6),
          _buildChip(
            context: context,
            ref: ref,
            label: 'Sent',
            filter: TransactionFilter.sent,
            isActive: currentFilter == TransactionFilter.sent,
            textTheme: textTheme,
          ),
          const SizedBox(width: 6),
          _buildChip(
            context: context,
            ref: ref,
            label: 'Received',
            filter: TransactionFilter.received,
            isActive: currentFilter == TransactionFilter.received,
            textTheme: textTheme,
          ),
          const SizedBox(width: 6),
          _buildChip(
            context: context,
            ref: ref,
            label: 'Bills',
            filter: TransactionFilter.bills,
            isActive: currentFilter == TransactionFilter.bills,
            textTheme: textTheme,
          ),
          const SizedBox(width: 6),
          _buildChip(
            context: context,
            ref: ref,
            label: 'Airtime',
            filter: TransactionFilter.airtime,
            isActive: currentFilter == TransactionFilter.airtime,
            textTheme: textTheme,
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required TransactionFilter filter,
    required bool isActive,
    required TextTheme textTheme,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(transactionsProvider.notifier).setFilter(filter);
        },
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? AppColors.primary
                  : AppColors.bgExtra,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: isActive
                  ? const Color(0xFF000000)
                  : AppColors.textSecondary,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
