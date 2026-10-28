import 'package:flutter/material.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../../services/client_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buddy_card.dart';
import '../../widgets/state_views.dart';
import 'post_request_sheet.dart';

class StudyTabPage extends StatefulWidget {
  const StudyTabPage({super.key});

  @override
  State<StudyTabPage> createState() => _StudyTabPageState();
}

class _StudyTabPageState extends State<StudyTabPage> {
  String _selectedSubject = 'DSA';
  final _locationController = TextEditingController(text: 'Block A');
  final List<String> _subjects = ['DSA', 'DBMS', 'OS', 'AI', 'Networks', 'Mathematics'];

  List<Student> _buddies = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchBuddies();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _searchBuddies() async {
    setState(() {
      _isLoading = true;
    });

    final results = await ClientService.instance.findBuddies(
      _selectedSubject,
      _locationController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _buddies = results;
        _isLoading = false;
      });
    }
  }

  void _showPostRequestSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => PostRequestSheet(onRequestCreated: _searchBuddies),
    );
  }

  void _sendStudyInvite(Student student) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title: Text('Invite ${student.name}'),
        content: Text(
          'Would you like to send a study invite for $_selectedSubject to ${student.name} (${student.hostelArea})?',
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('📨 Study invite sent to ${student.name}!'),
                  backgroundColor: AppTheme.success,
                ),
              );
            },
            child: const Text('Send Invite'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Buddy Finder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppTheme.primary),
            tooltip: 'Post Request',
            onPressed: _showPostRequestSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Panel
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppTheme.surfaceDark,
              border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField<String>(
                        value: _selectedSubject,
                        decoration: const InputDecoration(
                          labelText: 'Subject',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                        dropdownColor: AppTheme.surfaceDark,
                        items: _subjects
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedSubject = val);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Hostel / Location',
                          hintText: 'e.g. Block A',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _searchBuddies,
                        icon: const Icon(Icons.search_rounded, size: 18),
                        label: const Text('Find Matching Buddies'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: _showPostRequestSheet,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.primary),
                        foregroundColor: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Post Request'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search Results Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Matching Peers (${_buddies.length})',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Targeting: $_selectedSubject',
                  style: const TextStyle(
                    color: AppTheme.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Buddies List
          Expanded(
            child: _isLoading
                ? const LoadingView(message: 'Finding peers near you...')
                : _buddies.isEmpty
                    ? EmptyStateView(
                        icon: Icons.person_search_rounded,
                        title: 'No Matching Buddies Found',
                        subtitle: 'Try changing location or post a study request for $_selectedSubject.',
                        actionLabel: 'Post Study Request',
                        onAction: _showPostRequestSheet,
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _buddies.length,
                        itemBuilder: (context, index) {
                          final buddy = _buddies[index];
                          return BuddyCard(
                            student: buddy,
                            onConnect: () => _sendStudyInvite(buddy),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
