import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class StudyRequestsScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onBack;

  const StudyRequestsScreen({
    super.key,
    required this.authState,
    required this.onBack,
  });

  @override
  State<StudyRequestsScreen> createState() => _StudyRequestsScreenState();
}

class _StudyRequestsScreenState extends State<StudyRequestsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  List<StudyRequest> _incoming = [];
  List<StudyRequest> _outgoing = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    if (!widget.authState.isAuthenticated) {
      setState(() => _isLoading = false);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final inc = await client.studyRequest.getMyIncomingRequests();
      final out = await client.studyRequest.getMyOutgoingRequests();
      if (mounted) {
        setState(() {
          _incoming = inc;
          _outgoing = out;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _updateStatus(StudyRequest request, String newStatus) async {
    try {
      final updated = await client.studyRequest.updateRequestStatus(
        requestId: request.id!,
        newStatus: newStatus,
      );

      setState(() {
        final incIndex = _incoming.indexWhere((r) => r.id == updated.id);
        if (incIndex != -1) _incoming[incIndex] = updated;

        final outIndex = _outgoing.indexWhere((r) => r.id == updated.id);
        if (outIndex != -1) _outgoing[outIndex] = updated;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Study request marked as $newStatus.')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update request.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: _loadRequests,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space24,
          vertical: AppleTokens.space32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppleButton(
                  label: 'Back',
                  variant: AppleButtonVariant.subtle,
                  icon: Icons.arrow_back,
                  height: 38,
                  onPressed: widget.onBack,
                ),
                const SizedBox(height: AppleTokens.space16),

                Text(
                  'Peer Study Match Requests',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppleTokens.space8),
                const Text(
                  'Manage study partner requests sent and received across your campus community.',
                ),
                const SizedBox(height: AppleTokens.space24),

                // Tabs
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppleTokens.darkSurfaceElevated
                        : AppleTokens.lightNeutral,
                    borderRadius: BorderRadius.circular(AppleTokens.radius999),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: isDark
                          ? AppleTokens.secondaryBlue
                          : AppleTokens.primaryBlue,
                      borderRadius: BorderRadius.circular(
                        AppleTokens.radius999,
                      ),
                    ),
                    labelColor: isDark ? AppleTokens.black : AppleTokens.white,
                    unselectedLabelColor: isDark
                        ? AppleTokens.darkTextSecondary
                        : AppleTokens.secondaryText,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(text: 'Incoming Requests (${_incoming.length})'),
                      Tab(text: 'Outgoing Requests (${_outgoing.length})'),
                    ],
                  ),
                ),
                const SizedBox(height: AppleTokens.space24),

                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(48),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  AnimatedBuilder(
                    animation: _tabController,
                    builder: (context, _) {
                      final list = _tabController.index == 0
                          ? _incoming
                          : _outgoing;
                      final isIncoming = _tabController.index == 0;

                      if (list.isEmpty) {
                        return AppleCard(
                          padding: const EdgeInsets.all(AppleTokens.space40),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.inbox_outlined,
                                  size: 48,
                                  color: AppleTokens.secondaryText,
                                ),
                                const SizedBox(height: AppleTokens.space16),
                                Text(
                                  isIncoming
                                      ? 'No Incoming Requests'
                                      : 'No Outgoing Requests',
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: AppleTokens.space8),
                                Text(
                                  isIncoming
                                      ? 'When classmates discover your profile and want to prepare together, requests appear here.'
                                      : 'You have not sent any study requests yet. Browse the Study Buddy Finder to connect!',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: list
                            .map(
                              (r) =>
                                  _requestCard(context, r, isIncoming, isDark),
                            )
                            .toList(),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _requestCard(
    BuildContext context,
    StudyRequest req,
    bool isIncoming,
    bool isDark,
  ) {
    Color statusColor;
    switch (req.status) {
      case 'accepted':
        statusColor = AppleTokens.success;
        break;
      case 'declined':
      case 'cancelled':
        statusColor = AppleTokens.error;
        break;
      default:
        statusColor = AppleTokens.warning;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppleTokens.space16),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    isIncoming
                        ? '${req.senderName} (${req.senderBranch} - Year ${req.senderYear})'
                        : 'To: ${req.recipientName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppleTokens.radius999),
                  ),
                  child: Text(
                    req.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppleTokens.space8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color:
                        (isDark
                                ? AppleTokens.secondaryBlue
                                : AppleTokens.primaryBlue)
                            .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppleTokens.radius999),
                  ),
                  child: Text(
                    req.subject,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppleTokens.secondaryBlue
                          : AppleTokens.primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: AppleTokens.space8),
                Text(
                  'Urgency: ${req.urgency.toUpperCase()}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: AppleTokens.space12),
            Text(
              '"${req.message}"',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: AppleTokens.space16),

            // Action Buttons
            if (req.status == 'pending') ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: isIncoming
                    ? [
                        AppleButton(
                          label: 'Decline',
                          variant: AppleButtonVariant.subtle,
                          height: 34,
                          onPressed: () => _updateStatus(req, 'declined'),
                        ),
                        const SizedBox(width: AppleTokens.space8),
                        AppleButton(
                          label: 'Accept & Connect',
                          variant: AppleButtonVariant.primary,
                          height: 34,
                          onPressed: () => _updateStatus(req, 'accepted'),
                        ),
                      ]
                    : [
                        AppleButton(
                          label: 'Cancel Request',
                          variant: AppleButtonVariant.destructive,
                          height: 34,
                          onPressed: () => _updateStatus(req, 'cancelled'),
                        ),
                      ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
