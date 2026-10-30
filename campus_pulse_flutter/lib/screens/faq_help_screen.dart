import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';
import '../widgets/expandable_faq.dart';

class FaqHelpScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onContactSupport;

  const FaqHelpScreen({
    super.key,
    required this.onBack,
    required this.onContactSupport,
  });

  @override
  Widget build(BuildContext context) {
    final faqItems = [
      const FaqItem(
        question: 'What is Campus Pulse?',
        answer:
            'Campus Pulse is an all-in-one fullstack platform for university students. It combines verified campus events with instant RSVP, smart peer study matching, timed academic quizzes, and real-time streaming leaderboards built with Flutter and Serverpod.',
      ),
      const FaqItem(
        question:
            'How does the deterministic peer study matching algorithm work?',
        answer:
            'Our deterministic matching engine analyzes shared subject interests (e.g. DSA, Operating Systems, DBMS), department branch alignment, and campus hostel proximity. A compatibility score is computed without probabilistic AI hallucinations so you always connect with the most relevant study partners.',
      ),
      const FaqItem(
        question: 'Are academic quiz questions and answer keys cheat-proof?',
        answer:
            'Yes. Questions are delivered to your device without answer keys or correct option indicators. When you submit your timed attempt, answers are evaluated authoritatively on the Serverpod backend and scored against the PostgreSQL database.',
      ),
      const FaqItem(
        question: 'How does real-time RSVP synchronization operate?',
        answer:
            'When you RSVP or cancel an RSVP for a campus event, the transaction is committed to the database and a minimal event notification is broadcast to all subscribed devices over Serverpod WebSocket streaming, updating attendance numbers without a page refresh.',
      ),
      const FaqItem(
        question: 'How is student privacy protected?',
        answer:
            'Your campus email and contact details are redacted from public discovery queries. Peer students can only see your public profile and send study requests through the platform. Contact information is only shared after you explicitly accept a connection.',
      ),
      const FaqItem(
        question: 'Can any authenticated student organize and post an event?',
        answer:
            'Yes! Any authenticated campus member can publish events for student clubs, department workshops, hackathons, or sports meets with venue details, schedules, and banners.',
      ),
      const FaqItem(
        question: 'How are leaderboard ties resolved?',
        answer:
            'Leaderboards use deterministic tie-breaking: first by highest total score, second by number of quizzes completed, third by lowest total time taken in seconds, and fourth by alphabetical student name.',
      ),
      const FaqItem(
        question:
            'Does Campus Pulse work offline or handle network disconnects?',
        answer:
            'Campus Pulse features automatic retry backoff, connection state monitoring, and optimistic UI updates for RSVPs, ensuring seamless recovery when network connectivity is restored.',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppleButton(
                label: 'Back',
                variant: AppleButtonVariant.subtle,
                icon: Icons.arrow_back,
                height: 38,
                onPressed: onBack,
              ),
              const SizedBox(height: AppleTokens.space16),

              Text(
                'Frequently Asked Questions & Help',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppleTokens.space4),
              const Text(
                'Everything you need to know about navigating and collaborating on Campus Pulse.',
              ),
              const SizedBox(height: AppleTokens.space24),

              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space24),
                child: ExpandableFaq(items: faqItems),
              ),

              const SizedBox(height: AppleTokens.space32),

              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space24),
                child: Row(
                  children: [
                    const Icon(
                      Icons.support_agent_rounded,
                      size: 36,
                      color: AppleTokens.primaryBlue,
                    ),
                    const SizedBox(width: AppleTokens.space16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Still have questions or need assistance?',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Our campus administrators and student support representatives are ready to help.',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppleTokens.space16),
                    AppleButton(
                      label: 'Contact Support',
                      onPressed: onContactSupport,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
