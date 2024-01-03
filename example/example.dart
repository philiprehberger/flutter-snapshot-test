// Example showing how to use SnapshotTester in your tests.
//
// In your test files:
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:philiprehberger_snapshot_test/snapshot_test.dart';
//
// void main() {
//   testWidgets('my widget snapshot', (tester) async {
//     await SnapshotTester.testWidget(
//       tester,
//       widget: const MyWidget(),
//       goldenFileName: 'goldens/my_widget.png',
//       config: SnapshotConfig.iPhone14,
//     );
//   });
//
//   testWidgets('multi-device snapshot', (tester) async {
//     await SnapshotTester.testMultiDevice(
//       tester,
//       widget: const MyWidget(),
//       goldenFilePrefix: 'goldens/my_widget',
//     );
//   });
//
//   testWidgets('theme comparison', (tester) async {
//     await SnapshotTester.testThemes(
//       tester,
//       widget: const MyWidget(),
//       goldenFilePrefix: 'goldens/my_widget',
//     );
//   });
// }

void main() {
  // This file demonstrates usage in comments.
  // Run actual snapshot tests with: flutter test --update-goldens
}
