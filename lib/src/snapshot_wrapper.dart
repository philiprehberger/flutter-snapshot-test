import 'package:flutter/material.dart';

import 'snapshot_config.dart';

/// Wraps a widget in a configured test harness for snapshot testing.
class SnapshotWrapper extends StatelessWidget {
  /// The widget to test.
  final Widget child;

  /// The device configuration.
  final SnapshotConfig config;

  /// Optional theme to apply.
  final ThemeData? theme;

  /// Optional locale.
  final Locale? locale;

  const SnapshotWrapper({
    super.key,
    required this.child,
    required this.config,
    this.theme,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(
        size: config.size,
        devicePixelRatio: config.devicePixelRatio,
        textScaler: TextScaler.linear(config.textScaleFactor),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme ?? ThemeData.light(),
        locale: locale,
        home: SizedBox(
          width: config.size.width,
          height: config.size.height,
          child: child,
        ),
      ),
    );
  }
}
