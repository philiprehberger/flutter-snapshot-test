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

    test('allDevices contains 5 configs', () {
      expect(SnapshotConfig.allDevices.length, equals(5));
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
