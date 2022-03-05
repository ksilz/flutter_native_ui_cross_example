import 'dart:io';

import 'package:flutter/foundation.dart';

import '../domain/s_enums.dart';

class SDeviceService {
  static final SDeviceService instance = SDeviceService._privateConstructor();
  late SPlatform _currentPlatform;

  SDeviceService._privateConstructor() {
    _currentPlatform = SPlatform.web;

    if (!kIsWeb) {
      if (Platform.isIOS) {
        _currentPlatform = SPlatform.ios;
      } else if (Platform.isAndroid) {
        _currentPlatform = SPlatform.android;
      } else if (Platform.isWindows) {
        _currentPlatform = SPlatform.windows;
      } else if (Platform.isLinux) {
        _currentPlatform = SPlatform.linux;
      } else if (Platform.isMacOS) {
        _currentPlatform = SPlatform.mac;
      }
    }
  }

  SPlatform get currentPlatform => _currentPlatform;
}
