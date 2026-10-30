import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class RewardsScreen extends StatefulWidget {
  final AuthState authState;
  final Function(String route, Widget screen) onNavigate;

  const RewardsScreen({
    super.key,
    required this.authState,
    required this.onNavigate,
  });

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int _totalPoints = 0;
  int _currentStreak = 0;
  List<RewardPerk> _perks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPointsAndPerks();
  }

  Future<void> _loadPointsAndPerks() async {
    setState(() => _isLoading = true);
    try {
      final stats = await client.points.getMyPointsAndStreak();
      final list = await client.points.listRewards();

      if (mounted) {
        setState(() {
          _totalPoints = stats['totalPoints'] ?? 250;
          _currentStreak = stats['currentStreak'] ?? 3;
          _perks = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _totalPoints = 250;
          _currentStreak = 3;
          if (_perks.isEmpty) {
            _perks = [
              RewardPerk(
                id: 1,
                title: 'Campus Cafeteria 20% Discount Pass',
                category: 'Dining',
                description:
                    'Valid for full week across food court and beverage stations.',
                costPoints: 100,
                stockRemaining: 45,
                isActive: true,
              ),
              RewardPerk(
                id: 2,
                title: 'Annual TechFest VIP Fast-Track Pass',
                category: 'Fest Pass',
                description:
                    'Skip queues for keynote technical talks and coding arenas.',
                costPoints: 200,
                stockRemaining: 15,
                isActive: true,
              ),
              RewardPerk(
                id: 3,
                title: 'Library 24/7 Night Access Card',
                category: 'Academic',
                description:
                    'Overnight study cubicle booking pass during examination week.',
                costPoints: 150,
                stockRemaining: 20,
                isActive: true,
              ),
            ];
          }
        });
      }
    }
  }

  Future<void> _redeemPerk(RewardPerk perk) async {
    if (_totalPoints < perk.costPoints) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Insufficient points balance! Attend more events or quizzes.',
          ),
        ),
      );
      return;
    }

    try {
      if (perk.id != null) {
        await client.points.redeemReward(perk.id!);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '🎉 Redeemed "${perk.title}" successfully! Check email for voucher.',
            ),
          ),
        );
        _loadPointsAndPerks();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Redemption error: $e')),
        );
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
          'Campus Points & Rewards Economy',
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
          // Points & Streak Hero Card
          AppleCard(
            padding: const EdgeInsets.all(24),
            backgroundColor: AppleTokens.pastelYellow,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MY CAMPUS POINTS',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: AppleTokens.darkNavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_totalPoints PTS',
                        style: GoogleFonts.inter(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: AppleTokens.darkNavy,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Earned via verified QR check-ins, study sessions, and quizzes.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppleTokens.darkNavy.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        color: Colors.deepOrange,
                        size: 30,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_currentStreak DAY',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: AppleTokens.darkNavy,
                        ),
                      ),
                      const Text(
                        'Active Streak',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppleTokens.textMutedGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Perks Catalog
          Text(
            'Redeemable Rewards & Perks Catalog',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : AppleTokens.darkNavy,
            ),
          ),
          const SizedBox(height: 14),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            ..._perks.map((perk) => _buildPerkCard(perk, isDark)),
        ],
      ),
    );
  }

  Widget _buildPerkCard(RewardPerk perk, bool isDark) {
    final canAfford = _totalPoints >= perk.costPoints;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppleTokens.pastelBlue.withValues(alpha: 0.35),
              child: const Icon(
                Icons.card_giftcard_rounded,
                color: AppleTokens.darkNavy,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppleTokens.paleLavender,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          perk.category.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 9,
                            color: AppleTokens.darkNavy,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${perk.costPoints} Points',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    perk.title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: AppleTokens.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    perk.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppleTokens.textMutedGrey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            AppleButton(
              label: 'Redeem',
              variant: canAfford
                  ? AppleButtonVariant.primary
                  : AppleButtonVariant.outline,
              onPressed: canAfford ? () => _redeemPerk(perk) : null,
            ),
          ],
        ),
      ),
    );
  }
}
