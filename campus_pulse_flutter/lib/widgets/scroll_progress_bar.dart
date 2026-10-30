import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';

class ScrollProgressBar extends StatefulWidget {
  final ScrollController scrollController;

  const ScrollProgressBar({super.key, required this.scrollController});

  @override
  State<ScrollProgressBar> createState() => _ScrollProgressBarState();
}

class _ScrollProgressBarState extends State<ScrollProgressBar> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!widget.scrollController.hasClients) return;
    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.offset;
    if (maxScroll > 0) {
      final p = (currentScroll / maxScroll).clamp(0.0, 1.0);
      if ((p - _progress).abs() > 0.01) {
        setState(() => _progress = p);
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppleTokens.secondaryBlue : AppleTokens.primaryBlue;

    return SizedBox(
      height: 2.5,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: AppleTokens.duration100,
              width: constraints.maxWidth * _progress,
              color: color,
            ),
          );
        },
      ),
    );
  }
}
