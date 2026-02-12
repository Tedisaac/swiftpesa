import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReceiveScreen extends ConsumerWidget {
  const ReceiveScreen({super.key});

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
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Receive',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // TODO: Implement QR code display
              // TODO: Implement payment link with copy button
              // TODO: Implement share options
              Expanded(
                child: Center(
                  child: Text(
                    'Receive Screen - Coming Soon',
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