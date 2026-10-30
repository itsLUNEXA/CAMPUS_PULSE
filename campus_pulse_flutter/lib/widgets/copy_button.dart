import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_tokens.dart';

class CopyButton extends StatefulWidget {
  final String textToCopy;
  final String label;

  const CopyButton({
    super.key,
    required this.textToCopy,
    this.label = 'Copy Link',
  });

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _copied = false;
  Timer? _timer;

  void _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.textToCopy));
    setState(() => _copied = true);

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return OutlinedButton.icon(
      onPressed: _copy,
      style: OutlinedButton.styleFrom(
        foregroundColor: _copied
            ? AppleTokens.success
            : (isDark ? AppleTokens.secondaryBlue : AppleTokens.primaryBlue),
        side: BorderSide(
          color: _copied
              ? AppleTokens.success
              : (isDark ? AppleTokens.secondaryBlue : AppleTokens.primaryBlue),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space16,
          vertical: AppleTokens.space8,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius999),
        ),
      ),
      icon: Icon(
        _copied ? Icons.check_circle_outline : Icons.content_copy_rounded,
        size: 16,
      ),
      label: Text(_copied ? 'Copied!' : widget.label),
    );
  }
}
