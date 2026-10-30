import 'package:flutter/material.dart';
import '../services/auth_state.dart';
import '../services/preferences_service.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class SettingsScreen extends StatelessWidget {
  final AuthState authState;
  final PreferencesService preferencesService;
  final VoidCallback onBack;

  const SettingsScreen({
    super.key,
    required this.authState,
    required this.preferencesService,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
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
                'Settings & Preferences',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppleTokens.space4),
              const Text(
                'Customize your appearance, data choices, and account session.',
              ),
              const SizedBox(height: AppleTokens.space24),

              // Appearance Card
              Text(
                'Appearance & Theme (UX Feature 14.1)',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppleTokens.space12),
              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space20),
                child: ListenableBuilder(
                  listenable: preferencesService,
                  builder: (context, _) {
                    final mode = preferencesService.themeMode;
                    return RadioGroup<ThemeMode>(
                      groupValue: mode,
                      onChanged: (v) {
                        if (v != null) preferencesService.setThemeMode(v);
                      },
                      child: Column(
                        children: [
                          RadioListTile<ThemeMode>(
                            title: const Text('System Appearance (Auto)'),
                            subtitle: const Text(
                              'Matches your operating system light/dark mode settings.',
                            ),
                            value: ThemeMode.system,
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Light Mode'),
                            subtitle: const Text(
                              'Clean white surfaces with high-contrast text.',
                            ),
                            value: ThemeMode.light,
                          ),
                          RadioListTile<ThemeMode>(
                            title: const Text('Dark Mode'),
                            subtitle: const Text(
                              'Deep black background inspired by Apple pro interfaces.',
                            ),
                            value: ThemeMode.dark,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppleTokens.space28),

              // Privacy & Data Choices Card
              Text(
                'Privacy & Telemetry (UX Feature 14.2)',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppleTokens.space12),
              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space20),
                child: ListenableBuilder(
                  listenable: preferencesService,
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Essential local storage is strictly utilized for your authentication token and session recovery. We never sell your personal student data.',
                          style: TextStyle(height: 1.4),
                        ),
                        const SizedBox(height: AppleTokens.space16),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Anonymous Performance Insights'),
                          subtitle: const Text(
                            'Share anonymized response latency metrics to help diagnose peer matchmaking delays.',
                          ),
                          value: preferencesService.analyticsConsent,
                          onChanged: (v) {
                            preferencesService.setCookieConsent(
                              accepted: true,
                              allowAnalytics: v,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: AppleTokens.space28),

              // Account & Session Card
              if (authState.isAuthenticated) ...[
                Text(
                  'Account Session',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppleTokens.space12),
                AppleCard(
                  padding: const EdgeInsets.all(AppleTokens.space20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: isDark
                            ? AppleTokens.secondaryBlue
                            : AppleTokens.primaryBlue,
                        child: Text(
                          authState.currentProfile?.fullName.isNotEmpty == true
                              ? authState.currentProfile!.fullName[0]
                                    .toUpperCase()
                              : 'S',
                          style: TextStyle(
                            color: isDark ? Colors.black : Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppleTokens.space16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authState.currentProfile?.fullName ??
                                  'Authenticated Student',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              authState.currentProfile?.email ?? 'Campus Email',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      AppleButton(
                        label: 'Sign Out',
                        variant: AppleButtonVariant.destructive,
                        height: 36,
                        onPressed: () {
                          authState.signOut();
                          onBack();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
