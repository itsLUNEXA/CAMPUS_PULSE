import 'package:flutter/material.dart';
import '../theme/linea_tokens.dart';

/// Reusable Card component for CAMPULSE
class LineaCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  const LineaCard({
    super.key,
    required this.child,
    this.backgroundColor = LineaTokens.surfaceWarm,
    this.borderRadius = LineaTokens.radius11,
    this.padding = const EdgeInsets.all(16.0),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: LineaTokens.borderSubtle,
          width: LineaTokens.space1,
        ),
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: cardContent,
      );
    }
    return cardContent;
  }
}

/// Primary / Secondary action button for CAMPULSE
class LineaButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final IconData? icon;

  const LineaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isSecondary = false,
    this.icon,
  });

  @override
  State<LineaButton> createState() => _LineaButtonState();
}

class _LineaButtonState extends State<LineaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isSecondary
        ? LineaTokens.secondary
        : LineaTokens.primary;
    const fgColor = Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: LineaTokens.durationFast,
        decoration: BoxDecoration(
          color: widget.onPressed == null
              ? LineaTokens.neutralSilver
              : (_isHovered
                    ? (widget.isSecondary
                          ? LineaTokens.tealHover
                          : const Color(0xFF1B2433))
                    : bgColor),
          borderRadius: BorderRadius.circular(LineaTokens.radius11),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(LineaTokens.radius11),
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, size: 16, color: fgColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: LineaTokens.buttonText.copyWith(color: fgColor),
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

/// Clean input field adhering to design tokens
class LineaInput extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? labelText;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  const LineaInput({
    super.key,
    this.controller,
    required this.hintText,
    this.labelText,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(labelText!, style: LineaTokens.label),
          const SizedBox(height: 6),
        ],
        Container(
          decoration: BoxDecoration(
            color: LineaTokens.white,
            borderRadius: BorderRadius.circular(LineaTokens.radius11),
            border: Border.all(
              color: LineaTokens.borderSubtle,
              width: LineaTokens.space1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: LineaTokens.body.copyWith(color: LineaTokens.neutralDark),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: LineaTokens.body.copyWith(
                color: LineaTokens.neutralSlate,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ],
    );
  }
}
