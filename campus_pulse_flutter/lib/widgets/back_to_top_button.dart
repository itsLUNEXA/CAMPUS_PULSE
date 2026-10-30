import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';

class BackToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  final double threshold;

  const BackToTopButton({
    super.key,
    required this.scrollController,
    this.threshold = 300.0,
  });

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;
    final isOver = widget.scrollController.offset > widget.threshold;
    if (isOver != _isVisible) {
      setState(() => _isVisible = isOver);
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: AppleTokens.duration300,
      curve: AppleTokens.defaultCurve,
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: AppleTokens.duration160,
      child: IgnorePointer(
        ignoring: !_isVisible,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _scrollToTop,
            borderRadius: BorderRadius.circular(AppleTokens.radius999),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isDark
                    ? AppleTokens.darkSurfaceElevated
                    : AppleTokens.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? AppleTokens.darkBorder
                      : AppleTokens.lightBorder,
                  width: AppleTokens.space1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_upward_rounded,
                size: 20,
                color: isDark
                    ? AppleTokens.secondaryBlue
                    : AppleTokens.primaryBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
