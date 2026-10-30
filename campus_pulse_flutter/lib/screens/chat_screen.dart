import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';

class ChatScreen extends StatefulWidget {
  final AuthState authState;
  final Function(String route, Widget screen) onNavigate;

  const ChatScreen({
    super.key,
    required this.authState,
    required this.onNavigate,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatRoom> _rooms = [];
  ChatRoom? _selectedRoom;
  List<ChatMessage> _messages = [];
  bool _isLoadingRooms = true;
  String? _roomsError;
  bool _isLoadingMessages = false;
  final _msgController = TextEditingController();
  StreamSubscription<ChatMessage>? _messageSub;

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  @override
  void dispose() {
    _messageSub?.cancel();
    _msgController.dispose();
    super.dispose();
  }

  Future<void> _loadRooms() async {
    setState(() {
      _isLoadingRooms = true;
      _roomsError = null;
    });

    try {
      final rooms = await client.chat.listAllAccessibleRooms();
      if (mounted) {
        setState(() {
          _rooms = rooms;
          _isLoadingRooms = false;
          _roomsError = null;

          if (_selectedRoom != null) {
            final match = _rooms
                .where((r) => r.id == _selectedRoom!.id)
                .firstOrNull;
            if (match != null) {
              _selectedRoom = match;
            }
          } else if (_rooms.isNotEmpty) {
            final myUserId = widget.authState.currentProfile?.authUserId;
            final myRooms = _rooms
                .where(
                  (r) =>
                      myUserId != null && r.participantIds.contains(myUserId),
                )
                .toList();
            if (myRooms.isNotEmpty) {
              _selectRoom(myRooms.first);
            } else {
              _selectRoom(_rooms.first);
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingRooms = false;
          _roomsError = e.toString();
        });
      }
    }
  }

  Future<void> _selectRoom(ChatRoom room) async {
    _messageSub?.cancel();
    setState(() {
      _selectedRoom = room;
      _isLoadingMessages = true;
    });

    try {
      if (room.id != null) {
        final msgs = await client.chat.getRoomMessages(room.id!, limit: 50);
        if (mounted) {
          setState(() {
            _messages = msgs;
            _isLoadingMessages = false;
          });
        }

        // Live stream subscription
        _messageSub = client.chat.streamChatMessages(room.id!).listen((
          incoming,
        ) {
          if (mounted) {
            setState(() {
              if (!_messages.any((m) => m.id != null && m.id == incoming.id)) {
                _messages.add(incoming);
              }
            });
          }
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingMessages = false;
        });
      }
    }
  }

  Future<void> _joinRoom(ChatRoom room) async {
    if (room.id == null) return;
    try {
      final updated = await client.chat.joinRoom(room.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Joined "${updated.name}"!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        await _loadRooms();
        _selectRoom(updated);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not join room: $e'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = _msgController.text.trim();
    if (text.isEmpty || _selectedRoom == null) return;

    final student = widget.authState.currentProfile;
    final senderName = student?.fullName ?? 'Student';
    _msgController.clear();

    final now = DateTime.now();
    final tempMsg = ChatMessage(
      roomId: _selectedRoom!.id ?? 1,
      senderUserId:
          widget.authState.currentProfile?.authUserId ??
          UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
      senderName: senderName,
      content: text,
      createdAt: now,
    );

    setState(() {
      _messages.add(tempMsg);
    });

    try {
      if (_selectedRoom!.id != null) {
        await client.chat.sendMessage(
          roomId: _selectedRoom!.id!,
          content: text,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending message: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _showCreateRoomDialog() {
    final nameCtrl = TextEditingController();
    final topicCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isCreating = false;
    String? createError;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDlgState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppleTokens.softLavender.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.group_add_rounded,
                      color: AppleTokens.darkNavy,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Create Discussion Room',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              content: Form(
                key: formKey,
                child: SizedBox(
                  width: 420,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Room Name *',
                            hintText: 'e.g. Distributed Systems Study Group',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Room name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: topicCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Subject / Topic (Optional)',
                            hintText: 'e.g. CS-501 or Midterm Prep',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: descCtrl,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Description (Optional)',
                            hintText:
                                'Brief goal of this study group or channel',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                        if (createError != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            createError!,
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isCreating ? null : () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppleTokens.darkNavy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isCreating
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          setDlgState(() {
                            isCreating = true;
                            createError = null;
                          });

                          try {
                            final room = await client.chat.createCustomRoom(
                              name: nameCtrl.text.trim(),
                              description: descCtrl.text.trim().isEmpty
                                  ? null
                                  : descCtrl.text.trim(),
                              topic: topicCtrl.text.trim().isEmpty
                                  ? null
                                  : topicCtrl.text.trim(),
                            );

                            if (ctx.mounted) Navigator.pop(ctx);
                            await _loadRooms();
                            _selectRoom(room);

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Room "${room.name}" created!'),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          } catch (e) {
                            setDlgState(() {
                              isCreating = false;
                              createError = e.toString().replaceFirst(
                                'Exception: ',
                                '',
                              );
                            });
                          }
                        },
                  child: isCreating
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Create Room'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showReportDialog(ChatMessage msg) {
    String selectedReason = 'Inappropriate content';
    final customCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDlgState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Report Message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Why are you reporting this message?'),
              const SizedBox(height: 12),
              ...[
                'Inappropriate content',
                'Harassment or hate speech',
                'Spam / Advertising',
                'Other',
              ].map(
                (reason) => ListTile(
                  dense: true,
                  leading: Icon(
                    selectedReason == reason
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: selectedReason == reason
                        ? AppleTokens.accentPurple
                        : Colors.grey,
                  ),
                  title: Text(reason),
                  onTap: () => setDlgState(() => selectedReason = reason),
                ),
              ),
              if (selectedReason == 'Other')
                TextField(
                  controller: customCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Explain reason...',
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final reason = selectedReason == 'Other'
                    ? customCtrl.text.trim()
                    : selectedReason;
                if (msg.id != null) {
                  try {
                    await client.chat.reportMessage(
                      messageId: msg.id!,
                      reason: reason,
                    );
                  } catch (_) {}
                }
                if (ctx.mounted) {
                  Navigator.pop(ctx);
                }
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Message reported to moderators for review.',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      backgroundColor: isDark
          ? AppleTokens.darkBackground
          : AppleTokens.warmWhite,
      appBar: AppBar(
        title: Text(
          'Campus Chat & Study Hub',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            color: isDark ? AppleTokens.white : AppleTokens.darkNavy,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Create Room'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppleTokens.darkNavy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _showCreateRoomDialog,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Row(
        children: [
          // Left Sidebar (Rooms List)
          if (isWide || _selectedRoom == null)
            Container(
              width: isWide ? 360 : MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: isDark
                        ? AppleTokens.darkBorder
                        : AppleTokens.borderPastel,
                  ),
                ),
              ),
              child: _buildRoomsList(isDark),
            ),

          // Right Chat Area
          if (isWide || _selectedRoom != null)
            Expanded(
              child: _selectedRoom == null
                  ? const Center(
                      child: Text(
                        'Select a room to begin chatting',
                        style: TextStyle(color: AppleTokens.textMutedGrey),
                      ),
                    )
                  : _buildChatArea(isDark, !isWide),
            ),
        ],
      ),
    );
  }

  Widget _buildRoomsList(bool isDark) {
    if (_isLoadingRooms) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_roomsError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.redAccent,
                size: 44,
              ),
              const SizedBox(height: 12),
              Text(
                'Failed to load chat rooms',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _roomsError!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppleTokens.textMutedGrey,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppleTokens.darkNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _loadRooms,
              ),
            ],
          ),
        ),
      );
    }

    if (_rooms.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.forum_outlined,
                size: 48,
                color: AppleTokens.textMutedGrey,
              ),
              const SizedBox(height: 12),
              Text(
                'No rooms available yet',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Create the first study or discussion group on campus.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppleTokens.textMutedGrey,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('Create Room'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppleTokens.darkNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _showCreateRoomDialog,
              ),
            ],
          ),
        ),
      );
    }

