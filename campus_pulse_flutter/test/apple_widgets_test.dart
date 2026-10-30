import 'package:campus_pulse_flutter/widgets/apple_button.dart';
import 'package:campus_pulse_flutter/widgets/confirmation_dialog.dart';
import 'package:campus_pulse_flutter/widgets/expandable_faq.dart';
import 'package:campus_pulse_flutter/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Apple Reusable Components', () {
    testWidgets('AppleButton renders label and triggers tap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppleButton(
              label: 'RSVP Now',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('RSVP Now'), findsOneWidget);
      await tester.tap(find.text('RSVP Now'));
      expect(tapped, isTrue);
    });

    testWidgets('AppleButton shows spinner when loading and disables tap', (
      tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppleButton(
              label: 'Submit',
              isLoading: true,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(AppleButton));
      expect(tapped, isFalse);
    });

    testWidgets('PasswordTextField toggles visibility', (tester) async {
      final ctrl = TextEditingController(text: 'secret123');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordTextField(controller: ctrl),
          ),
        ),
      );

      // Initially obscured
      final textFieldFinder = find.byType(TextField);
      TextField textField = tester.widget(textFieldFinder);
      expect(textField.obscureText, isTrue);

      // Tap toggle icon
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      textField = tester.widget(textFieldFinder);
      expect(textField.obscureText, isFalse);
    });

    testWidgets('ExpandableFaq expands on tap', (tester) async {
      const faqList = [
        FaqItem(
          question: 'How does RSVP work?',
          answer: 'Real-time WebSocket streaming updates seats.',
        ),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ExpandableFaq(items: faqList),
          ),
        ),
      );

      expect(find.text('How does RSVP work?'), findsOneWidget);
      // Tap question
      await tester.tap(find.text('How does RSVP work?'));
      await tester.pumpAndSettle();

      expect(
        find.text('Real-time WebSocket streaming updates seats.'),
        findsOneWidget,
      );
    });

    testWidgets('ConfirmationDialog shows and cancels properly', (
      tester,
    ) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () async {
                  result = await ConfirmationDialog.show(
                    ctx,
                    title: 'Confirm Action',
                    message: 'Are you sure?',
                  );
                },
                child: const Text('Open Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm Action'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });
  });
}
