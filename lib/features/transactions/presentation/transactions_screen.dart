import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transactions',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: Implement search functionality
                    },
                    icon: Icon(
                      Icons.search,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // TODO: Implement filter chips
              // TODO: Implement transaction list with date grouping
              Expanded(
                child: Center(
                  child: Text(
                    'Transactions Screen - Coming Soon',
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