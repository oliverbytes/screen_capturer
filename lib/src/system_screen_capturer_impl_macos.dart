import 'dart:io';

import 'capture_mode.dart';
import 'system_screen_capturer.dart';

final Map<CaptureMode, List<String>> _knownCaptureModeArgs = {
  CaptureMode.region: ['-i', '-r'],
  CaptureMode.screen: ['-C'],
  CaptureMode.window: ['-i', '-w'],
  CaptureMode.windowNoShadow: ['-i', '-w', '-o'],
  CaptureMode.wallpaper: ['-i', '-w', '-o', '-S'],
};

class SystemScreenCapturerImplMacOS extends SystemScreenCapturer {
  SystemScreenCapturerImplMacOS();

  @override
  Future<void> capture({
    required String imagePath,
    CaptureMode mode = CaptureMode.region,
    bool silent = true,
  }) async {
    List<String> arguments = [
      ..._knownCaptureModeArgs[mode]!,
      silent ? '-x' : '',
      imagePath,
    ];

    arguments.removeWhere((e) => e.isEmpty);

    await Process.run(
      '/usr/sbin/screencapture',
      arguments,
    );
  }
}
