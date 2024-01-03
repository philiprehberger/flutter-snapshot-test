# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-04-01

### Added
- Initial release
- `SnapshotConfig` with preset device configurations (iPhone 14, iPhone 14 Pro Max, Pixel 7, iPad Pro 12.9", Desktop)
- `SnapshotWrapper` widget for wrapping test subjects with device and theme configuration
- `SnapshotTester.testWidget()` for single-device golden file testing
- `SnapshotTester.testMultiDevice()` for testing across multiple device configurations
- `SnapshotTester.testThemes()` for light/dark theme comparison testing
- `withLargeText()` accessibility variant for snapshot configs