    final myUserId = widget.authState.currentProfile?.authUserId;
    final myRooms = _rooms
        .where((r) => myUserId != null && r.participantIds.contains(myUserId))
        .toList();
    final discoverRooms = _rooms
        .where((r) => myUserId == null || !r.participantIds.contains(myUserId))
        .toList();

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // My Rooms Section
        Row(
          children: [
            const Icon(
              Icons.mark_chat_read_rounded,
              size: 16,
              color: AppleTokens.darkNavy,
            ),
            const SizedBox(width: 8),
            Text(
              'My Rooms (${myRooms.length})',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: AppleTokens.darkNavy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (myRooms.isEmpty)
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isDark ? AppleTokens.darkSurface : AppleTokens.pureWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppleTokens.borderPastel),
            ),
            child: const Text(
              'You have not joined any rooms yet. Join one below or create a new room!',
              style: TextStyle(fontSize: 12, color: AppleTokens.textMutedGrey),
            ),
          )
        else
          ...myRooms.map(
            (room) => _buildRoomCard(room, isDark, isMember: true),
          ),

        const SizedBox(height: 16),

        // Discover Rooms Section
        Row(
          children: [
            const Icon(
              Icons.explore_rounded,
              size: 16,
              color: AppleTokens.darkNavy,
            ),
            const SizedBox(width: 8),
            Text(
              'Discover Rooms (${discoverRooms.length})',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: AppleTokens.darkNavy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (discoverRooms.isEmpty)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppleTokens.darkSurface : AppleTokens.pureWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppleTokens.borderPastel),
            ),
            child: const Text(
              'No new rooms to discover right now. You are already a member of all active rooms.',
              style: TextStyle(fontSize: 12, color: AppleTokens.textMutedGrey),
            ),
          )
        else
          ...discoverRooms.map(
            (room) => _buildRoomCard(room, isDark, isMember: false),
          ),
      ],
    );
  }

  Widget _buildRoomCard(ChatRoom room, bool isDark, {required bool isMember}) {
    final isSelected = _selectedRoom?.id == room.id;

    Color badgeColor = AppleTokens.pastelBlue;
    if (room.roomType == 'event_discussion')
      badgeColor = AppleTokens.pastelYellow;
    if (room.roomType == 'custom_group') badgeColor = AppleTokens.softLavender;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: isMember ? () => _selectRoom(room) : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected
                ? AppleTokens.paleLavender
                : (isDark ? AppleTokens.darkSurface : AppleTokens.pureWhite),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? AppleTokens.softLavender
                  : AppleTokens.borderPastel,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: badgeColor,
                    child: Icon(
                      room.roomType == 'event_discussion'
                          ? Icons.event
                          : (room.roomType == 'custom_group'
                                ? Icons.chat_bubble_outline_rounded
                                : Icons.groups_rounded),
                      color: AppleTokens.darkNavy,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          room.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppleTokens.darkNavy,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (room.topic != null && room.topic!.isNotEmpty)
                          Text(
                            room.topic!,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppleTokens.accentPurple,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  if (isMember)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _selectRoom(room),
                      child: const Text(
                        'Open Chat',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppleTokens.darkNavy,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _joinRoom(room),
                      child: const Text(
                        'Join Room',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              if (room.description != null && room.description!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  room.description!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppleTokens.textMutedGrey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (isMember && room.lastMessageText != null) ...[
                const SizedBox(height: 6),
                Text(
                  room.lastMessageText!,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppleTokens.textMutedGrey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatArea(bool isDark, bool showBackButton) {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? AppleTokens.darkSurface : AppleTokens.pureWhite,
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? AppleTokens.darkBorder
                    : AppleTokens.borderPastel,
              ),
            ),
          ),
          child: Row(
            children: [
              if (showBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => setState(() => _selectedRoom = null),
                ),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppleTokens.softLavender,
                child: const Icon(Icons.chat, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedRoom?.name ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Live WebSocket Encrypted Stream',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_selectedRoom?.topic != null &&
                            _selectedRoom!.topic!.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            '• Topic: ${_selectedRoom!.topic}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppleTokens.textMutedGrey,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Messages Feed
        Expanded(
          child: _isLoadingMessages
              ? const Center(child: CircularProgressIndicator())
              : _messages.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.chat_bubble_outline_rounded,
                        size: 40,
                        color: AppleTokens.textMutedGrey,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No messages in ${_selectedRoom?.name ?? "this room"} yet.',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppleTokens.textMutedGrey,
                        ),
                      ),
                      const Text(
                        'Say hi and kick off the conversation!',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppleTokens.textMutedGrey,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isMe =
                        msg.senderUserId ==
                        (widget.authState.currentProfile?.authUserId ??
                            UuidValue.fromString(
                              '00000000-0000-0000-0000-000000000001',
                            ));

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        constraints: const BoxConstraints(maxWidth: 420),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? AppleTokens.darkNavy
                              : (isDark
                                    ? AppleTokens.darkSurface
                                    : AppleTokens.pureWhite),
                          borderRadius: BorderRadius.circular(18),
                          border: isMe
                              ? null
                              : Border.all(color: AppleTokens.borderPastel),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (!isMe)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    msg.senderName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                      color: AppleTokens.softLavender,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  InkWell(
                                    onTap: () => _showReportDialog(msg),
                                    child: const Icon(
                                      Icons.flag_outlined,
                                      size: 12,
                                      color: AppleTokens.textMutedGrey,
                                    ),
                                  ),
                                ],
                              ),
                            Text(
                              msg.content,
                              style: TextStyle(
                                color: isMe
                                    ? Colors.white
                                    : AppleTokens.darkNavy,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${msg.createdAt.hour}:${msg.createdAt.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontSize: 10,
                                color: isMe
                                    ? Colors.white60
                                    : AppleTokens.textMutedGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),

        // Input Area
        Container(
          padding: const EdgeInsets.all(16),
          color: isDark ? AppleTokens.darkSurface : AppleTokens.pureWhite,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppleTokens.darkBackground
                        : AppleTokens.warmWhite,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppleTokens.borderPastel),
                  ),
                  child: TextField(
                    controller: _msgController,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: const InputDecoration(
                      hintText: 'Type message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 22,
                backgroundColor: AppleTokens.darkNavy,
                child: IconButton(
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
