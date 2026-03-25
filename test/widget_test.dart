import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sample/main.dart';

void main() {
  testWidgets('Shows empty state on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.text('My Todos'), findsOneWidget);
    expect(find.text('No todos yet'), findsOneWidget);
    expect(find.text('Tap + to add one'), findsOneWidget);
  });

  testWidgets('Opens add screen when FAB is tapped', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Description (optional)'), findsOneWidget);
  });

  testWidgets('Validates empty title on submit', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a title'), findsOneWidget);
  });

  testWidgets('Adds a todo and shows it in the list', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Buy groceries');
    await tester.enterText(find.byType(TextFormField).last, 'Milk and eggs');

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('Buy groceries'), findsOneWidget);
    expect(find.text('Milk and eggs'), findsOneWidget);
    expect(find.text('No todos yet'), findsNothing);
  });

  testWidgets('Toggles todo completion', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Test task');
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, isTrue);
  });
}
