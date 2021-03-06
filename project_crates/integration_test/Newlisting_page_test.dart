import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/common/error_popup_widgets.dart';
import 'package:flutter_application_1/screens/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:flutter_application_1/screens/listing/Newlisting_page.dart';

import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_driver/driver_extension.dart';

import '../lib/screens/common/theme.dart';

class _IsToggled extends CustomMatcher {
  _IsToggled(dynamic matcher)
      : super('Check if a switch if enabled or not', 'isToggled', matcher);

  @override
  Object featureValueOf(dynamic actual) {
    final finder =actual as Finder;
    final result = finder.evaluate().single as Switch;

    return result.value;
  }
}

Matcher isToggled(bool value) => _IsToggled(value);

void main() {
  group('New Listing', () {

    Future<void> login(WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final emailFormField = find.byKey(Key('email'));
      final passwordFormField = find.byKey(Key('password'));
      final loginButton = find.byKey(Key('Login'));


      await tester.tap(emailFormField);
      await tester.enterText(emailFormField, 'testuser@gmail.com');
      await tester.tap(passwordFormField);
      await tester.enterText(passwordFormField, 'password');
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle(Duration(seconds: 3));

      expect(find.byWidgetPredicate((widget) => widget is Home),findsOneWidget);
    }

    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    // Create Listing Full Test (NEED MANUAL ADD PHOTO) -->only show this for demo
    testWidgets('Create New Listing', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body), findsOneWidget);
      // 1. Upload Image
      final imageBtn = find.byKey(Key('image'));
      await tester.tap(imageBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));

      final cameraBtn = find.byKey(Key('Camera'));
      await tester.tap(cameraBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));
      // 2. Select
      final toggleBtn = find.byKey(Key('toggleBtn'));
      expect(tester
          .widget<ToggleButtons>(toggleBtn)
          .isSelected, [isTrue, isFalse]);

      await tester.tap(find.byKey(Key('RequestingFor')));
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(tester
          .widget<ToggleButtons>(toggleBtn)
          .isSelected, [isFalse, isTrue]);

      //3. Select Category
      await tester.tap(find.byType(DropdownButtonHideUnderline).first);
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.text('Dairy Product').last);
      await tester.pump();
      await tester.pumpAndSettle(Duration(seconds: 1));

      //final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      //await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      // await tester.pumpAndSettle(Duration(seconds: 1));

      //Enter title
      final listingTitleTextField = find.byType(TextField).first;
      await tester.tap(listingTitleTextField);
      await tester.pump();
      await tester.enterText(listingTitleTextField, 'Milk');
      await tester.pumpAndSettle(Duration(seconds: 1));

      //Enter description
      final descriptionTextField = find.byKey(Key('description'));
      await tester.tap(descriptionTextField);
      await tester.pump();
      await tester.enterText(descriptionTextField, 'Food Test Description');

      await tester.pumpAndSettle(Duration(seconds: 1));

      //Enter location
      final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.pump(const Duration(milliseconds: 100));
      TextField textField = find.widgetWithText(TextField, 'pick a location').evaluate().first.widget;
      textField.onTap();

      final locationTextField = find.byType(TextField).first;
      //await tester.tap(locationTextField);
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(locationTextField, 'Singapore 530536');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 1));

      // Submit
      await tester.pump(const Duration(milliseconds: 100));
      ElevatedButton button = find.widgetWithText(ElevatedButton, 'Create Listing').evaluate().first.widget;
      button.onPressed();
      await tester.pumpAndSettle(const Duration(seconds: 3));
    });


    /*testWidgets('listing Page', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));

      final newListingBtn = find.byIcon(Icons.add_circle_outline);
      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body),findsOneWidget);
    });
    testWidgets('Select Camera', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body),findsOneWidget);

      final imageBtn = find.byKey(Key('image'));
      await tester.tap(imageBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));

      final cameraBtn = find.byKey(Key('Camera'));
      await tester.tap(cameraBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.pumpAndSettle(Duration(seconds: 1));
      //TODO expect for camera
    });
    testWidgets('Select Photo Library', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body),findsOneWidget);

      final imageBtn = find.byKey(Key('image'));
      await tester.tap(imageBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));

      final photoLibraryBtn = find.byKey(Key('PhotoLibrary'));
      await tester.tap(photoLibraryBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));


      //TODO expect for Photo library
      await tester.pumpAndSettle(Duration(seconds: 1));

    });*/

    /*testWidgets('Please select a photo!', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body),findsOneWidget);

      final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      await tester.pumpAndSettle(Duration(seconds: 1));

      //final createListingBtn = find.byKey(Key('CreateListing'));
      await tester.pump(const Duration(milliseconds: 100));
      ElevatedButton button = find.widgetWithText(ElevatedButton, 'Create Listing').evaluate().first.widget;
      button.onPressed();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byKey(Key('Alert Dialog')),  findsOneWidget);
      expect(find.text('Please select a photo!'),  findsOneWidget);
    });

    testWidgets('Name of product cannot be empty!', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body),findsOneWidget);

      final imageBtn = find.byKey(Key('image'));
      await tester.tap(imageBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));

      final cameraBtn = find.byKey(Key('Camera'));
      await tester.tap(cameraBtn);
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.tap(find.byType(DropdownButtonHideUnderline).first);
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.text('Dairy Product').last);
      await tester.pump();
      await tester.pumpAndSettle(Duration(seconds: 1));

      final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      await tester.pumpAndSettle(Duration(seconds: 1));

      await tester.pump(const Duration(milliseconds: 100));
      ElevatedButton button = find.widgetWithText(ElevatedButton, 'Create Listing').evaluate().first.widget;
      button.onPressed();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byKey(Key('Alert Dialog')),  findsOneWidget);
      expect(find.text('Name of product cannot be empty!'),  findsOneWidget);
    });

     //TODO Address cannot be empty!
    testWidgets('Empty Address', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body),findsOneWidget);

      //TODO add empty address
    });

    testWidgets('Select Giving Away!', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(
          find.byWidgetPredicate((widget) => widget is Body), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 1));
      final toggleBtn = find.byKey(Key('toggleBtn'));
      expect(tester
          .widget<ToggleButtons>(toggleBtn)
          .isSelected, [isTrue, isFalse]);


      await tester.tap(find.byKey(Key('RequestingFor')));
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(tester
          .widget<ToggleButtons>(toggleBtn)
          .isSelected, [isFalse, isTrue]);
    });

    testWidgets('Select Request For!', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(
          find.byWidgetPredicate((widget) => widget is Body), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 2));
      final toggleBtn = find.byKey(Key('toggleBtn'));
      expect(tester.widget<ToggleButtons>(toggleBtn).isSelected, [isTrue, isFalse]);


      await tester.tap(find.byKey(Key('GivingAway')));
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(tester.widget<ToggleButtons>(toggleBtn).isSelected, [isTrue, isFalse]);
    });
    testWidgets('Select Category', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(
          find.byWidgetPredicate((widget) => widget is Body), findsOneWidget);

      await tester.tap(find.byType(DropdownButtonHideUnderline).first);
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.text('Dairy Product').last);
      await tester.pump();
      await tester.pumpAndSettle(Duration(seconds: 1));

      expect(find.text('Dairy Product'), findsOneWidget);
    });
    testWidgets('Enter Listing Title', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(
          find.byWidgetPredicate((widget) => widget is Body), findsOneWidget);

      final listingTitleTextField = find
          .byType(TextField)
          .first;
      await tester.tap(listingTitleTextField);
      await tester.pump();
      await tester.enterText(listingTitleTextField, 'Food Test Listing');

      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.text('Food Test Listing'), findsOneWidget);
    });
    testWidgets('Enter description', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(
          find.byWidgetPredicate((widget) => widget is Body), findsOneWidget);

      final descriptionTextField = find.byKey(Key('description'));
      await tester.tap(descriptionTextField);
      await tester.pump();
      await tester.enterText(descriptionTextField, 'Food Test Description');

      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.text('Food Test Description'), findsOneWidget);
    });

    testWidgets('Enter Location', (WidgetTester tester) async {
      await login(tester);
      await tester.pumpAndSettle(Duration(seconds: 3));
      final newListingBtn = find.byIcon(Icons.add_circle_outline);

      await tester.tap(newListingBtn);
      await tester.pumpAndSettle(Duration(seconds: 2));

      expect(find.byWidgetPredicate((widget) => widget is Body), findsOneWidget);

      final gesture = await tester.startGesture(Offset(0, 300)); //Position of the scrollview
      await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      await tester.pumpAndSettle(Duration(seconds: 1));

      final locationTextField = find.byType(TextField).last;
      await tester.tap(locationTextField);
      await tester.pump();
      await tester.pumpAndSettle(Duration(seconds: 1));
      await tester.enterText(locationTextField, 'Test');

      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.text('Test'), findsOneWidget);
    });*/
  });
}