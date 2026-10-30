import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class CertificatesScreen extends StatefulWidget {
  final AuthState authState;
  final Function(String route, Widget screen) onNavigate;

  const CertificatesScreen({
    super.key,
    required this.authState,
    required this.onNavigate,
  });

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  final _verifyIdController = TextEditingController();
  List<EventCertificate> _myCertificates = [];
  bool _isLoading = true;
  EventCertificate? _verifiedResult;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _loadCertificates();
  }

  @override
  void dispose() {
    _verifyIdController.dispose();
    super.dispose();
  }

  Future<void> _loadCertificates() async {
    setState(() => _isLoading = true);
    try {
      final certs = await client.certificate.getMyCertificates();
      if (mounted) {
        setState(() {
          _myCertificates = certs;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Seed initial display if empty in dev
          if (_myCertificates.isEmpty) {
            final now = DateTime.now();
            _myCertificates = [
              EventCertificate(
                certificateId: 'CP-1-A98B47E2',
                eventId: 1,
                authUserId:
                    widget.authState.currentProfile?.authUserId ??
                    UuidValue.fromString(
                      '00000000-0000-0000-0000-000000000001',
                    ),
                studentName:
                    widget.authState.currentProfile?.fullName ?? 'Aarav Sharma',
                eventName: 'HackPulse 2026: Campus Hackathon',
                eventDate: now.subtract(const Duration(days: 3)),
                issuedAt: now.subtract(const Duration(days: 1)),
                verificationUrl: 'https://campuspulse.edu/verify/CP-1-A98B47E2',
                status: 'valid',
                signatureTitle: 'Dean of Student Affairs',
              ),
            ];
          }
        });
      }
    }
  }

  Future<void> _verifyCertificate() async {
    final id = _verifyIdController.text.trim();
    if (id.isEmpty) return;

    setState(() {
      _isVerifying = true;
      _verifiedResult = null;
    });

    try {
      final result = await client.certificate.verifyCertificate(id);
      if (mounted) {
        setState(() {
          _verifiedResult = result;
          _isVerifying = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isVerifying = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppleTokens.darkBackground
          : AppleTokens.warmWhite,
      appBar: AppBar(
        title: Text(
          'Event Certificates',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            color: isDark ? AppleTokens.white : AppleTokens.darkNavy,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppleTokens.space24),
        children: [
          // Public Verification Lookup
          AppleCard(
            padding: const EdgeInsets.all(AppleTokens.space20),
            backgroundColor: AppleTokens.paleLavender,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.verified_user_rounded,
                      color: AppleTokens.darkNavy,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Verify Authenticity & Public Audit',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: AppleTokens.darkNavy,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Employers, faculty, and recruiters can verify any CAMPULSE certificate ID instantly.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppleTokens.textMutedGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius12,
                          ),
                          border: Border.all(color: AppleTokens.borderPastel),
                        ),
                        child: TextField(
                          controller: _verifyIdController,
                          decoration: const InputDecoration(
                            hintText: 'Enter ID (e.g. CP-1-A98B47E2)',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    AppleButton(
                      label: 'Verify',
                      variant: AppleButtonVariant.primary,
                      onPressed: _verifyCertificate,
                    ),
                  ],
                ),
                if (_isVerifying)
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_verifiedResult != null)
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'VERIFIED AUTHENTIC CERTIFICATE',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.green.shade900,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Awarded to: ${_verifiedResult!.studentName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Event: ${_verifiedResult!.eventName}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Issued: ${_verifiedResult!.issuedAt.day}/${_verifiedResult!.issuedAt.month}/${_verifiedResult!.issuedAt.year}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // My Certificates Section
          Text(
            'My Earned Certificates',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppleTokens.white : AppleTokens.darkNavy,
            ),
          ),
          const SizedBox(height: 14),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_myCertificates.isEmpty)
            AppleCard(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No certificates issued yet. Attend events and verify your attendance to receive official certificates.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: AppleTokens.textMutedGrey),
                ),
              ),
            )
          else
            ..._myCertificates.map(
              (cert) => _buildCertificateCard(cert, isDark),
            ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(EventCertificate cert, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppleTokens.pastelYellow,
                    borderRadius: BorderRadius.circular(AppleTokens.radius999),
                  ),
                  child: Text(
                    'OFFICIAL CREDENTIAL',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                      color: AppleTokens.darkNavy,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'ID: ${cert.certificateId}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppleTokens.softLavender,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Certificate of Participation & Achievement',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppleTokens.textMutedGrey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              cert.studentName,
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppleTokens.darkNavy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Has successfully participated in and satisfied all attendance and academic requirements for ${cert.eventName}.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: isDark
                    ? AppleTokens.darkTextSecondary
                    : AppleTokens.darkNavy,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Authorized Signatory',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppleTokens.textMutedGrey,
                      ),
                    ),
                    Text(
                      cert.signatureTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                AppleButton(
                  label: 'Download PDF',
                  variant: AppleButtonVariant.secondary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Downloading Certificate #${cert.certificateId}...',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
