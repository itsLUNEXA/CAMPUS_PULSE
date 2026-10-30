import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';

class AppleCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Gradient? gradient;

  const AppleCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
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
    final surfaceColor = widget.backgroundColor ?? Colors.white;
    final borderColor = _isHovered
        ? AppleTokens.purple
        : AppleTokens.borderSubtle;

    return FocusableActionDetector(
      onShowHoverHighlight: widget.onTap != null
          ? (v) => setState(() => _isHovered = v)
          : null,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppleTokens.durationFast,
          curve: AppleTokens.defaultCurve,
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.gradient == null ? surfaceColor : null,
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(AppleTokens.radius12),
            border: Border.all(
              color: borderColor,
              width: AppleTokens.space1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0x0A000000),
                blurRadius: _isHovered ? 6 : 2,
                offset: Offset(0, _isHovered ? 2 : 1),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
