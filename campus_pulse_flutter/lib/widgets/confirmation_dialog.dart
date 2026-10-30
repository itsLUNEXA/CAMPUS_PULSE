import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';
import 'apple_button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => ConfirmationDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppleTokens.radius16),
      ),
      backgroundColor: isDark
          ? AppleTokens.darkSurfaceElevated
          : AppleTokens.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(AppleTokens.space24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppleTokens.space12),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppleTokens.darkTextSecondary
                      : AppleTokens.secondaryText,
                ),
              ),
              const SizedBox(height: AppleTokens.space24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppleButton(
                    label: cancelLabel,
                    variant: AppleButtonVariant.subtle,
                    height: 38,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  const SizedBox(width: AppleTokens.space12),
                  AppleButton(
                    label: confirmLabel,
                    variant: isDestructive
                        ? AppleButtonVariant.destructive
                        : AppleButtonVariant.primary,
                    height: 38,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
