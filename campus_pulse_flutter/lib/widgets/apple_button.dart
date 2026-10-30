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
    this.height = 42.0,
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

    Color backgroundColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;

    switch (widget.variant) {
      case AppleButtonVariant.primary:
        backgroundColor = AppleTokens.primaryButton;
        textColor = AppleTokens.primaryButtonText;
        if (_isHovered && isEnabled) {
          backgroundColor = const Color(0xFF1B2433);
        }
        break;

      case AppleButtonVariant.secondary:
        backgroundColor = AppleTokens.primaryTeal;
        textColor = Colors.white;
        if (_isHovered && isEnabled) {
          backgroundColor = AppleTokens.tealHover;
        }
        break;

      case AppleButtonVariant.outline:
        backgroundColor = Colors.white;
        textColor = AppleTokens.primaryText;
        borderSide = const BorderSide(
          color: AppleTokens.borderSubtle,
          width: 1.0,
        );
        if (_isHovered && isEnabled) {
          backgroundColor = AppleTokens.pageBackground;
        }
        break;

      case AppleButtonVariant.subtle:
        backgroundColor = Colors.transparent;
        textColor = AppleTokens.primaryTeal;
        if (_isHovered && isEnabled) {
          backgroundColor = AppleTokens.lightMint.withValues(alpha: 0.5);
        }
        break;

      case AppleButtonVariant.destructive:
        backgroundColor = AppleTokens.error;
        textColor = Colors.white;
        if (_isHovered && isEnabled) {
          backgroundColor = const Color(0xFFB71C1C);
        }
        break;
    }

    if (!isEnabled) {
      backgroundColor = AppleTokens.borderAndDivider;
      textColor = AppleTokens.mutedText;
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
          duration: AppleTokens.durationFast,
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: AppleTokens.durationFast,
            curve: AppleTokens.defaultCurve,
            width: widget.width,
            height: widget.height,
            padding:
                widget.padding ?? const EdgeInsets.symmetric(horizontal: 18.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppleTokens.radius8),
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
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            letterSpacing: -0.1,
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
