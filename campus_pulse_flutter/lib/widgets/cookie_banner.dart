import 'package:flutter/material.dart';
import '../services/preferences_service.dart';
import '../theme/apple_tokens.dart';
import 'apple_button.dart';

class CookieBanner extends StatefulWidget {
  final PreferencesService preferencesService;

  const CookieBanner({super.key, required this.preferencesService});

  @override
  State<CookieBanner> createState() => _CookieBannerState();
}

class _CookieBannerState extends State<CookieBanner> {
  bool _showPreferences = false;
  bool _allowAnalytics = false;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.preferencesService,
      builder: (context, _) {
        if (widget.preferencesService.hasConsentedToCookies) {
          return const SizedBox.shrink();
        }

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final surfaceColor = isDark
            ? AppleTokens.darkSurfaceElevated
            : AppleTokens.white;
        final borderColor = isDark
            ? AppleTokens.darkBorder
            : AppleTokens.lightBorder;

        return Positioned(
          bottom: AppleTokens.space24,
          left: AppleTokens.space24,
          right: AppleTokens.space24,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 820),
              child: Material(
                elevation: 8,
                shadowColor: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppleTokens.radius16),
                child: Container(
                  padding: const EdgeInsets.all(AppleTokens.space24),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(AppleTokens.radius16),
                    border: Border.all(
                      color: borderColor,
                      width: AppleTokens.space1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.privacy_tip_outlined,
                            size: 20,
                            color: isDark
                                ? AppleTokens.secondaryBlue
                                : AppleTokens.primaryBlue,
                          ),
                          const SizedBox(width: AppleTokens.space8),
                          Text(
                            'Privacy & Campus Data Choices',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppleTokens.space12),
                      Text(
                        'CAMPULSE uses essential local storage to keep your session authenticated and remember your interface preferences. Optional telemetry is only collected with your explicit consent to improve student matchmaking.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (_showPreferences) ...[
                        const SizedBox(height: AppleTokens.space16),
                        Container(
                          padding: const EdgeInsets.all(AppleTokens.space12),
                          decoration: BoxDecoration(
                            color:
                                (isDark
                                        ? AppleTokens.black
                                        : AppleTokens.lightNeutral)
                                    .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius8,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: AppleTokens.success,
                                  ),
                                  const SizedBox(width: AppleTokens.space8),
                                  const Expanded(
                                    child: Text(
                                      'Essential Authentication & Token Storage (Required)',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppleTokens.space8),
                              SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text(
                                  'Performance & Usage Insights (Optional)',
                                ),
                                subtitle: const Text(
                                  'Helps us optimize quiz load times and peer matching latency.',
                                ),
                                value: _allowAnalytics,
                                onChanged: (v) =>
                                    setState(() => _allowAnalytics = v),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: AppleTokens.space16),
                      Wrap(
                        spacing: AppleTokens.space12,
                        runSpacing: AppleTokens.space8,
                        alignment: WrapAlignment.end,
                        children: [
                          AppleButton(
                            label: _showPreferences
                                ? 'Hide Options'
                                : 'Preferences',
                            variant: AppleButtonVariant.subtle,
                            height: 38,
                            onPressed: () => setState(
                              () => _showPreferences = !_showPreferences,
                            ),
                          ),
                          AppleButton(
                            label: 'Reject Optional',
                            variant: AppleButtonVariant.secondary,
                            height: 38,
                            onPressed: () {
                              widget.preferencesService.setCookieConsent(
                                accepted: false,
                                allowAnalytics: false,
                              );
                            },
                          ),
                          AppleButton(
                            label: 'Accept Choices',
                            variant: AppleButtonVariant.primary,
                            height: 38,
                            onPressed: () {
                              widget.preferencesService.setCookieConsent(
                                accepted: true,
                                allowAnalytics: _allowAnalytics,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
