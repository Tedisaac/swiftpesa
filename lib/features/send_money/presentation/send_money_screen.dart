import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/mock_data.dart';
import '../providers/send_money_provider.dart';
import 'widgets/contact_picker.dart';
import 'widgets/amount_input.dart';
import 'widgets/pin_bottom_sheet.dart';

/// Send money screen - multi-step flow
class SendMoneyScreen extends ConsumerWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sendMoneyState = ref.watch(sendMoneyProvider);
    final colors = Theme.of(context).colorScheme;

    return PopScope(
      canPop: sendMoneyState.currentStep == SendMoneyStep.selectContact,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          ref.read(sendMoneyProvider.notifier).previousStep();
        }
      },
      child: Scaffold(
        backgroundColor: colors.surface,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: switch (sendMoneyState.currentStep) {
                  SendMoneyStep.selectContact => const ContactPicker(),
                  SendMoneyStep.enterAmount => const AmountInput(),
                  SendMoneyStep.confirmPin => const PinBottomSheet(),
                  SendMoneyStep.success => _buildSuccessScreen(
                      context,
                      ref,
                      sendMoneyState,
                    ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessScreen(
    BuildContext context,
    WidgetRef ref,
    SendMoneyState state,
  ) {
    final colors = Theme.of(context).colorScheme;
    final transaction = state.completedTransaction!;
    final contact = state.selectedContact!;

    // Calculate new balance
    final newBalance = MockData.initialBalance - state.amount;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF061310),
            const Color(0xFF0A1A12),
            colors.surface,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Success ring with pulse animation
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary.withOpacity(0.12),
                      border: Border.all(
                        color: colors.primary.withOpacity(0.4),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer pulse ring
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.primary.withOpacity(0.15),
                            ),
                          ),
                        ),
                        // Checkmark
                        Icon(
                          Icons.check_rounded,
                          size: 40,
                          color: colors.primary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            // Success title
            Text(
              'Transfer Sent!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'KES ${state.amount.toStringAsFixed(2)} successfully sent to ${contact.name}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurface.withOpacity(0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Amount display
            Text(
              'KES ${state.amount.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                    letterSpacing: -0.5,
                  ),
            ),
            const SizedBox(height: 24),
            // Transaction details card
            Container(
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colors.primary.withOpacity(0.12),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDetailRow(
                    context,
                    'Transaction ID',
                    transaction.id,
                    isPrimary: true,
                  ),
                  const Divider(height: 16),
                  _buildDetailRow(
                    context,
                    'Recipient',
                    contact.name,
                  ),
                  const Divider(height: 16),
                  _buildDetailRow(
                    context,
                    'Phone',
                    contact.phoneNumber,
                  ),
                  const Divider(height: 16),
                  _buildDetailRow(
                    context,
                    'Date & Time',
                    _formatDateTime(transaction.date),
                  ),
                  const Divider(height: 16),
                  _buildDetailRow(
                    context,
                    'Balance After',
                    'KES ${newBalance.toStringAsFixed(2)}',
                    isPrimary: true,
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Action buttons
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () {
                  // TODO: Implement share receipt
                  debugPrint('Share receipt');
                },
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Share Receipt',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  ref.read(sendMoneyProvider.notifier).reset();
                  context.pop();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primary,
                  side: BorderSide(
                    color: colors.primary.withOpacity(0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    bool isPrimary = false,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.onSurface.withOpacity(0.6),
                fontSize: 11,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isPrimary ? colors.primary : colors.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 11,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      final month = _getMonthName(date.month);
      final hour = date.hour > 12 ? date.hour - 12 : date.hour;
      final amPm = date.hour >= 12 ? 'PM' : 'AM';
      return '${date.day} $month, $hour:${date.minute.toString().padLeft(2, '0')} $amPm';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
