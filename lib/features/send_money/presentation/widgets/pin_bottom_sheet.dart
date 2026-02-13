import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/send_money_provider.dart';

/// PIN confirmation screen with keypad
class PinBottomSheet extends ConsumerWidget {
  const PinBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final sendMoneyState = ref.watch(sendMoneyProvider);
    final contact = sendMoneyState.selectedContact!;
    final currencyFormat = NumberFormat.currency(
      symbol: 'KES ',
      decimalDigits: 2,
    );

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0A0F15),
            colors.surface,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Lock icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: colors.primary.withOpacity(0.3),
                ),
              ),
              child: Icon(
                Icons.lock_rounded,
                size: 32,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              'Confirm PIN',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Enter your 4-digit PIN to complete the transfer',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurface.withOpacity(0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Transaction summary
            Container(
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.primary.withOpacity(0.12),
                ),
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SENDING TO',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colors.onSurface.withOpacity(0.6),
                                    letterSpacing: 1.2,
                                    fontSize: 9,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          contact.name,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colors.onSurface,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          contact.phoneNumber,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: colors.onSurface.withOpacity(0.5),
                                    fontSize: 10,
                                    fontFeatures: const [
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  // Amount
                  Text(
                    currencyFormat.format(sendMoneyState.amount),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.primary,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            // PIN dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => _PinDot(
                  isFilled: index < sendMoneyState.pin.length,
                  index: index,
                ),
              ),
            ),
            const SizedBox(height: 28),
            // Keypad
            Expanded(
              child: _PinKeypad(
                onDigitPressed: (digit) {
                  ref.read(sendMoneyProvider.notifier).addPinDigit(digit);
                },
                onDeletePressed: () {
                  ref.read(sendMoneyProvider.notifier).removePinDigit();
                },
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
            // Biometrics option
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement biometric authentication
                  debugPrint('Biometric auth');
                },
                icon: const Icon(Icons.fingerprint_rounded, size: 20),
                label: const Text(
                  'Use Biometrics',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.primary,
                  side: BorderSide(
                    color: colors.primary.withOpacity(0.3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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

/// PIN dot widget with animation
class _PinDot extends StatefulWidget {
  const _PinDot({
    required this.isFilled,
    required this.index,
  });

  final bool isFilled;
  final int index;

  @override
  State<_PinDot> createState() => _PinDotState();
}

class _PinDotState extends State<_PinDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void didUpdateWidget(_PinDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFilled && !oldWidget.isFilled) {
      _controller.forward();
    } else if (!widget.isFilled && oldWidget.isFilled) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.isFilled ? _scaleAnimation.value : 1.0,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isFilled
                    ? colors.primary
                    : Colors.transparent,
                border: Border.all(
                  color: widget.isFilled
                      ? colors.primary
                      : colors.outline.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: widget.isFilled
                    ? [
                        BoxShadow(
                          color: colors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// PIN keypad widget
class _PinKeypad extends StatelessWidget {
  const _PinKeypad({
    required this.onDigitPressed,
    required this.onDeletePressed,
  });

  final void Function(String) onDigitPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _PinKeypadButton(
          label: '1',
          onPressed: () => onDigitPressed('1'),
        ),
        _PinKeypadButton(
          label: '2',
          onPressed: () => onDigitPressed('2'),
        ),
        _PinKeypadButton(
          label: '3',
          onPressed: () => onDigitPressed('3'),
        ),
        _PinKeypadButton(
          label: '4',
          onPressed: () => onDigitPressed('4'),
        ),
        _PinKeypadButton(
          label: '5',
          onPressed: () => onDigitPressed('5'),
        ),
        _PinKeypadButton(
          label: '6',
          onPressed: () => onDigitPressed('6'),
        ),
        _PinKeypadButton(
          label: '7',
          onPressed: () => onDigitPressed('7'),
        ),
        _PinKeypadButton(
          label: '8',
          onPressed: () => onDigitPressed('8'),
        ),
        _PinKeypadButton(
          label: '9',
          onPressed: () => onDigitPressed('9'),
        ),
        const SizedBox.shrink(), // Empty space
        _PinKeypadButton(
          label: '0',
          onPressed: () => onDigitPressed('0'),
        ),
        _PinKeypadButton(
          icon: Icons.backspace_outlined,
          onPressed: onDeletePressed,
        ),
      ],
    );
  }
}

/// PIN keypad button widget
class _PinKeypadButton extends StatelessWidget {
  const _PinKeypadButton({
    this.label,
    this.icon,
    required this.onPressed,
  });

  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      splashColor: colors.primary.withOpacity(0.1),
      highlightColor: colors.primary.withOpacity(0.05),
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
                    color: colors.onSurface,
                  ),
                ),
        ),
      ),
    );
  }
}