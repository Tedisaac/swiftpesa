import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../send_money/providers/send_money_provider.dart';

class QuickActions extends ConsumerWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ActionItem(
            icon: Icons.arrow_upward,
            label: 'Send',
            color: AppColors.primary,
            onTap: () {
              // Reset send money state before navigating
              ref.read(sendMoneyProvider.notifier).reset();
              context.push('/send-money');
            },
          ),
          _ActionItem(
            icon: Icons.arrow_downward,
            label: 'Receive',
            color: AppColors.warning,
            onTap: () {
              context.push('/receive');
            },
          ),
          _ActionItem(
            icon: Icons.receipt_long_outlined,
            label: 'Pay Bill',
            color: AppColors.info,
            onTap: () {
              // TODO: Navigate to Pay Bill
            },
          ),
          _ActionItem(
            icon: Icons.smartphone_outlined,
            label: 'Airtime',
            color: AppColors.danger,
            onTap: () {
              // TODO: Navigate to Airtime
            },
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: color.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
