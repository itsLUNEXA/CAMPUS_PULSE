import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../theme/app_theme.dart';

class EventCard extends StatelessWidget {
  final CampusEvent event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'tech':
        return AppTheme.primary;
      case 'sports':
        return AppTheme.accent;
      case 'cultural':
        return const Color(0xFFEC4899);
      case 'workshop':
        return AppTheme.warning;
      default:
        return AppTheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final catColor = _getCategoryColor(event.category);
    final dateFormatted = DateFormat('EEE, MMM d • h:mm a').format(event.startTime);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: AppTheme.primary.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: catColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: catColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      event.category.toUpperCase(),
                      style: TextStyle(
                        color: catColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.people_alt_rounded, size: 14, color: AppTheme.success),
                        const SizedBox(width: 5),
                        Text(
                          '${event.rsvpCount} RSVPs',
                          style: const TextStyle(
                            color: AppTheme.success,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                event.title,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                event.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: AppTheme.borderDark, height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 14, color: AppTheme.textMuted),
                  const SizedBox(width: 6),
                  Text(
                    dateFormatted,
                    style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                  ),
                  const Spacer(),
                  const Icon(Icons.location_on_outlined, size: 14, color: AppTheme.textMuted),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      event.venue,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
