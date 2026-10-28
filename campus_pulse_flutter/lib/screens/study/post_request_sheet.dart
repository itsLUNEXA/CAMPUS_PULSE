import 'package:flutter/material.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../../services/client_service.dart';
import '../../services/auth_state.dart';
import '../../theme/app_theme.dart';

class PostRequestSheet extends StatefulWidget {
  final VoidCallback onRequestCreated;

  const PostRequestSheet({super.key, required this.onRequestCreated});

  @override
  State<PostRequestSheet> createState() => _PostRequestSheetState();
}

class _PostRequestSheetState extends State<PostRequestSheet> {
  String _subject = 'DSA';
  final _locationController = TextEditingController(text: 'Library Reading Room 2');
  bool _isLoading = false;

  final List<String> _subjects = ['DSA', 'DBMS', 'OS', 'AI', 'Networks', 'Mathematics'];

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final location = _locationController.text.trim();
    if (location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter preferred study location.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final currentStudent = AuthState.instance.currentStudent;
    final req = StudyRequest(
      studentId: currentStudent?.id ?? 1,
      studentName: currentStudent?.name ?? 'Anonymous Student',
      branch: currentStudent?.branch ?? 'Computer Science',
      subject: _subject,
      location: location,
      status: 'open',
      createdAt: DateTime.now(),
    );

    try {
      await ClientService.instance.createRequest(req);
      if (!mounted) return;
      Navigator.of(context).pop();
      widget.onRequestCreated();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('📘 Study buddy request posted live!')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error posting request: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Post Study Buddy Request',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.textMuted),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _subject,
              dropdownColor: AppTheme.surfaceDark,
              decoration: const InputDecoration(labelText: 'Subject of Study'),
              items: _subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _subject = val);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Campus Location / Hostel Area',
                hintText: 'e.g., Central Library 2nd Floor',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Post Study Request'),
            ),
          ],
        ),
      ),
    );
  }
}
