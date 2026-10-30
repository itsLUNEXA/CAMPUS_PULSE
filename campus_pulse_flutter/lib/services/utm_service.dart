class UtmParameters {
  final String? source;
  final String? medium;
  final String? campaign;
  final String? term;
  final String? content;

  const UtmParameters({
    this.source,
    this.medium,
    this.campaign,
    this.term,
    this.content,
  });

  bool get hasAny =>
      source != null ||
      medium != null ||
      campaign != null ||
      term != null ||
      content != null;

  Map<String, String> toMap() {
    final map = <String, String>{};
    if (source != null) map['utm_source'] = source!;
    if (medium != null) map['utm_medium'] = medium!;
    if (campaign != null) map['utm_campaign'] = campaign!;
    if (term != null) map['utm_term'] = term!;
    if (content != null) map['utm_content'] = content!;
    return map;
  }
}

class UtmService {
  static UtmParameters? _current;
  static UtmParameters get current => _current ?? const UtmParameters();

  /// Safely extracts and sanitizes incoming UTM parameters from a URI.
  static void parseUri(Uri uri) {
    final query = uri.queryParameters;
    _current = UtmParameters(
      source: _sanitize(query['utm_source']),
      medium: _sanitize(query['utm_medium']),
      campaign: _sanitize(query['utm_campaign']),
      term: _sanitize(query['utm_term']),
      content: _sanitize(query['utm_content']),
    );
  }

  static String? _sanitize(String? val) {
    if (val == null) return null;
    final trimmed = val.trim();
    if (trimmed.isEmpty) return null;
    // Strip control characters and sanitize
    return trimmed.replaceAll(RegExp(r'[\r\n\t]'), '').take(100);
  }
}

extension _StringLimit on String {
  String take(int n) => length <= n ? this : substring(0, n);
}
