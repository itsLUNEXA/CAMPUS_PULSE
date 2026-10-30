import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';

class FaqItem {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});
}

class ExpandableFaq extends StatefulWidget {
  final List<FaqItem> items;

  const ExpandableFaq({super.key, required this.items});

  @override
  State<ExpandableFaq> createState() => _ExpandableFaqState();
}

class _ExpandableFaqState extends State<ExpandableFaq> {
  final Set<int> _expandedIndices = {};

  void _toggle(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? AppleTokens.darkBorder
        : AppleTokens.lightBorder;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      separatorBuilder: (_, _) =>
          Divider(color: borderColor, height: AppleTokens.space1),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isExpanded = _expandedIndices.contains(index);

        return Container(
          color: Colors.transparent,
          child: Column(
            children: [
              InkWell(
                onTap: () => _toggle(index),
                borderRadius: BorderRadius.circular(AppleTokens.radius8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppleTokens.space16,
                    horizontal: AppleTokens.space8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.question,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: AppleTokens.duration160,
                        curve: AppleTokens.defaultCurve,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 22,
                          color: isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity, height: 0),
                secondChild: Padding(
                  padding: const EdgeInsets.only(
                    left: AppleTokens.space8,
                    right: AppleTokens.space8,
                    bottom: AppleTokens.space16,
                  ),
                  child: Text(
                    item.answer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: isDark
                          ? AppleTokens.darkTextSecondary
                          : AppleTokens.secondaryText,
                    ),
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: AppleTokens.duration160,
              ),
            ],
          ),
        );
      },
    );
  }
}
