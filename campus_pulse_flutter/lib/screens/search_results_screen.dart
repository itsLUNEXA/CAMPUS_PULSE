import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../client.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class SearchResultsScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String eventId) onSelectEvent;

  const SearchResultsScreen({
    super.key,
    required this.onBack,
    required this.onSelectEvent,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _queryCtrl = TextEditingController();
  Timer? _debounceTimer;

  List<SearchItem> _results = [];
  bool _isLoading = false;
  String _currentQuery = '';

  @override
  void dispose() {
    _queryCtrl.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    _debounceTimer?.cancel();
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      setState(() {
        _results = [];
        _isLoading = false;
        _currentQuery = '';
      });
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _executeSearch(trimmed);
    });
  }

  Future<void> _executeSearch(String query) async {
    setState(() {
      _isLoading = true;
      _currentQuery = query;
    });

    try {
      final response = await client.search.search(query, limit: 25);
      if (mounted) {
        setState(() {
          _results = response.items;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppleButton(
                label: 'Back',
                variant: AppleButtonVariant.subtle,
                icon: Icons.arrow_back,
                height: 38,
                onPressed: widget.onBack,
              ),
              const SizedBox(height: AppleTokens.space16),

              Text(
                'Campus Search',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppleTokens.space4),
              const Text(
                'Search across campus events, topics, peer study partners, and announcements.',
              ),
              const SizedBox(height: AppleTokens.space24),

              // Search Bar
              TextField(
                controller: _queryCtrl,
                autofocus: true,
                onChanged: _onQueryChanged,
                decoration: InputDecoration(
                  hintText:
                      'Search for "Hackathon", "DSA", "DBMS", "Kaveri", etc...',
                  prefixIcon: const Icon(Icons.search_rounded, size: 22),
                  suffixIcon: _queryCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _queryCtrl.clear();
                            _onQueryChanged('');
                          },
                        )
                      : null,
                ),
              ),
              const SizedBox(height: AppleTokens.space24),

              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_currentQuery.isEmpty)
                AppleCard(
                  padding: const EdgeInsets.all(AppleTokens.space40),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          size: 48,
                          color: AppleTokens.secondaryText,
                        ),
                        const SizedBox(height: AppleTokens.space16),
                        Text(
                          'Type a Query to Search',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppleTokens.space8),
                        const Text(
                          'Discover events, study groups, and student profiles in real-time.',
                        ),
                      ],
                    ),
                  ),
                )
              else if (_results.isEmpty)
                AppleCard(
                  padding: const EdgeInsets.all(AppleTokens.space40),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: AppleTokens.secondaryText,
                        ),
                        const SizedBox(height: AppleTokens.space16),
                        Text(
                          'No Results for "$_currentQuery"',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppleTokens.space8),
                        const Text(
                          'Try searching with different keywords or broader terms.',
                        ),
                      ],
                    ),
                  ),
                )
              else ...[
                Text(
                  'Found ${_results.length} results for "$_currentQuery"',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppleTokens.darkTextSecondary
                        : AppleTokens.secondaryText,
                  ),
                ),
                const SizedBox(height: AppleTokens.space16),
                ..._results.map(
                  (item) => _searchResultCard(context, item, isDark),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchResultCard(BuildContext context, SearchItem item, bool isDark) {
    IconData icon = Icons.event;
    Color iconColor = AppleTokens.primaryBlue;

    if (item.type == 'student') {
      icon = Icons.person_outline;
      iconColor = AppleTokens.success;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppleTokens.space12),
      child: AppleCard(
        onTap: () {
          if (item.type == 'event') {
            widget.onSelectEvent(item.id);
          }
        },
        padding: const EdgeInsets.all(AppleTokens.space16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppleTokens.radius8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: AppleTokens.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppleTokens.darkSurfaceElevated
                              : AppleTokens.lightNeutral,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius999,
                          ),
                        ),
                        child: Text(
                          item.type.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  if (item.description != null &&
                      item.description!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppleTokens.darkTextSecondary
                            : AppleTokens.secondaryText,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
