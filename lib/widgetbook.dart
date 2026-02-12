import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/theme/app_theme.dart';
import 'features/home/presentation/widgets/balance_card.dart';
import 'features/home/presentation/widgets/quick_actions.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: [
        WidgetbookCategory(
          name: 'Home Widgets',
          children: [
            WidgetbookComponent(
              name: 'Balance Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const ProviderScope(
                    child: Scaffold(
                      backgroundColor: Color(0xFF050A0E),
                      body: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: BalanceCard(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Quick Actions',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => const Scaffold(
                    backgroundColor: Color(0xFF050A0E),
                    body: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: QuickActions(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
      appBuilder: (context, child) {
        return MaterialApp(
          theme: AppTheme.darkTheme,
          home: child,
        );
      },
    );
  }
}