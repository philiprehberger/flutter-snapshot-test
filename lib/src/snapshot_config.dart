import 'package:flutter/widgets.dart';

/// Configuration for snapshot testing across devices and themes.
class SnapshotConfig {
  /// Device name for identification.
  final String name;

  /// Device screen size.
  final Size size;

  /// Device pixel ratio.
  final double devicePixelRatio;

  /// Optional text scale factor.
  final double textScaleFactor;

  const SnapshotConfig({
    required this.name,
    required this.size,
    this.devicePixelRatio = 1.0,
    this.textScaleFactor = 1.0,
  });

  /// Common device configurations.
  static const iPhone14 = SnapshotConfig(
    name: 'iPhone 14',
    size: Size(390, 844),
    devicePixelRatio: 3.0,
  );

  static const iPhone14ProMax = SnapshotConfig(
    name: 'iPhone 14 Pro Max',
    size: Size(430, 932),
    devicePixelRatio: 3.0,
  );

  static const pixel7 = SnapshotConfig(
    name: 'Pixel 7',
    size: Size(412, 915),
    devicePixelRatio: 2.75,
  );

  static const iPadPro12 = SnapshotConfig(
    name: 'iPad Pro 12.9"',
    size: Size(1024, 1366),
    devicePixelRatio: 2.0,
  );

  static const desktop = SnapshotConfig(
    name: 'Desktop',
    size: Size(1440, 900),
    devicePixelRatio: 1.0,
  );

  /// All preset device configs.
  static const List<SnapshotConfig> allDevices = [
    iPhone14,
    iPhone14ProMax,
    pixel7,
    iPadPro12,
    desktop,
  ];

  /// Accessibility variant with large text.
  SnapshotConfig withLargeText() => SnapshotConfig(
        name: '$name (large text)',
        size: size,
        devicePixelRatio: devicePixelRatio,
        textScaleFactor: 1.5,
      );
}
