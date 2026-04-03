# philiprehberger_snapshot_test

[![Tests](https://github.com/philiprehberger/flutter-snapshot-test/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/flutter-snapshot-test/actions/workflows/ci.yml)
[![pub package](https://img.shields.io/pub/v/philiprehberger_snapshot_test.svg)](https://pub.dev/packages/philiprehberger_snapshot_test)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/flutter-snapshot-test)](https://github.com/philiprehberger/flutter-snapshot-test/commits/main)

Visual snapshot testing for Flutter widgets with golden file comparison

## Requirements

- Flutter >= 3.24.0
- Dart >= 3.6

## Installation

Add to your `pubspec.yaml`:

```yaml
dev_dependencies:
  philiprehberger_snapshot_test: ^0.2.0
```

Then run:

```bash
flutter pub get
```

## Usage

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:philiprehberger_snapshot_test/snapshot_test.dart';

void main() {
  testWidgets('widget snapshot', (tester) async {
    await SnapshotTester.testWidget(
      tester,
      widget: const MyWidget(),
      goldenFileName: 'goldens/my_widget.png',
    );
  });
}
```

### Multi-Device Testing

Test a widget across multiple device configurations at once:

```dart
testWidgets('multi-device snapshot', (tester) async {
  await SnapshotTester.testMultiDevice(
    tester,
    widget: const MyWidget(),
    goldenFilePrefix: 'goldens/my_widget',
  );
});
```

### Theme Comparison

Compare light and dark theme rendering side by side:

```dart
testWidgets('theme comparison', (tester) async {
  await SnapshotTester.testThemes(
    tester,
    widget: const MyWidget(),
    goldenFilePrefix: 'goldens/my_widget',
  );
});
```

### Custom Device Configs

Define your own device configurations:

```dart
const galaxyFold = SnapshotConfig(
  name: 'Galaxy Fold',
  size: Size(280, 653),
  devicePixelRatio: 3.0,
);

testWidgets('custom device', (tester) async {
  await SnapshotTester.testWidget(
    tester,
    widget: const MyWidget(),
    goldenFileName: 'goldens/my_widget_fold.png',
    config: galaxyFold,
  );
});
```

### Orientation Testing

Test a widget in both portrait and landscape orientations:

```dart
testWidgets('orientation snapshot', (tester) async {
  await SnapshotTester.testOrientations(
    tester,
    widget: const MyWidget(),
    goldenFilePrefix: 'goldens/my_widget',
  );
});
```

### State Testing

Test multiple widget states with a single call:

```dart
testWidgets('state snapshots', (tester) async {
  await SnapshotTester.testStates(
    tester,
    states: {
      'empty': const MyWidget(items: []),
      'loaded': const MyWidget(items: ['a', 'b']),
      'error': const MyWidget(error: 'Something went wrong'),
    },
    goldenFilePrefix: 'goldens/my_widget',
  );
});
```

### Accessibility Testing

Test with multiple text scale factors for accessibility:

```dart
testWidgets('accessibility snapshot', (tester) async {
  await SnapshotTester.testAccessibility(
    tester,
    widget: const MyWidget(),
    goldenFilePrefix: 'goldens/my_widget',
  );
});
```

Test with large text scaling using config variants:

```dart
testWidgets('large text snapshot', (tester) async {
  await SnapshotTester.testWidget(
    tester,
    widget: const MyWidget(),
    goldenFileName: 'goldens/my_widget_large_text.png',
    config: SnapshotConfig.iPhone14.withLargeText(),
  );
});
```

## API

### `SnapshotConfig`

| Property / Method | Description |
|-------------------|-------------|
| `name` | Device name for identification |
| `size` | Device screen size |
| `devicePixelRatio` | Device pixel ratio (default: 1.0) |
| `textScaleFactor` | Text scale factor (default: 1.0) |
| `landscape()` | Returns a copy with width/height swapped |
| `withDarkMode()` | Returns a copy with name suffixed ' Dark' |
| `withLargeText()` | Returns a copy with 1.5x text scale |
| `iPhone14` | Preset: 390x844 @3x |
| `iPhone14ProMax` | Preset: 430x932 @3x |
| `pixel7` | Preset: 412x915 @2.75x |
| `pixel8` | Preset: 412x924 @2.75x |
| `galaxyS24` | Preset: 360x780 @3x |
| `iPhoneSE` | Preset: 375x667 @2x |
| `iPadPro12` | Preset: 1024x1366 @2x |
| `desktop` | Preset: 1440x900 @1x |
| `allDevices` | List of all preset configs |

### `SnapshotWrapper`

| Property | Description |
|----------|-------------|
| `child` | The widget to test |
| `config` | Device configuration to apply |
| `theme` | Optional ThemeData |
| `locale` | Optional Locale |

### `SnapshotTester`

| Method | Description |
|--------|-------------|
| `testWidget(tester, {widget, goldenFileName, config?, theme?, locale?})` | Test a widget against a single golden file |
| `testMultiDevice(tester, {widget, goldenFilePrefix, configs?, theme?})` | Test across multiple device configurations |
| `testThemes(tester, {widget, goldenFilePrefix, config?, lightTheme?, darkTheme?})` | Test with light and dark themes |
| `testOrientations(tester, {widget, goldenFilePrefix, config?, theme?})` | Test portrait and landscape orientations |
| `testStates(tester, {states, goldenFilePrefix, config?, theme?})` | Test multiple widget states |
| `testAccessibility(tester, {widget, goldenFilePrefix, config?, theme?})` | Test normal, large, and extra large text |

## Development

```bash
flutter pub get
flutter analyze
flutter test
```

To update golden files:

```bash
flutter test --update-goldens
```

## Support

If you find this project useful:

:star: [Star the repo](https://github.com/philiprehberger/flutter-snapshot-test)

:bug: [Report issues](https://github.com/philiprehberger/flutter-snapshot-test/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

:bulb: [Suggest features](https://github.com/philiprehberger/flutter-snapshot-test/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

:heart: [Sponsor development](https://github.com/sponsors/philiprehberger)

:globe_with_meridians: [All Open Source Projects](https://philiprehberger.com/open-source-packages)

:computer: [GitHub Profile](https://github.com/philiprehberger)

:link: [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
