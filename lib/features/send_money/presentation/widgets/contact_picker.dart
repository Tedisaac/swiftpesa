import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../models/contact.dart';
import '../../providers/send_money_provider.dart';

/// Contact picker widget for send money flow
class ContactPicker extends ConsumerStatefulWidget {
  const ContactPicker({super.key});

  @override
  ConsumerState<ContactPicker> createState() => _ContactPickerState();
}

class _ContactPickerState extends ConsumerState<ContactPicker> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final filteredContacts = ref.watch(filteredContactsProvider);
    final sendMoneyState = ref.watch(sendMoneyProvider);

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    onPressed: () => context.pop(),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 18,
                      color: colors.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Send Money',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Search field
            Container(
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colors.outline.withOpacity(0.1),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: colors.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colors.onSurface,
                          ),
                      decoration: InputDecoration(
                        hintText: 'Search name or number...',
                        hintStyle: TextStyle(
                          color: colors.onSurface.withOpacity(0.4),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      onChanged: (value) {
                        ref.read(contactSearchProvider.notifier).state = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Recent contacts label
            Text(
              'RECENT CONTACTS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.onSurface.withOpacity(0.5),
                    letterSpacing: 1.2,
                    fontSize: 10,
                  ),
            ),
            const SizedBox(height: 12),
            // Contacts list
            Expanded(
              child: filteredContacts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search_rounded,
                            size: 64,
                            color: colors.onSurface.withOpacity(0.2),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No contacts found',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: colors.onSurface.withOpacity(0.5),
                                ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: filteredContacts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final contact = filteredContacts[index];
                        final isSelected =
                            sendMoneyState.selectedContact?.id == contact.id;

                        return _ContactTile(
                          contact: contact,
                          isSelected: isSelected,
                          onTap: () {
                            ref
                                .read(sendMoneyProvider.notifier)
                                .selectContact(contact);
                          },
                        );
                      },
                    ),
            ),
            // Continue button
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: sendMoneyState.selectedContact != null
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: sendMoneyState.selectedContact != null
                          ? Colors.black
                          : colors.onSurface.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Contact tile widget
class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.contact,
    required this.isSelected,
    required this.onTap,
  });

  final Contact contact;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary.withOpacity(0.08)
              : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colors.primary.withOpacity(0.4)
                : Colors.transparent,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getAvatarColor(contact.initials[0], colors),
              ),
              child: Center(
                child: Text(
                  contact.initials,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _getAvatarTextColor(contact.initials[0], colors),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Contact info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact.phoneNumber,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurface.withOpacity(0.5),
                          fontSize: 11,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                  ),
                ],
              ),
            ),
            // Check icon if selected
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: colors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Color _getAvatarColor(String initial, ColorScheme colors) {
    final code = initial.codeUnitAt(0);
    final index = code % 4;

    return switch (index) {
      0 => colors.primary.withOpacity(0.15),
      1 => colors.tertiary.withOpacity(0.15),
      2 => colors.error.withOpacity(0.12),
      _ => colors.secondary.withOpacity(0.12),
    };
  }

  Color _getAvatarTextColor(String initial, ColorScheme colors) {
    final code = initial.codeUnitAt(0);
    final index = code % 4;

    return switch (index) {
      0 => colors.primary,
      1 => colors.tertiary,
      2 => colors.error,
      _ => colors.secondary,
    };
  }
}
