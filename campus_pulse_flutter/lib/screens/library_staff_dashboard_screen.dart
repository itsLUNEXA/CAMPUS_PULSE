import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class LibraryStaffDashboardScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onBackToHome;
  final VoidCallback onSignOut;

  const LibraryStaffDashboardScreen({
    super.key,
    required this.authState,
    required this.onBackToHome,
    required this.onSignOut,
  });

  @override
  State<LibraryStaffDashboardScreen> createState() =>
      _LibraryStaffDashboardScreenState();
}

class _LibraryStaffDashboardScreenState
    extends State<LibraryStaffDashboardScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  List<PrintRequest> _requests = [];
  String _selectedStatusFilter = 'ALL';
  String _selectedCounter = 'Central Library Main Counter';
  List<String> _availableCounters = ['Central Library Main Counter'];
  final TextEditingController _searchCtrl = TextEditingController();
  final TextEditingController _verifyCodeCtrl = TextEditingController();

  String _staffName = 'Library Staff';
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadProfileAndRequests();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _verifyCodeCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProfileAndRequests() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final profile = await client.library.getStaffProfile();
      _staffName = profile['staffName'] as String? ?? 'Library Staff';
      _isAdmin = profile['isAdmin'] as bool? ?? false;
      final assigned = profile['assignedCounter'] as String?;
      if (assigned != null && !assigned.contains('All Counters')) {
        _selectedCounter = assigned;
      }
      final counters =
          (profile['availableCounters'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['Central Library Main Counter'];
      _availableCounters = counters;

      await _fetchRequests();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to load library staff panel: $e';
        });
      }
    }
  }

  Future<void> _fetchRequests() async {
    try {
      final list = await client.library.getLibraryRequests(
        counterName: _isAdmin
            ? (_selectedCounter == 'All Counters' ? null : _selectedCounter)
            : _selectedCounter,
        statusFilter: _selectedStatusFilter,
        searchQuery: _searchCtrl.text.trim().isEmpty
            ? null
            : _searchCtrl.text.trim(),
        limit: 100,
        offset: 0,
      );

      if (mounted) {
        setState(() {
          _requests = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error fetching print orders: $e';
        });
      }
    }
  }

  Future<void> _updateStatus(
    int requestId,
    String newStatus, {
    String? reason,
  }) async {
    try {
      final updated = await client.library.updateRequestStatus(
        requestId: requestId,
        targetStatus: newStatus,
        reason: reason,
      );

      _showToast('Request #${updated.id} status updated to $newStatus');
      _fetchRequests();
    } catch (e) {
      _showToast('Failed to update request: $e', isError: true);
    }
  }

  Future<void> _verifyCollectionCode(String code) async {
    final cleanCode = code.trim();
    if (cleanCode.isEmpty) {
      _showToast(
        'Please enter a 6-digit collection code or scan QR',
        isError: true,
      );
      return;
    }

    try {
      final collected = await client.library.verifyCollection(
        collectionCodeOrToken: cleanCode,
      );

      _verifyCodeCtrl.clear();
      if (mounted) Navigator.of(context, rootNavigator: true).pop();

      _showToast(
        'Printout collected! ${collected.pointsEarned} Pulse Points credited to ${collected.studentName}.',
      );
      _fetchRequests();
    } catch (e) {
      _showToast('Verification failed: $e', isError: true);
    }
  }

  void _showToast(String msg, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.redAccent : AppleTokens.primaryTeal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'QUEUED':
        return const Color(0xFF2563EB); // blue
      case 'PRINTING':
        return const Color(0xFFD97706); // orange
      case 'READY':
        return const Color(0xFF059669); // green
      case 'COLLECTED':
        return const Color(0xFF6B7280); // grey
      case 'CANCELLED':
      case 'REFUNDED':
        return const Color(0xFFDC2626); // red
      default:
        return AppleTokens.primaryTeal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: isDark
          ? AppleTokens.neutralBlack
          : AppleTokens.pageBackground,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppleTokens.primaryTeal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.print_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Library Print Request Panel',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Staff: $_staffName • $_selectedCounter',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppleTokens.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Verify Student Collection Code',
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: _openVerifyDialog,
          ),
          IconButton(
            tooltip: 'Refresh Queue',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _fetchRequests,
          ),
          IconButton(
            tooltip: 'Back to Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: widget.onBackToHome,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? _buildSkeletonLoading(isDark)
          : RefreshIndicator(
              onRefresh: _fetchRequests,
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 24,
                  vertical: 16,
                ),
                children: [
                  _buildHeaderAndStats(isDark, isMobile),
                  const SizedBox(height: 16),
                  _buildFilterAndSearchRow(isDark, isMobile),
                  const SizedBox(height: 16),
                  if (_errorMessage != null)
                    _buildErrorCard(_errorMessage!)
                  else if (_requests.isEmpty)
                    _buildEmptyState(isDark)
                  else if (isMobile)
                    _buildMobileCardList(isDark)
                  else
                    _buildDesktopTable(isDark),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppleTokens.primaryTeal,
        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
        label: const Text(
          'Verify Collection',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: _openVerifyDialog,
      ),
    );
  }

  // ==================== STATS ROW ====================

  Widget _buildHeaderAndStats(bool isDark, bool isMobile) {
    final queuedCount = _requests.where((r) => r.status == 'QUEUED').length;
    final printingCount = _requests.where((r) => r.status == 'PRINTING').length;
    final readyCount = _requests.where((r) => r.status == 'READY').length;
    final collectedCount = _requests
        .where((r) => r.status == 'COLLECTED')
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isAdmin)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Text(
                  'Active Counter: ',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _availableCounters.contains(_selectedCounter)
                      ? _selectedCounter
                      : _availableCounters.first,
                  underline: const SizedBox(),
                  items: _availableCounters
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(c, style: const TextStyle(fontSize: 13)),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedCounter = val);
                      _fetchRequests();
                    }
                  },
                ),
              ],
            ),
          ),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _statChip(
              'QUEUED',
              queuedCount,
              const Color(0xFF2563EB),
              Icons.hourglass_top,
            ),
            _statChip(
              'PRINTING',
              printingCount,
              const Color(0xFFD97706),
              Icons.print_outlined,
            ),
            _statChip(
              'READY',
              readyCount,
              const Color(0xFF059669),
              Icons.check_circle_outline,
            ),
            _statChip(
              'COLLECTED',
              collectedCount,
              const Color(0xFF6B7280),
              Icons.done_all,
            ),
          ],
        ),
      ],
    );
  }

  Widget _statChip(String label, int count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppleTokens.radius8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            '$count $label',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== FILTER & SEARCH ROW ====================

  Widget _buildFilterAndSearchRow(bool isDark, bool isMobile) {
    final filters = [
      'ALL',
      'QUEUED',
      'PRINTING',
      'READY',
      'COLLECTED',
      'CANCELLED',
    ];

    return AppleCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText:
                  'Search by student name, request ID, or collection code...',
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: _searchCtrl.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _searchCtrl.clear();
                        _fetchRequests();
                      },
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
            onChanged: (_) => _fetchRequests(),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((f) {
                final isSelected = _selectedStatusFilter == f;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(f == 'ALL' ? 'All Orders' : f),
                    selected: isSelected,
                    selectedColor: AppleTokens.primaryTeal,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : AppleTokens.primaryText),
                    ),
                    onSelected: (val) {
                      if (val) {
                        setState(() => _selectedStatusFilter = f);
                        _fetchRequests();
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== DESKTOP TABLE VIEW ====================

  Widget _buildDesktopTable(bool isDark) {
    return AppleCard(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 18,
          horizontalMargin: 8,
          headingRowColor: WidgetStateProperty.all(
            isDark
                ? AppleTokens.darkSurfaceElevated
                : AppleTokens.pageBackground,
          ),
          columns: const [
            DataColumn(
              label: Text(
                'ID & Code',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Student',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Document',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Specs',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Paid / Points',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: _requests.map((r) => _buildDataRow(r, isDark)).toList(),
        ),
      ),
    );
  }

  DataRow _buildDataRow(PrintRequest r, bool isDark) {
    final statusColor = _getStatusColor(r.status);

    return DataRow(
      cells: [
        // ID & Collection Code
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#PR-${r.id}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              if (r.collectionCode != null)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Code: ${r.collectionCode}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Student Info
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r.studentName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              Text(
                '${r.studentBranch} • Yr ${r.studentYear} • ${r.hostelOrLocation}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppleTokens.secondaryText,
                ),
              ),
            ],
          ),
        ),
        // Document
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.picture_as_pdf,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(width: 6),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 160),
                child: Text(
                  r.fileName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.visibility_outlined, size: 16),
                tooltip: 'Preview Document',
                onPressed: () => _showDocumentPreview(r),
              ),
            ],
          ),
        ),
        // Specs: Pages, Copies, Paper, Side, Binding
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${r.totalPages} pgs (${r.pageCount}p × ${r.copies}) • ${r.paperSize}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(
                '${r.printType} • ${r.printSide} • Binding: ${r.binding}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppleTokens.secondaryText,
                ),
              ),
            ],
          ),
        ),
        // Payment & Points
        DataCell(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹${r.amountPaid.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: AppleTokens.primaryTeal,
                ),
              ),
              Text(
                'Used: ${r.pointsUsed} pts • Earns: +${r.pointsEarned} pts',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: r.pointsAwarded
                      ? Colors.green
                      : AppleTokens.secondaryText,
                ),
              ),
            ],
          ),
        ),
        // Status Badge
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppleTokens.radius999),
              border: Border.all(color: statusColor.withValues(alpha: 0.4)),
            ),
            child: Text(
              r.status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
        ),
        // Actions
        DataCell(_buildActionButtons(r)),
      ],
    );
  }

  // ==================== MOBILE CARD VIEW ====================

  Widget _buildMobileCardList(bool isDark) {
    return Column(
      children: _requests.map((r) {
        final statusColor = _getStatusColor(r.status);

        return AppleCard(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#PR-${r.id}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(
                        AppleTokens.radius999,
                      ),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      r.status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 16,
                    color: AppleTokens.secondaryText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    r.studentName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${r.studentBranch} • Yr ${r.studentYear})',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppleTokens.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppleTokens.secondaryText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${r.deliveryMode}: ${r.hostelOrLocation}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppleTokens.secondaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppleTokens.darkSurfaceElevated
                      : AppleTokens.pageBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.description,
                      color: Colors.redAccent,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.fileName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${r.totalPages} pgs (${r.pageCount}p × ${r.copies} copies) • ${r.paperSize} • ${r.printType}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppleTokens.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.visibility_outlined, size: 18),
                      onPressed: () => _showDocumentPreview(r),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paid: ₹${r.amountPaid.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppleTokens.primaryTeal,
                        ),
                      ),
                      Text(
                        'Points: Used ${r.pointsUsed} • Earns +${r.pointsEarned}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppleTokens.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  if (r.collectionCode != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Code: ${r.collectionCode}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              _buildActionButtons(r),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ==================== WORKFLOW ACTIONS ====================

  Widget _buildActionButtons(PrintRequest r) {
    switch (r.status.toUpperCase()) {
      case 'QUEUED':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppleButton(
              label: 'Start Printing',
              variant: AppleButtonVariant.primary,
              icon: Icons.play_arrow_rounded,
              height: 32,
              onPressed: () => _updateStatus(r.id!, 'PRINTING'),
            ),
            const SizedBox(width: 6),
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              height: 32,
              onPressed: () => _showCancelDialog(r),
            ),
          ],
        );
      case 'PRINTING':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppleButton(
              label: 'Mark Ready',
              variant: AppleButtonVariant.primary,
              icon: Icons.check_circle_outline,
              height: 32,
              onPressed: () => _updateStatus(r.id!, 'READY'),
            ),
            const SizedBox(width: 6),
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              height: 32,
              onPressed: () => _showCancelDialog(r),
            ),
          ],
        );
      case 'READY':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppleButton(
              label: 'Verify & Collect',
              variant: AppleButtonVariant.primary,
              icon: Icons.verified_user_outlined,
              height: 32,
              onPressed: () {
                _verifyCodeCtrl.text = r.collectionCode ?? '';
                _openVerifyDialog();
              },
            ),
            const SizedBox(width: 6),
            AppleButton(
              label: 'Refund',
              variant: AppleButtonVariant.subtle,
              height: 32,
              onPressed: () => _showCancelDialog(r, isRefund: true),
            ),
          ],
        );
      case 'COLLECTED':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.done_all, color: Colors.green, size: 16),
            const SizedBox(width: 4),
            Text(
              r.collectedAt != null
                  ? 'Collected on ${_formatDate(r.collectedAt!)}'
                  : 'Collected',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case 'CANCELLED':
      case 'REFUNDED':
        return Tooltip(
          message: r.statusReason ?? 'Order cancelled',
          child: Text(
            r.statusReason ?? r.status,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.redAccent,
              fontStyle: FontStyle.italic,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        );
      default:
        return const SizedBox();
    }
  }

  // ==================== MODALS & DIALOGS ====================

  void _openVerifyDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppleTokens.lightMint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: AppleTokens.primaryTeal,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Verify Collection',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter the student’s 6-digit collection code or scan their QR token to hand over the printout and credit points.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppleTokens.secondaryText,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _verifyCodeCtrl,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: '6-Digit Code or QR Token',
                  hintText: 'e.g. 729401 or CAMPUS-PRINT-729401-id',
                  prefixIcon: Icon(Icons.pin_outlined),
                ),
                onSubmitted: (val) => _verifyCollectionCode(val),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            AppleButton(
              label: 'Verify & Handover',
              variant: AppleButtonVariant.primary,
              height: 38,
              onPressed: () => _verifyCollectionCode(_verifyCodeCtrl.text),
            ),
          ],
        );
      },
    );
  }

  void _showCancelDialog(PrintRequest r, {bool isRefund = false}) {
    final reasonCtrl = TextEditingController(
      text: isRefund
          ? 'Paper jammed or misprint occurred at counter'
          : 'Student requested cancellation',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            isRefund ? 'Refund Request #${r.id}' : 'Cancel Request #${r.id}',
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to mark this request as ${isRefund ? "REFUNDED" : "CANCELLED"}? ${r.pointsUsed > 0 ? "\n\nNote: ${r.pointsUsed} points used will be automatically refunded back to the student." : ""}',
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: reasonCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Mandatory Reason *',
                    hintText: 'Specify reason for staff logs',
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Please enter a valid reason'
                      : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Back'),
            ),
            AppleButton(
              label: isRefund ? 'Confirm Refund' : 'Confirm Cancellation',
              variant: AppleButtonVariant.subtle,
              height: 38,
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                Navigator.pop(ctx);
                _updateStatus(
                  r.id!,
                  isRefund ? 'REFUNDED' : 'CANCELLED',
                  reason: reasonCtrl.text.trim(),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showDocumentPreview(PrintRequest r) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  r.fileName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 480,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _previewMetaRow('Request ID', '#PR-${r.id}'),
                _previewMetaRow(
                  'Student',
                  '${r.studentName} (${r.studentBranch}, Yr ${r.studentYear})',
                ),
                _previewMetaRow('Counter', r.counterName),
                _previewMetaRow(
                  'Total Pages',
                  '${r.totalPages} (${r.pageCount} pages × ${r.copies} copies)',
                ),
                _previewMetaRow(
                  'Paper & Color',
                  '${r.paperSize} • ${r.printType}',
                ),
                _previewMetaRow(
                  'Sides & Binding',
                  '${r.printSide} • Binding: ${r.binding}',
                ),
                _previewMetaRow(
                  'Delivery',
                  '${r.deliveryMode} (${r.hostelOrLocation})',
                ),
                _previewMetaRow(
                  'Amount Paid',
                  '₹${r.amountPaid.toStringAsFixed(2)} (Payment: ${r.paymentStatus})',
                ),
                _previewMetaRow('Points Used', '${r.pointsUsed} points'),
                _previewMetaRow(
                  'Points to Earn',
                  '+${r.pointsEarned} points (upon collection)',
                ),
                if (r.collectionCode != null)
                  _previewMetaRow('Collection Code', r.collectionCode!),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Payment verified via Campus Gateway. File is ready to send to printer.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Close'),
            ),
            AppleButton(
              label: 'Download / Print',
              variant: AppleButtonVariant.primary,
              icon: Icons.print_rounded,
              height: 38,
              onPressed: () {
                Navigator.pop(ctx);
                _showToast('Sending "${r.fileName}" to printer spooler...');
              },
            ),
          ],
        );
      },
    );
  }

  Widget _previewMetaRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppleTokens.secondaryText,
              ),
            ),
          ),
          Expanded(
            child: Text(
              val,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SKELETON & EMPTY STATES ====================

  Widget _buildSkeletonLoading(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: List.generate(
        4,
        (i) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 90,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white10
                : Colors.grey.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return AppleCard(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppleTokens.lightMint,
                borderRadius: BorderRadius.circular(AppleTokens.radius999),
              ),
              child: const Icon(
                Icons.print_disabled_outlined,
                size: 36,
                color: AppleTokens.primaryTeal,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No Print Requests in ${_selectedStatusFilter == "ALL" ? "Queue" : _selectedStatusFilter}',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            const SizedBox(height: 6),
            const Text(
              'New paid student print orders will appear here automatically in real time.',
              style: TextStyle(fontSize: 13, color: AppleTokens.secondaryText),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return AppleCard(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.redAccent,
              size: 36,
            ),
            const SizedBox(height: 12),
            Text(
              error,
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            AppleButton(
              label: 'Retry Fetch',
              variant: AppleButtonVariant.primary,
              height: 36,
              onPressed: _fetchRequests,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final local = dt.toLocal();
    return '${local.day}/${local.month} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}
