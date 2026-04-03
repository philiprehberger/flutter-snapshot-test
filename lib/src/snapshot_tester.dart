import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'snapshot_config.dart';
import 'snapshot_wrapper.dart';

/// Utilities for visual snapshot testing of Flutter widgets.
class SnapshotTester {
  SnapshotTester._();

  /// Test a widget against a golden file with a specific device config.
  static Future<void> testWidget(
    WidgetTester tester, {
    required Widget widget,
    required String goldenFileName,
    SnapshotConfig config = SnapshotConfig.iPhone14,
    ThemeData? theme,
    Locale? locale,
  }) async {
    await tester.binding.setSurfaceSize(config.size);

    await tester.pumpWidget(
      SnapshotWrapper(
        config: config,
        theme: theme,
        locale: locale,
        child: widget,
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(SnapshotWrapper),
      matchesGoldenFile(goldenFileName),
    );
  }

  /// Test a widget across multiple device configurations.
  static Future<void> testMultiDevice(
    WidgetTester tester, {
    required Widget widget,
    required String goldenFilePrefix,
    List<SnapshotConfig>? configs,
    ThemeData? theme,
  }) async {
    final devices = configs ?? SnapshotConfig.allDevices;
    for (final config in devices) {
      final safeName =
          config.name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
      await testWidget(
        tester,
        widget: widget,
        goldenFileName: '${goldenFilePrefix}_$safeName.png',
        config: config,
        theme: theme,
      );
    }
  }

  /// Test a widget with both light and dark themes.
  static Future<void> testThemes(
    WidgetTester tester, {
    required Widget widget,
    required String goldenFilePrefix,
    SnapshotConfig config = SnapshotConfig.iPhone14,
    ThemeData? lightTheme,
    ThemeData? darkTheme,
  }) async {
    await testWidget(
      tester,
      widget: widget,
      goldenFileName: '${goldenFilePrefix}_light.png',
      config: config,
      theme: lightTheme ?? ThemeData.light(),
    );

    await testWidget(
      tester,
      widget: widget,
      goldenFileName: '${goldenFilePrefix}_dark.png',
      config: config,
      theme: darkTheme ?? ThemeData.dark(),
    );
  }

  /// Test a widget in both portrait and landscape orientations.
  static Future<void> testOrientations(
    WidgetTester tester, {
    required Widget widget,
    required String goldenFilePrefix,
    SnapshotConfig? config,
    ThemeData? theme,
  }) async {
    final portrait = config ?? SnapshotConfig.iPhone14;
    final landscape = portrait.landscape();

    await testWidget(
      tester,
      widget: widget,
      goldenFileName: '${goldenFilePrefix}_portrait.png',
      config: portrait,
      theme: theme,
    );

    await testWidget(
      tester,
      widget: widget,
      goldenFileName: '${goldenFilePrefix}_landscape.png',
      config: landscape,
      theme: theme,
    );
  }

  /// Test multiple widget states against golden files.
  static Future<void> testStates(
    WidgetTester tester, {
    required Map<String, Widget> states,
    required String goldenFilePrefix,
    SnapshotConfig? config,
    ThemeData? theme,
  }) async {
    final deviceConfig = config ?? SnapshotConfig.iPhone14;
    for (final entry in states.entries) {
      final safeName =
          entry.key.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
      await testWidget(
        tester,
        widget: entry.value,
        goldenFileName: '${goldenFilePrefix}_$safeName.png',
        config: deviceConfig,
        theme: theme,
      );
    }
  }

  /// Test a widget at different text scale factors for accessibility.
  static Future<void> testAccessibility(
    WidgetTester tester, {
    required Widget widget,
    required String goldenFilePrefix,
    SnapshotConfig? config,
    ThemeData? theme,
  }) async {
    final baseConfig = config ?? SnapshotConfig.iPhone14;

    await testWidget(
      tester,
      widget: widget,
      goldenFileName: '${goldenFilePrefix}_normal.png',
      config: baseConfig,
      theme: theme,
    );

    final largeText = SnapshotConfig(
      name: '${baseConfig.name} (large text)',
      size: baseConfig.size,
      devicePixelRatio: baseConfig.devicePixelRatio,
      textScaleFactor: 1.5,
    );
    await testWidget(
      tester,
      widget: widget,
      goldenFileName: '${goldenFilePrefix}_large_text.png',
      config: largeText,
      theme: theme,
    );

    final extraLargeText = SnapshotConfig(
      name: '${baseConfig.name} (extra large text)',
      size: baseConfig.size,
      devicePixelRatio: baseConfig.devicePixelRatio,
      textScaleFactor: 2.0,
    );
    await testWidget(
      tester,
      widget: widget,
      goldenFileName: '${goldenFilePrefix}_extra_large_text.png',
      config: extraLargeText,
      theme: theme,
    );
  }
}
