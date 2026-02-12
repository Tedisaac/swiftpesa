import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendReceiveScreen extends ConsumerWidget {
  const SendReceiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Send & Receive',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
              ),
              const SizedBox(height: 24),
              // TODO: Implement send money card
              // TODO: Implement receive money card
              // TODO: Implement recent recipients
              Expanded(
                child: Center(
                  child: Text(
                    'Send & Receive Screen - Coming Soon',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colors.onSurface.withOpacity(0.5),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}