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
}
