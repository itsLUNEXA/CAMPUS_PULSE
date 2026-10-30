import 'package:campus_pulse_flutter/services/utm_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UTM Tracking Parameter Service', () {
    test('parses and sanitizes valid UTM query parameters', () {
      final uri = Uri.parse(
        'https://campuspulse.edu/?utm_source=hackathon_newsletter&utm_medium=email&utm_campaign=fall_2026&utm_term=dsa&utm_content=button_cta',
      );

      UtmService.parseUri(uri);
      final params = UtmService.current;

      expect(params.source, 'hackathon_newsletter');
      expect(params.medium, 'email');
      expect(params.campaign, 'fall_2026');
      expect(params.term, 'dsa');
      expect(params.content, 'button_cta');
      expect(params.hasAny, isTrue);
    });

    test('ignores missing UTM parameters cleanly', () {
      final uri = Uri.parse('https://campuspulse.edu/');

      UtmService.parseUri(uri);
      final params = UtmService.current;

      expect(params.source, isNull);
      expect(params.hasAny, isFalse);
    });

    test('strips control characters and limits length', () {
      final uri = Uri.parse(
        'https://campuspulse.edu/?utm_source=clean\n\tsource',
      );

      UtmService.parseUri(uri);
      final params = UtmService.current;

      expect(params.source, 'cleansource');
    });
  });
}
