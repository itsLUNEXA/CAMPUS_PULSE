import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../services/realtime_service.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class NotificationsScreen extends StatefulWidget {
  final RealtimeService realtimeService;
  final VoidCallback onBack;
  final void Function(String route)? onNavigate;
  final void Function(String route, String? targetId)? onNavigateWithTarget;

  const NotificationsScreen({
    super.key,
    required this.realtimeService,
    required this.onBack,
    this.onNavigate,
    this.onNavigateWithTarget,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Events',
    'Study Buddies',
    'Academics',
    'Rewards',
  ];

  @override
  void initState() {
    super.initState();
    widget.realtimeService.refreshNotifications();
  }

  bool _matchesCategory(CampusNotification notif, String category) {
    if (category == 'All') return true;
    final type = notif.type.toLowerCase();
    switch (category) {
      case 'Events':
        return type.contains('event') || type.contains('rsvp');
      case 'Study Buddies':
        return type.contains('study');
      case 'Academics':
        return type.contains('academic') ||
            type.contains('resource') ||
            type.contains('timetable');
      case 'Rewards':
        return type.contains('reward') ||
            type.contains('point') ||
            type.contains('streak');
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              AppleButton(
                label: 'Back',
                variant: AppleButtonVariant.subtle,
                icon: Icons.arrow_back,
                height: 38,
                onPressed: widget.onBack,
              ),
              const SizedBox(height: AppleTokens.space16),

              // Header Title & Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications & Activity',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppleTokens.darkTextPrimary
                                    : AppleTokens.primaryText,
                              ),
                        ),
                        const SizedBox(height: AppleTokens.space4),
                        Text(
                          'Real-time campus updates, RSVP alerts, academic review decisions, and rewards.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isDark
                                    ? AppleTokens.darkTextSecondary
                                    : AppleTokens.secondaryText,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppleTokens.space12),
                  ListenableBuilder(
                    listenable: widget.realtimeService,
                    builder: (context, _) {
                      final unread = widget.realtimeService.unreadCount;
                      return Row(
                        children: [
                          if (unread > 0)
                            AppleButton(
                              label: 'Mark all as read',
                              variant: AppleButtonVariant.subtle,
                              icon: Icons.done_all_rounded,
                              height: 36,
                              onPressed: () {
                                widget.realtimeService.markAllAsRead();
                              },
                            ),
                          const SizedBox(width: AppleTokens.space8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppleTokens.primaryTeal.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(
                                AppleTokens.radius999,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.wifi_tethering,
                                  size: 13,
                                  color: AppleTokens.primaryTeal,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Live Connected',
                                  style: TextStyle(
                                    color: AppleTokens.primaryTeal,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: AppleTokens.space20),

              // Filter Category Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _categories.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: isSelected,
                        label: Text(cat),
                        labelStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? AppleTokens.primaryButtonText
                              : (isDark
                                    ? AppleTokens.darkTextPrimary
                                    : AppleTokens.primaryText),
                        ),
                        selectedColor: AppleTokens.primaryTeal,
                        backgroundColor: isDark
                            ? AppleTokens.darkSurface
                            : AppleTokens.cardSurface,
                        side: BorderSide(
                          color: isSelected
                              ? AppleTokens.primaryTeal
                              : (isDark
                                    ? AppleTokens.darkBorder
                                    : AppleTokens.border),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius999,
                          ),
                        ),
                        onSelected: (val) {
                          setState(() {
                            _selectedCategory = cat;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: AppleTokens.space24),

              // List of Notifications
              ListenableBuilder(
                listenable: widget.realtimeService,
                builder: (context, _) {
                  final allNotifications = widget.realtimeService.notifications;
                  final filtered = allNotifications
                      .where((n) => _matchesCategory(n, _selectedCategory))
                      .toList();

                  if (filtered.isEmpty) {
                    return AppleCard(
                      padding: const EdgeInsets.all(AppleTokens.space40),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppleTokens.lightMint,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.notifications_none_rounded,
                                size: 28,
                                color: AppleTokens.primaryTeal,
                              ),
                            ),
                            const SizedBox(height: AppleTokens.space16),
                            Text(
                              _selectedCategory == 'All'
                                  ? 'No Notifications Yet'
                                  : 'No $_selectedCategory Notifications',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: AppleTokens.space8),
                            Text(
                              'When updates arrive regarding your events, academic materials, or study buddies, they will appear here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark
                                    ? AppleTokens.darkTextSecondary
                                    : AppleTokens.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppleTokens.space12),
                    itemBuilder: (context, index) {
                      final notif = filtered[index];
                      return _buildNotificationCard(context, notif, isDark);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    CampusNotification notif,
    bool isDark,
  ) {
    IconData icon = Icons.notifications_rounded;
    Color iconBg = AppleTokens.lightMint;
    Color iconColor = AppleTokens.primaryTeal;

    final type = notif.type.toLowerCase();
    if (type.contains('study')) {
      icon = Icons.group_rounded;
      iconBg = AppleTokens.lightCyan;
      iconColor = AppleTokens.primaryTeal;
    } else if (type.contains('event')) {
      icon = Icons.event_available_rounded;
      iconBg = AppleTokens.lightBlue;
      iconColor = AppleTokens.highlightBlue;
    } else if (type.contains('reward') || type.contains('point')) {
      icon = Icons.redeem_rounded;
      iconBg = AppleTokens.lightLavender;
      iconColor = const Color(0xFF705EFF);
    } else if (type.contains('academic') || type.contains('timetable')) {
      icon = Icons.school_rounded;
      iconBg = AppleTokens.lightMint;
      iconColor = AppleTokens.primaryTeal;
    }

    return InkWell(
      onTap: () {
        if (!notif.isRead && notif.id != null) {
          widget.realtimeService.markAsRead(notif.id!);
        }
        if (notif.targetRoute != null && notif.targetRoute!.isNotEmpty) {
          if (widget.onNavigateWithTarget != null) {
            widget.onNavigateWithTarget!(notif.targetRoute!, notif.targetId);
          } else if (widget.onNavigate != null) {
            widget.onNavigate!(notif.targetRoute!);
          }
        }
      },
      borderRadius: BorderRadius.circular(AppleTokens.radius12),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space16),
        backgroundColor: notif.isRead
            ? (isDark ? AppleTokens.darkSurface : AppleTokens.cardSurface)
            : (isDark
                  ? AppleTokens.darkSurfaceElevated
                  : AppleTokens.lightMint.withValues(alpha: 0.25)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: AppleTokens.space16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notif.title,
                          style: TextStyle(
                            fontWeight: notif.isRead
                                ? FontWeight.w600
                                : FontWeight.w700,
                            fontSize: 15,
                            color: isDark
                                ? AppleTokens.darkTextPrimary
                                : AppleTokens.primaryText,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(notif.createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.mutedText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.message,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: isDark
                          ? AppleTokens.darkTextSecondary
                          : AppleTokens.secondaryText,
                    ),
                  ),
                  if (notif.targetRoute != null &&
                      notif.targetRoute!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Tap to view ${notif.targetRoute!.replaceAll('_', ' ')} →',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppleTokens.primaryTeal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Unread dot indicator
            if (!notif.isRead) ...[
              const SizedBox(width: 8),
              Container(
                width: 9,
                height: 9,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppleTokens.primaryTeal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    final now = DateTime.now();
    final diff = now.difference(local);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    final hour = local.hour > 12
        ? local.hour - 12
        : (local.hour == 0 ? 12 : local.hour);
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    final minute = local.minute.toString().padLeft(2, '0');
    return '${local.day}/${local.month} $hour:$minute $ampm';
  }
}
