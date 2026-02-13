import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../models/transactions.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    required this.transaction,
    this.showStatus = false,
    super.key,
  });

  final Transaction transaction;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Avatar with initials
          _buildAvatar(),
          const SizedBox(width: 12),
          // Transaction details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      showStatus
                          ? _formatDateTimeWithType()
                          : _formatDateTime(transaction.date),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (showStatus) ...[
                      const SizedBox(width: 8),
                      _buildStatusBadge(textTheme),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatAmount(),
                style: textTheme.bodyLarge?.copyWith(
                  color: _getAmountColor(),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build avatar circle with colored background based on transaction type
  Widget _buildAvatar() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getAvatarBackgroundColor(),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          transaction.initials,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Get avatar background color based on transaction type
  Color _getAvatarBackgroundColor() {
    switch (transaction.type) {
      case TransactionType.sent:
        return AppColors.sentMoney.withOpacity(0.15);
      case TransactionType.received:
        return AppColors.receivedMoney.withOpacity(0.15);
      case TransactionType.bill:
        return AppColors.billPayment.withOpacity(0.15);
      case TransactionType.airtime:
        return AppColors.airtime.withOpacity(0.15);
    }
  }

  /// Get amount color based on transaction type
  Color _getAmountColor() {
    switch (transaction.type) {
      case TransactionType.sent:
      case TransactionType.bill:
      case TransactionType.airtime:
        return AppColors.sentMoney;
      case TransactionType.received:
        return AppColors.receivedMoney;
    }
  }

  /// Format amount with KES prefix and +/- sign
  String _formatAmount() {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    final formattedAmount = formatter.format(transaction.amount);

    switch (transaction.type) {
      case TransactionType.sent:
      case TransactionType.bill:
      case TransactionType.airtime:
        return '-KES $formattedAmount';
      case TransactionType.received:
        return '+KES $formattedAmount';
    }
  }

  /// Format date/time for display
  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d, y').format(date);
    }
  }

  /// Format date/time with transaction type (for detailed view)
  String _formatDateTimeWithType() {
    final time = DateFormat('h:mm a').format(transaction.date);
    final typeLabel = _getTypeLabel();
    return '$time • $typeLabel';
  }

  /// Get transaction type label
  String _getTypeLabel() {
    switch (transaction.type) {
      case TransactionType.sent:
        return 'Sent';
      case TransactionType.received:
        return 'Received';
      case TransactionType.bill:
        return 'Bill Payment';
      case TransactionType.airtime:
        return 'Airtime';
    }
  }

  /// Build status badge
  Widget _buildStatusBadge(TextTheme textTheme) {
    final Color bgColor;
    final Color textColor;
    final String label;

    switch (transaction.status) {
      case TransactionStatus.completed:
        bgColor = AppColors.primary.withOpacity(0.15);
        textColor = AppColors.primary;
        label = 'Done';
        break;
      case TransactionStatus.pending:
        bgColor = AppColors.warning.withOpacity(0.15);
        textColor = AppColors.warning;
        label = 'Pending';
        break;
      case TransactionStatus.failed:
        bgColor = AppColors.danger.withOpacity(0.15);
        textColor = AppColors.danger;
        label = 'Failed';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}