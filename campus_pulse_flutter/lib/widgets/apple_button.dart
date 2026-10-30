import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';

enum AppleButtonVariant { primary, secondary, outline, subtle, destructive }

class AppleButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppleButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  const AppleButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppleButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 44.0, // Apple 44px touch target
    this.padding,
  });

  @override
  State<AppleButton> createState() => _AppleButtonState();
}

class _AppleButtonState extends State<AppleButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    // Determine colors based on variant and theme
    Color backgroundColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;

    switch (widget.variant) {
      case AppleButtonVariant.primary:
        backgroundColor = AppleTokens.darkNavy;
        textColor = Colors.white;
        if (_isHovered && isEnabled) {
          backgroundColor = const Color(0xFF262738);
        }
        break;

      case AppleButtonVariant.secondary:
        backgroundColor = AppleTokens.softLavender;
        textColor = AppleTokens.darkNavy;
        borderSide = BorderSide.none;
        if (_isHovered && isEnabled) {
          backgroundColor = const Color(0xFFC8B4FF);
        }
        break;

      case AppleButtonVariant.outline:
        backgroundColor = AppleTokens.pureWhite;
        final strokeColor = AppleTokens.borderPastel;
        textColor = AppleTokens.darkNavy;
        borderSide = BorderSide(color: strokeColor, width: 1.2);
        if (_isHovered && isEnabled) {
          backgroundColor = AppleTokens.paleLavender;
        }
        break;

      case AppleButtonVariant.subtle:
        backgroundColor = Colors.transparent;
        textColor = AppleTokens.softLavender;
        if (_isHovered && isEnabled) {
          backgroundColor = AppleTokens.paleLavender;
        }
        break;

      case AppleButtonVariant.destructive:
        backgroundColor = AppleTokens.error;
        textColor = Colors.white;
        if (_isHovered && isEnabled) {
          backgroundColor = AppleTokens.error.withValues(alpha: 0.85);
        }
        break;
    }

    if (!isEnabled) {
      backgroundColor = AppleTokens.borderPastel;
      textColor = AppleTokens.textMutedGrey;
      borderSide = BorderSide.none;
    }

    final double scale = _isPressed && isEnabled ? 0.98 : 1.0;

    return FocusableActionDetector(
      onShowHoverHighlight: (v) => setState(() => _isHovered = v),
      child: GestureDetector(
        onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
        onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
        onTapCancel: isEnabled
            ? () => setState(() => _isPressed = false)
            : null,
        onTap: isEnabled ? widget.onPressed : null,
        child: AnimatedScale(
          scale: scale,
          duration: AppleTokens.duration100,
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: AppleTokens.duration160,
            curve: AppleTokens.defaultCurve,
            width: widget.width,
            height: widget.height,
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(horizontal: AppleTokens.space20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppleTokens.radius999),
              border: borderSide != BorderSide.none
                  ? Border.fromBorderSide(borderSide)
                  : null,
            ),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, size: 16, color: textColor),
                          const SizedBox(width: AppleTokens.space8),
                        ],
                        Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
