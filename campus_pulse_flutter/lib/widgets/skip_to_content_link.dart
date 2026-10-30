import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';

class SkipToContentLink extends StatefulWidget {
  final FocusNode targetFocusNode;

  const SkipToContentLink({super.key, required this.targetFocusNode});

  @override
  State<SkipToContentLink> createState() => _SkipToContentLinkState();
}

class _SkipToContentLinkState extends State<SkipToContentLink> {
  final FocusNode _linkFocusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _linkFocusNode.addListener(() {
      setState(() => _isFocused = _linkFocusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _linkFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFocused) {
      return Focus(
        focusNode: _linkFocusNode,
        child: const SizedBox(width: 0, height: 0),
      );
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Positioned(
      top: AppleTokens.space8,
      left: AppleTokens.space16,
      child: Focus(
        focusNode: _linkFocusNode,
        child: InkWell(
          onTap: () {
            widget.targetFocusNode.requestFocus();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppleTokens.space16,
              vertical: AppleTokens.space8,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? AppleTokens.secondaryBlue
                  : AppleTokens.primaryBlue,
              borderRadius: BorderRadius.circular(AppleTokens.radius8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Text(
              'Skip to Main Content',
              style: TextStyle(
                color: isDark ? AppleTokens.black : AppleTokens.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
