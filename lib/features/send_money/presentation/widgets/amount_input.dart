import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../data/mock_data.dart';
import '../../providers/send_money_provider.dart';

/// Amount input widget with custom keypad
class AmountInput extends ConsumerStatefulWidget {
  const AmountInput({super.key});

  @override
  ConsumerState<AmountInput> createState() => _AmountInputState();
}

class _AmountInputState extends ConsumerState<AmountInput> {
  String _amountString = '';
  final _currencyFormat = NumberFormat.currency(
    symbol: 'KES ',
    decimalDigits: 2,
  );

  void _addDigit(String digit) {
    setState(() {
      // Limit to 2 decimal places
      if (_amountString.contains('.')) {
        final parts = _amountString.split('.');
        if (parts[1].length >= 2) {
          return;
        }
      }

      // Limit total length
      if (_amountString.replaceAll('.', '').length >= 8) {
        return;
      }

      _amountString += digit;
      _updateAmount();
    });
  }

  void _addDecimal() {
    if (!_amountString.contains('.') && _amountString.isNotEmpty) {
      setState(() {
        _amountString += '.';
      });
    }
  }

  void _removeDigit() {
    if (_amountString.isNotEmpty) {
      setState(() {
        _amountString = _amountString.substring(0, _amountString.length - 1);
        _updateAmount();
      });
    }
  }

  void _updateAmount() {
    final amount = double.tryParse(_amountString) ?? 0.0;
    ref.read(sendMoneyProvider.notifier).setAmount(amount);
  }

  void _setQuickAmount(double amount) {
    setState(() {
      _amountString = amount.toStringAsFixed(0);
      _updateAmount();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final sendMoneyState = ref.watch(sendMoneyProvider);
    final contact = sendMoneyState.selectedContact!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0C0F1C),
            colors.surface,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // Header with back button
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      ref.read(sendMoneyProvider.notifier).previousStep();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: colors.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Enter Amount',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Selected contact info
            Container(
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.primary.withOpacity(0.2),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Text(
                        contact.initials,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: colors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Name
                  Expanded(
                    child: Text(
                      contact.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.onSurface,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Phone number
                  Text(
                    contact.phoneNumber,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurface.withOpacity(0.5),
                          fontSize: 10,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Amount display box
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0D1F13),
                    Color(0xFF121E16),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: colors.primary.withOpacity(0.2),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'AMOUNT TO SEND',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.onSurface.withOpacity(0.6),
                          letterSpacing: 1.2,
                          fontSize: 10,
                        ),
                  ),
                  const SizedBox(height: 8),
                  // Amount display with cursor
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'KES ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.primary,
                              fontSize: 20,
                            ),
                      ),
                      Text(
                        _amountString.isEmpty ? '0' : _amountString,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colors.onSurface,
                              letterSpacing: -1,
                            ),
                      ),
                      // Blinking cursor
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 500),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Container(
                              width: 2,
                              height: 40,
                              margin: const EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(
                                color: colors.primary,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          );
                        },
                        onEnd: () {
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Available: ${_currencyFormat.format(MockData.initialBalance)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurface.withOpacity(0.5),
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Quick amount chips
            Row(
              children: [
                _QuickAmountChip(
                  amount: 500,
                  onTap: () => _setQuickAmount(500),
                ),
                const SizedBox(width: 8),
                _QuickAmountChip(
                  amount: 1000,
                  onTap: () => _setQuickAmount(1000),
                ),
                const SizedBox(width: 8),
                _QuickAmountChip(
                  amount: 2000,
                  onTap: () => _setQuickAmount(2000),
                ),
                const SizedBox(width: 8),
                _QuickAmountChip(
                  amount: 5000,
                  onTap: () => _setQuickAmount(5000),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Custom keypad
            Expanded(
              child: _CustomKeypad(
                onDigitPressed: _addDigit,
                onDecimalPressed: _addDecimal,
                onDeletePressed: _removeDigit,
              ),
            ),
            const SizedBox(height: 12),
            // Error message
            if (sendMoneyState.error != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: colors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colors.error.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      size: 16,
                      color: colors.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        sendMoneyState.error!,
                        style: TextStyle(
                          color: colors.error,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // Send button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: sendMoneyState.amount > 0
                    ? () {
                        ref.read(sendMoneyProvider.notifier).nextStep();
                      }
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.black,
                  disabledBackgroundColor:
                      colors.surfaceContainerHighest.withOpacity(0.5),
                  disabledForegroundColor:
                      colors.onSurface.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  sendMoneyState.amount > 0
                      ? 'Send ${_currencyFormat.format(sendMoneyState.amount)} →'
                      : 'Enter amount to continue',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Quick amount chip
class _QuickAmountChip extends StatelessWidget {
  const _QuickAmountChip({
    required this.amount,
    required this.onTap,
  });

  final double amount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colors.outline.withOpacity(0.1),
            ),
          ),
          child: Center(
            child: Text(
              amount.toStringAsFixed(0),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom numeric keypad
class _CustomKeypad extends StatelessWidget {
  const _CustomKeypad({
    required this.onDigitPressed,
    required this.onDecimalPressed,
    required this.onDeletePressed,
  });

  final void Function(String) onDigitPressed;
  final VoidCallback onDecimalPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _KeypadButton(
          label: '1',
          onPressed: () => onDigitPressed('1'),
        ),
        _KeypadButton(
          label: '2',
          onPressed: () => onDigitPressed('2'),
        ),
        _KeypadButton(
          label: '3',
          onPressed: () => onDigitPressed('3'),
        ),
        _KeypadButton(
          label: '4',
          onPressed: () => onDigitPressed('4'),
        ),
        _KeypadButton(
          label: '5',
          onPressed: () => onDigitPressed('5'),
        ),
        _KeypadButton(
          label: '6',
          onPressed: () => onDigitPressed('6'),
        ),
        _KeypadButton(
          label: '7',
          onPressed: () => onDigitPressed('7'),
        ),
        _KeypadButton(
          label: '8',
          onPressed: () => onDigitPressed('8'),
        ),
        _KeypadButton(
          label: '9',
          onPressed: () => onDigitPressed('9'),
        ),
        _KeypadButton(
          label: '.',
          onPressed: onDecimalPressed,
          textColor: colors.onSurface.withOpacity(0.6),
        ),
        _KeypadButton(
          label: '0',
          onPressed: () => onDigitPressed('0'),
        ),
        _KeypadButton(
          icon: Icons.backspace_outlined,
          onPressed: onDeletePressed,
        ),
      ],
    );
  }
}

/// Keypad button widget
class _KeypadButton extends StatelessWidget {
  const _KeypadButton({
    this.label,
    this.icon,
    required this.onPressed,
    this.textColor,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.outline.withOpacity(0.1),
          ),
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: colors.onSurface.withOpacity(0.6),
                  size: 22,
                )
              : Text(
                  label!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: textColor ?? colors.onSurface,
                  ),
                ),
        ),
      ),
    );
  }
}
