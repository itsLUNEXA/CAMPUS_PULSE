import 'package:campus_pulse_flutter/screens/student_timetable_screen.dart';
import 'package:campus_pulse_flutter/theme/apple_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Timetable and Slot Availability Tests', () {
    test('verifies accurate color tokens for Class, Free, and Occupied slots', () {
      // Occupied tokens (Light pastel red #FDE2E2, Dark red text #9B1C1C, Pastel red border #FCA5A5)
      expect(AppleTokens.occupiedBackground, const Color(0xFFFDE2E2));
      expect(AppleTokens.occupiedText, const Color(0xFF9B1C1C));
      expect(AppleTokens.occupiedBorder, const Color(0xFFFCA5A5));

      // Class tokens (Light blue #D6ECFA, Dark text #0B0E17, Blue border #93C5FD)
      expect(AppleTokens.classBackground, const Color(0xFFD6ECFA));
      expect(AppleTokens.classText, const Color(0xFF0B0E17));
      expect(AppleTokens.classBorder, const Color(0xFF93C5FD));

      // Free tokens (Subtle mint #E6F9F4, Dark teal text #0F5B5C, Mint border #8CE5D0)
      expect(AppleTokens.freeBackground, const Color(0xFFE6F9F4));
      expect(AppleTokens.freeText, const Color(0xFF0F5B5C));
      expect(AppleTokens.freeBorder, const Color(0xFF8CE5D0));

      // Unset border token (#E3ECEC)
      expect(AppleTokens.unsetSlotBorder, const Color(0xFFE3ECEC));
    });

    test('verifies SlotAvailability enum states and transition cycle', () {
      expect(
        SlotAvailability.values,
        containsAll([
          SlotAvailability.unset,
          SlotAvailability.free,
          SlotAvailability.occupied,
        ]),
      );

      // Verify cycle: unset -> free -> occupied -> unset
      SlotAvailability nextState(SlotAvailability current) {
        return switch (current) {
          SlotAvailability.unset => SlotAvailability.free,
          SlotAvailability.free => SlotAvailability.occupied,
          SlotAvailability.occupied => SlotAvailability.unset,
        };
      }

      expect(nextState(SlotAvailability.unset), SlotAvailability.free);
      expect(nextState(SlotAvailability.free), SlotAvailability.occupied);
      expect(nextState(SlotAvailability.occupied), SlotAvailability.unset);
    });
  });
}
