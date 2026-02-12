import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
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
              // TODO: Navigate to Send Money
            },
          ),
          _ActionItem(
            icon: Icons.arrow_downward,
            label: 'Receive',
            color: AppColors.warning,
            onTap: () {
              // TODO: Navigate to Receive Money
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
    required final this.icon,
    required final this.label,
    required final this.color,
    required final this.onTap,
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
