import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';

class AppleCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Gradient? gradient;

  const AppleCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppleTokens.space24),
    this.width,
    this.height,
    this.backgroundColor,
    this.gradient,
  });

  @override
  State<AppleCard> createState() => _AppleCardState();
}

class _AppleCardState extends State<AppleCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = widget.backgroundColor ?? AppleTokens.cardBg;
    final borderColor =
        _isHovered ? AppleTokens.softLavender : AppleTokens.borderPastel;

    return FocusableActionDetector(
      onShowHoverHighlight:
          widget.onTap != null ? (v) => setState(() => _isHovered = v) : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppleTokens.duration160,
          curve: AppleTokens.defaultCurve,
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.gradient == null ? surfaceColor : null,
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(AppleTokens.radius24),
            border: Border.all(
              color: borderColor,
              width: AppleTokens.space1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10111C).withValues(alpha: _isHovered ? 0.08 : 0.03),
                blurRadius: _isHovered ? 18 : 10,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
              if (_isHovered)
                BoxShadow(
                  color: AppleTokens.softLavender.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
