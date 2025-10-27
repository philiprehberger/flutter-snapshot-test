import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:philiprehberger_snapshot_test/snapshot_test.dart';

void main() {
  group('SnapshotConfig', () {
    test('iPhone14 has correct dimensions', () {
      expect(SnapshotConfig.iPhone14.size, equals(const Size(390, 844)));
      expect(SnapshotConfig.iPhone14.devicePixelRatio, equals(3.0));
    });

    test('desktop has correct dimensions', () {
      expect(SnapshotConfig.desktop.size, equals(const Size(1440, 900)));
      expect(SnapshotConfig.desktop.devicePixelRatio, equals(1.0));
    });

    test('allDevices contains 8 configs', () {
      expect(SnapshotConfig.allDevices.length, equals(8));
    });

    test('pixel8 has correct dimensions', () {
      expect(SnapshotConfig.pixel8.size, equals(const Size(412, 924)));
      expect(SnapshotConfig.pixel8.devicePixelRatio, equals(2.75));
    });

    test('galaxyS24 has correct dimensions', () {
      expect(SnapshotConfig.galaxyS24.size, equals(const Size(360, 780)));
      expect(SnapshotConfig.galaxyS24.devicePixelRatio, equals(3.0));
    });

    test('iPhoneSE has correct dimensions', () {
      expect(SnapshotConfig.iPhoneSE.size, equals(const Size(375, 667)));
      expect(SnapshotConfig.iPhoneSE.devicePixelRatio, equals(2.0));
    });

    test('allDevices contains new presets', () {
      expect(SnapshotConfig.allDevices, contains(SnapshotConfig.pixel8));
      expect(SnapshotConfig.allDevices, contains(SnapshotConfig.galaxyS24));
      expect(SnapshotConfig.allDevices, contains(SnapshotConfig.iPhoneSE));
    });

    test('landscape swaps dimensions', () {
      final landscape = SnapshotConfig.iPhone14.landscape();
      expect(landscape.size.width, equals(844));
      expect(landscape.size.height, equals(390));
      expect(landscape.name, equals('iPhone 14 Landscape'));
      expect(landscape.devicePixelRatio, equals(3.0));
    });

    test('withDarkMode adds suffix', () {
      final dark = SnapshotConfig.iPhone14.withDarkMode();
      expect(dark.name, equals('iPhone 14 Dark'));
      expect(dark.size, equals(SnapshotConfig.iPhone14.size));
      expect(dark.devicePixelRatio, equals(3.0));
    });

    test('withLargeText creates accessibility variant', () {
      final large = SnapshotConfig.iPhone14.withLargeText();
      expect(large.textScaleFactor, equals(1.5));
      expect(large.name, contains('large text'));
      expect(large.size, equals(SnapshotConfig.iPhone14.size));
    });

    test('custom config creation', () {
      const config = SnapshotConfig(
        name: 'Custom',
        size: Size(800, 600),
        devicePixelRatio: 2.0,
        textScaleFactor: 1.2,
      );
      expect(config.name, equals('Custom'));
      expect(config.size.width, equals(800));
      expect(config.textScaleFactor, equals(1.2));
    });
  });

  group('SnapshotWrapper', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        SnapshotWrapper(
          config: SnapshotConfig.iPhone14,
          child: const Text('Hello'),
        ),
      );
      expect(find.text('Hello'), findsOneWidget);
    });

    testWidgets('applies theme', (tester) async {
      await tester.pumpWidget(
        SnapshotWrapper(
          config: SnapshotConfig.iPhone14,
          theme: ThemeData.dark(),
          child: const Text('Dark'),
        ),
      );
      expect(find.text('Dark'), findsOneWidget);
    });
  });
}
