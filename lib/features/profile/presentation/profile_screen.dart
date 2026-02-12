import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

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
                'Profile',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.onSurface,
                    ),
              ),
              const SizedBox(height: 24),
              // TODO: Implement user avatar and basic info
              // TODO: Implement settings options
              // TODO: Implement security options
              // TODO: Implement about section with disclaimer
              Expanded(
                child: Center(
                  child: Text(
                    'Profile Screen - Coming Soon',
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