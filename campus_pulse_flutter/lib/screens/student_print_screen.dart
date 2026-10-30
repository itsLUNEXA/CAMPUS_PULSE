import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class StudentPrintScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onBackToHome;

  const StudentPrintScreen({
    super.key,
    required this.authState,
    required this.onBackToHome,
  });

  @override
  State<StudentPrintScreen> createState() => _StudentPrintScreenState();
}

class _StudentPrintScreenState extends State<StudentPrintScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isLoadingOrders = true;
  List<PrintRequest> _orders = [];
  PrintPointWallet? _wallet;
  List<PrintPointTransaction> _transactions = [];

  // Form State
  final _formKey = GlobalKey<FormState>();
  final _fileNameCtrl = TextEditingController(
    text: 'Final_Semester_Thesis.pdf',
  );
  final _fileUrlCtrl = TextEditingController(
    text: 'https://campus.edu/docs/thesis.pdf',
  );
  int _pageCount = 12;
  int _copies = 1;
  String _printType = 'Black & White'; // 'Black & White', 'Colour'
  String _paperSize = 'A4'; // 'A4', 'A3'
  String _printSide = 'Double-side'; // 'Single-side', 'Double-side'
  String _binding = 'Spiral'; // 'None', 'Staple', 'Spiral'
  String _deliveryMode =
      'Library pickup'; // 'Library pickup', 'Hostel delivery'
  String _counterName = 'Central Library Main Counter';
  bool _usePointsDiscount = false;
  bool _simulatePaymentFailure = false;
  bool _isSubmitting = false;

  final List<String> _counters = [
    'Central Library Main Counter',
    'Engineering Block Photocopy Hub',
    'Hostel Cluster B Print Kiosk',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 0) _loadOrders();
        if (_tabController.index == 1) _loadOrders();
        if (_tabController.index == 2) _loadOrders();
        if (_tabController.index == 3) _loadWalletAndTransactions();
      }
    });

    _loadOrders();
    _loadWalletAndTransactions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fileNameCtrl.dispose();
    _fileUrlCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadOrders() async {
    setState(() => _isLoadingOrders = true);
    try {
      final list = await client.library.getStudentPrintRequests();
      if (mounted) {
        setState(() {
          _orders = list;
          _isLoadingOrders = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingOrders = false);
    }
  }

  Future<void> _loadWalletAndTransactions() async {
    try {
      final w = await client.library.getStudentPointWallet();
      final txs = await client.library.getPointTransactions(limit: 50);
      if (mounted) {
        setState(() {
          _wallet = w;
          _transactions = txs;
        });
      }
    } catch (_) {}
  }

  // Price Calculation Helpers
  int get _totalPages => _pageCount * _copies;

  double get _pageCost {
    double base = (_printType == 'Colour')
        ? 10.0
        : (_printSide == 'Double-side' ? 1.50 : 2.00);
    if (_paperSize == 'A3') base *= 2.0;
    return base;
  }

  double get _bindingCost => switch (_binding) {
    'Staple' => 5.0,
    'Spiral' => 30.0,
    _ => 0.0,
  };

  double get _deliveryCost => _deliveryMode == 'Hostel delivery' ? 15.0 : 0.0;

  int get _pointsAvailable => _wallet?.balance ?? 0;

  int get _pointsToRedeem {
    if (!_usePointsDiscount) return 0;
    // 20 points = 1 free page, up to total pages
    final maxRedeemablePages = _pointsAvailable ~/ 20;
    final pagesToDiscount = maxRedeemablePages.clamp(0, _totalPages);
    return pagesToDiscount * 20;
  }

  int get _freePages => _pointsToRedeem ~/ 20;

  double get _subtotal => _totalPages * _pageCost;
  double get _pointsDiscount => _freePages * _pageCost;
  double get _finalTotal =>
      (_subtotal - _pointsDiscount + _bindingCost + _deliveryCost).clamp(
        0.0,
        9999.0,
      );

  Future<void> _submitPrintRequest() async {
    if (!_formKey.currentState!.validate()) return;

    if (!widget.authState.isAuthenticated) {
      _showToast('Please sign in to order printouts.', isError: true);
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final req = await client.library.createPrintRequest(
        fileName: _fileNameCtrl.text.trim(),
        fileUrl: _fileUrlCtrl.text.trim(),
        pageCount: _pageCount,
        copies: _copies,
        printType: _printType,
        paperSize: _paperSize,
        printSide: _printSide,
        binding: _binding,
        deliveryMode: _deliveryMode,
        counterName: _counterName,
        pointsToRedeem: _pointsToRedeem,
        simulatePaymentFailure: _simulatePaymentFailure,
      );

      setState(() => _isSubmitting = false);

      if (_simulatePaymentFailure) {
        _showToast(
          'Payment simulation failed. Request moved to "Failed Payments".',
          isError: true,
        );
        _tabController.animateTo(2); // Switch to Failed Payments tab
      } else {
        _showToast(
          'Payment successful! Print request #${req.id} sent to library counter.',
        );
        _tabController.animateTo(1); // Switch to My Orders tab
      }

      _loadOrders();
      _loadWalletAndTransactions();
    } catch (e) {
      setState(() => _isSubmitting = false);
      _showToast('Failed to place order: $e', isError: true);
    }
  }

  Future<void> _retryPayment(PrintRequest req) async {
    try {
      await client.library.retryPrintPayment(
        requestId: req.id!,
        simulatePaymentFailure: false,
      );

      _showToast(
        'Payment successful! Request #${req.id} added to printing queue.',
      );
      _loadOrders();
      _loadWalletAndTransactions();
    } catch (e) {
      _showToast('Retry payment failed: $e', isError: true);
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final paidOrders = _orders
        .where((r) => r.paymentStatus == 'SUCCESS')
        .toList();
    final failedOrders = _orders
        .where((r) => r.paymentStatus == 'FAILED')
        .toList();

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
                Icons.local_printshop_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campus Print Shop',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Pulse Wallet: ${_wallet?.balance ?? 0} Points (1 Free Page = 20 Pts)',
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
            tooltip: 'Back to Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: widget.onBackToHome,
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppleTokens.primaryTeal,
          indicatorColor: AppleTokens.primaryTeal,
          isScrollable: true,
          tabs: [
            const Tab(text: 'New Print Request'),
            Tab(text: 'My Orders (${paidOrders.length})'),
            Tab(
              text: failedOrders.isNotEmpty
                  ? 'Failed Payments (${failedOrders.length})'
                  : 'Failed Payments',
            ),
            const Tab(text: 'Pulse Points Wallet'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNewOrderTab(isDark),
          _buildMyOrdersTab(isDark, paidOrders),
          _buildFailedPaymentsTab(isDark, failedOrders),
          _buildWalletTab(isDark),
        ],
      ),
    );
  }

  // ==================== TAB 1: NEW ORDER FORM ====================

  Widget _buildNewOrderTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Info Banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppleTokens.lightMint.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppleTokens.primaryTeal.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        color: AppleTokens.primaryTeal,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Campus Rewards: Earn 1 Pulse Point for every printed page! Redeem 20 points for 1 free page on any print order.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppleTokens.primaryTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Document File Specs
                AppleCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. Upload Document',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _fileNameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'File Name *',
                          hintText: 'e.g. Lab_Report_Final.pdf',
                          prefixIcon: Icon(Icons.description_outlined),
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please enter document name'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: '$_pageCount',
                              decoration: const InputDecoration(
                                labelText: 'Page Count in Doc *',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (val) => setState(
                                () => _pageCount = (int.tryParse(val) ?? 1)
                                    .clamp(1, 500),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              initialValue: '$_copies',
                              decoration: const InputDecoration(
                                labelText: 'Number of Copies *',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (val) => setState(
                                () => _copies = (int.tryParse(val) ?? 1).clamp(
                                  1,
                                  50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total Pages to Print: $_totalPages',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppleTokens.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Print Options
                AppleCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2. Print & Binding Options',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _printType,
                              decoration: const InputDecoration(
                                labelText: 'Color Mode',
                              ),
                              items: ['Black & White', 'Colour']
                                  .map(
                                    (t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => setState(() => _printType = v!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _paperSize,
                              decoration: const InputDecoration(
                                labelText: 'Paper Size',
                              ),
                              items: ['A4', 'A3']
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => setState(() => _paperSize = v!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _printSide,
                              decoration: const InputDecoration(
                                labelText: 'Sides',
                              ),
                              items: ['Single-side', 'Double-side']
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => setState(() => _printSide = v!),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _binding,
                              decoration: const InputDecoration(
                                labelText: 'Binding',
                              ),
                              items: ['None', 'Staple', 'Spiral']
                                  .map(
                                    (b) => DropdownMenuItem(
                                      value: b,
                                      child: Text(b),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) => setState(() => _binding = v!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _deliveryMode,
                        decoration: const InputDecoration(
                          labelText: 'Delivery Mode',
                        ),
                        items: ['Library pickup', 'Hostel delivery']
                            .map(
                              (d) => DropdownMenuItem(value: d, child: Text(d)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _deliveryMode = v!),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _counterName,
                        decoration: const InputDecoration(
                          labelText: 'Pickup / Processing Counter',
                        ),
                        items: _counters
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _counterName = v!),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Points & Price Summary Card
                AppleCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3. Points & Price Summary',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Pulse Points Toggle
                      Material(
                        color: Colors.transparent,
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            'Redeem Pulse Points ($_pointsAvailable Available)',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          subtitle: Text(
                            _pointsAvailable >= 20
                                ? 'Use 20 points for 1 page free (Saves ₹${_pageCost.toStringAsFixed(2)})'
                                : 'You need at least 20 points to redeem a free page.',
                            style: const TextStyle(fontSize: 11),
                          ),
                          value: _usePointsDiscount && _pointsAvailable >= 20,
                          onChanged: _pointsAvailable >= 20
                              ? (val) =>
                                    setState(() => _usePointsDiscount = val)
                              : null,
                        ),
                      ),
                      const Divider(height: 20),
                      _priceRow(
                        'Subtotal ($_totalPages pages @ ₹${_pageCost.toStringAsFixed(2)})',
                        '₹${_subtotal.toStringAsFixed(2)}',
                      ),
                      if (_freePages > 0)
                        _priceRow(
                          'Points Discount ($_pointsToRedeem pts used for $_freePages free page)',
                          '-₹${_pointsDiscount.toStringAsFixed(2)}',
                          isDiscount: true,
                        ),
                      if (_bindingCost > 0)
                        _priceRow(
                          '$_binding Binding',
                          '+₹${_bindingCost.toStringAsFixed(2)}',
                        ),
                      if (_deliveryCost > 0)
                        _priceRow(
                          'Hostel Delivery',
                          '+₹${_deliveryCost.toStringAsFixed(2)}',
                        ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Amount Payable:',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '₹${_finalTotal.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppleTokens.primaryTeal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Points to be earned upon collection: +$_totalPages Pulse Points',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Payment Safety & Simulation Controls
                AppleCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Safety Simulation',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Campus Pulse enforces payment safety: requests only reach library staff after payment SUCCESS. Toggle below to test failure handling.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppleTokens.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Material(
                        color: Colors.transparent,
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Simulate Payment Failure',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent,
                            ),
                          ),
                          subtitle: const Text(
                            'Will decline payment and place request under "Failed Payments" for retry.',
                            style: TextStyle(fontSize: 11),
                          ),
                          value: _simulatePaymentFailure,
                          onChanged: (val) =>
                              setState(() => _simulatePaymentFailure = val),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Submit CTA
                AppleButton(
                  label: _simulatePaymentFailure
                      ? 'Test Fail & Place Order'
                      : 'Pay ₹${_finalTotal.toStringAsFixed(2)} & Place Order',
                  variant: AppleButtonVariant.primary,
                  height: 46,
                  isLoading: _isSubmitting,
                  onPressed: _submitPrintRequest,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _priceRow(String label, String val, {bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppleTokens.secondaryText,
            ),
          ),
          Text(
            val,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDiscount ? Colors.green : AppleTokens.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== TAB 2: MY ORDERS ====================

  Widget _buildMyOrdersTab(bool isDark, List<PrintRequest> paidOrders) {
    if (_isLoadingOrders) {
      return const Center(
        child: CircularProgressIndicator(color: AppleTokens.primaryTeal),
      );
    }

    if (paidOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.print_disabled,
              size: 48,
              color: AppleTokens.secondaryText,
            ),
            const SizedBox(height: 12),
            const Text(
              'No Active Print Orders',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your paid print orders will appear here.',
              style: TextStyle(color: AppleTokens.secondaryText),
            ),
            const SizedBox(height: 16),
            AppleButton(
              label: 'Order New Printout',
              variant: AppleButtonVariant.primary,
              height: 38,
              onPressed: () => _tabController.animateTo(0),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: paidOrders.length,
      itemBuilder: (ctx, i) {
        final r = paidOrders[i];
        final isReady = r.status == 'READY';

        return AppleCard(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
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
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusBadgeColor(
                        r.status,
                      ).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(
                        AppleTokens.radius999,
                      ),
                    ),
                    child: Text(
                      r.status,
                      style: TextStyle(
                        color: _getStatusBadgeColor(r.status),
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                r.fileName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${r.totalPages} pgs (${r.pageCount}p × ${r.copies}c) • ${r.printType} • ${r.printSide} • ${r.counterName}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppleTokens.secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Amount Paid: ₹${r.amountPaid.toStringAsFixed(2)} • Points: Used ${r.pointsUsed} / Earns +${r.pointsEarned}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // IF READY: SHOW UNIQUE 6-DIGIT CODE & QR
              if (isReady && r.collectionCode != null) ...[
                const Divider(height: 20),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      // QR Code representation
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.qr_code_2,
                              size: 48,
                              color: Colors.black87,
                            ),
                            Text(
                              'PASS #${r.id}',
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'READY FOR COLLECTION!',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.green,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Show this code or QR at counter:',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppleTokens.secondaryText,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SelectableText(
                              r.collectionCode!,
                              style: GoogleFonts.sourceCodePro(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 4,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // ==================== TAB 3: FAILED PAYMENTS ====================

  Widget _buildFailedPaymentsTab(bool isDark, List<PrintRequest> failedOrders) {
    if (failedOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.verified_rounded, size: 48, color: Colors.green),
            const SizedBox(height: 12),
            const Text(
              'No Failed Payments',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            const Text(
              'All your print orders have successfully cleared payment.',
              style: TextStyle(color: AppleTokens.secondaryText),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: failedOrders.length,
      itemBuilder: (ctx, i) {
        final r = failedOrders[i];

        return AppleCard(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
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
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(
                        AppleTokens.radius999,
                      ),
                    ),
                    child: const Text(
                      'PAYMENT FAILED',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                r.fileName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                r.paymentFailureReason ??
                    'Card payment declined by issuing bank',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.redAccent,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Amount Due: ₹${r.amountPaid.toStringAsFixed(2)} • ${r.totalPages} Pages',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppleButton(
                    label: 'Retry Payment Now',
                    variant: AppleButtonVariant.primary,
                    icon: Icons.refresh_rounded,
                    height: 36,
                    onPressed: () => _retryPayment(r),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ==================== TAB 4: WALLET & TRANSACTIONS ====================

  Widget _buildWalletTab(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Balance Card
              AppleCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      size: 48,
                      color: AppleTokens.primaryTeal,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_wallet?.balance ?? 0}',
                      style: GoogleFonts.inter(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: AppleTokens.primaryTeal,
                      ),
                    ),
                    const Text(
                      'Available Pulse Points',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Worth ${(_wallet?.balance ?? 0) ~/ 20} Free Printed Pages (20 Pts = 1 Page)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppleTokens.secondaryText,
                      ),
                    ),
                    const Divider(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${_wallet?.lifetimeEarned ?? 0}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.green,
                              ),
                            ),
                            const Text(
                              'Lifetime Earned',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppleTokens.secondaryText,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${_wallet?.lifetimeRedeemed ?? 0}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                            const Text(
                              'Lifetime Redeemed',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppleTokens.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Transaction History
              Text(
                'Points Transaction History',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              if (_transactions.isEmpty)
                AppleCard(
                  padding: const EdgeInsets.all(24),
                  child: const Center(
                    child: Text(
                      'No point transactions yet.',
                      style: TextStyle(color: AppleTokens.secondaryText),
                    ),
                  ),
                )
              else
                ..._transactions.map((tx) {
                  final isEarned = tx.type == 'EARNED' || tx.type == 'REFUNDED';
                  return AppleCard(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isEarned
                                  ? Icons.add_circle_outline
                                  : Icons.remove_circle_outline,
                              color: isEarned ? Colors.green : Colors.redAccent,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tx.description,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Balance After: ${tx.balanceAfter} pts',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppleTokens.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '${tx.points > 0 ? "+" : ""}${tx.points} pts',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: isEarned ? Colors.green : Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusBadgeColor(String status) {
    switch (status.toUpperCase()) {
      case 'QUEUED':
        return const Color(0xFF2563EB);
      case 'PRINTING':
        return const Color(0xFFD97706);
      case 'READY':
        return const Color(0xFF059669);
      case 'COLLECTED':
        return const Color(0xFF6B7280);
      default:
        return AppleTokens.primaryTeal;
    }
  }
}
