import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:re_editor/re_editor.dart';

void main() {
  testWidgets('inserts a newline and deletes one character', (tester) async {
    final controller = CodeLineEditingController.fromText('first');
    final focusNode = FocusNode();
    addTearDown(() {
      controller.dispose();
      focusNode.dispose();
    });

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CodeEditor(controller: controller, focusNode: focusNode),
        ),
      ),
    );
    await tester.tap(find.byType(CodeEditor));
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(controller.text, 'first\n');

    await tester.testTextInput.receiveAction(TextInputAction.newline);
    expect(controller.text, 'first\n');

    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    expect(controller.text, 'first');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 150));
  });
}
