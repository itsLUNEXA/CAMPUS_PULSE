import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../services/realtime_service.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class NotificationsScreen extends StatelessWidget {
  final RealtimeService realtimeService;
  final VoidCallback onBack;

  const NotificationsScreen({
    super.key,
    required this.realtimeService,
    required this.onBack,
  });

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
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppleButton(
                label: 'Back',
                variant: AppleButtonVariant.subtle,
                icon: Icons.arrow_back,
                height: 38,
                onPressed: onBack,
              ),
              const SizedBox(height: AppleTokens.space16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Live Activity & Notifications',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppleTokens.space4),
                      Text(
                        'Real-time streaming updates across campus events and quiz leaderboards.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppleTokens.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(
                        AppleTokens.radius999,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.wifi_tethering,
                          size: 14,
                          color: AppleTokens.success,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'WebSocket Live',
                          style: TextStyle(
                            color: AppleTokens.success,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppleTokens.space24),

              ListenableBuilder(
                listenable: realtimeService,
                builder: (context, _) {
                  final notifications = realtimeService.notifications;
                  if (notifications.isEmpty) {
                    return AppleCard(
                      padding: const EdgeInsets.all(AppleTokens.space40),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.notifications_off_outlined,
                              size: 48,
                              color: AppleTokens.secondaryText,
                            ),
                            const SizedBox(height: AppleTokens.space16),
                            Text(
                              'No Recent Activity Yet',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: AppleTokens.space8),
                            const Text(
                              'When classmates RSVP to events or complete quiz challenges, live updates will stream right here.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notif = notifications[index];
                      return _notificationTile(context, notif, isDark);
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

  Widget _notificationTile(
    BuildContext context,
    CampusNotification notif,
    bool isDark,
  ) {
    IconData icon = Icons.notifications_none_rounded;
    Color color = AppleTokens.primaryBlue;

    if (notif.type == 'event') {
      icon = Icons.event_available_rounded;
      color = AppleTokens.primaryBlue;
    } else if (notif.type == 'quiz') {
      icon = Icons.emoji_events_rounded;
      color = AppleTokens.warning;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppleTokens.space12),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: AppleTokens.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notif.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        _formatTime(notif.timestamp),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppleTokens.darkTextSecondary
                          : AppleTokens.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    final hour = local.hour > 12
        ? local.hour - 12
        : (local.hour == 0 ? 12 : local.hour);
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute $ampm';
  }
}
