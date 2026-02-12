import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    required this.currentRoute,
    super.key,
  });

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSecondary,
        border: Border(
          top: BorderSide(
            color: Color(0x0DFFFFFF),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                isActive: currentRoute == '/',
                onTap: () => context.go('/'),
              ),
              _NavItem(
                icon: Icons.swap_vert_rounded,
                isActive: currentRoute == '/send-receive',
                onTap: () => context.go('/send-receive'),
              ),
              _NavItem(
                icon: Icons.receipt_long_rounded,
                isActive: currentRoute == '/transactions',
                onTap: () => context.go('/transactions'),
              ),
              _NavItem(
                icon: Icons.person_rounded,
                isActive: currentRoute == '/profile',
                onTap: () => context.go('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: AppColors.textPrimary.withOpacity(isActive ? 1.0 : 0.4),
            ),
            const SizedBox(height: 4),
            // Active dot indicator
            if (isActive)
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}