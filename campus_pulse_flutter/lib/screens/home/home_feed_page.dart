import 'dart:async';
import 'package:flutter/material.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../../services/client_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/event_card.dart';
import '../../widgets/state_views.dart';
import 'create_event_sheet.dart';
import 'event_detail_page.dart';

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({super.key});

  @override
  State<HomeFeedPage> createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  final List<String> _categories = ['All', 'Tech', 'Sports', 'Cultural', 'Workshop'];
  String _selectedCategory = 'All';

  List<CampusEvent> _events = [];
  bool _isLoading = true;
  StreamSubscription<RsvpUpdate>? _rsvpSubscription;

  @override
  void initState() {
    super.initState();
    _loadEvents();

    // Listen to real-time WebSocket RSVP broadcasts
    _rsvpSubscription = ClientService.instance.rsvpUpdates.listen((update) {
      if (mounted) {
        setState(() {
          final idx = _events.indexWhere((e) => e.id == update.eventId);
          if (idx != -1) {
            _events[idx].rsvpCount = update.rsvpCount;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _rsvpSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadEvents() async {
    setState(() => _isLoading = true);
    final filter = _selectedCategory == 'All' ? null : _selectedCategory;
    final results = await ClientService.instance.getFeed(categoryFilter: filter);
    if (mounted) {
      setState(() {
        _events = results;
        _isLoading = false;
      });
    }
  }

  void _showCreateEventSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => CreateEventSheet(onEventCreated: _loadEvents),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.bolt_rounded, color: AppTheme.primary, size: 20),
            ),
            const SizedBox(width: 10),
            const Text('Campus Pulse Feed'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppTheme.textSecondary),
            tooltip: 'Refresh Feed',
            onPressed: _loadEvents,
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: _categories.map((cat) {
                return CategoryFilterChip(
                  label: cat,
                  isSelected: _selectedCategory == cat,
                  onSelected: () {
                    setState(() => _selectedCategory = cat);
                    _loadEvents();
                  },
                );
              }).toList(),
            ),
          ),

          // Main Event List
          Expanded(
            child: _isLoading
                ? const LoadingView(message: 'Syncing campus feed...')
                : _events.isEmpty
                    ? EmptyStateView(
                        icon: Icons.event_busy_rounded,
                        title: 'No Events in $_selectedCategory',
                        subtitle: 'Be the first to post an upcoming activity or meetup!',
                        actionLabel: 'Post Event',
                        onAction: _showCreateEventSheet,
                      )
                    : RefreshIndicator(
                        color: AppTheme.primary,
                        backgroundColor: AppTheme.surfaceDark,
                        onRefresh: _loadEvents,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _events.length,
                          itemBuilder: (context, index) {
                            final event = _events[index];
                            return EventCard(
                              event: event,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => EventDetailPage(event: event),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateEventSheet,
        backgroundColor: AppTheme.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Create Event',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
