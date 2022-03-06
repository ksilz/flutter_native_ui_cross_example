import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/domain/s_enums.dart';
import '../domain/s_device_event.dart';
import 's_display.dart';

class SDevice {
  static final SDevice instance = SDevice._privateConstructor();
  late SPlatform _currentPlatform;
  late SPlatform _nativePlatform;
  bool _webSitesPossible = false;
  final _eventStreamController = StreamController<SDeviceEvent>();

  SDevice._privateConstructor() {
    _detectCapabilities();
  }

  _detectCapabilities() async {
    _nativePlatform = SPlatform.web;

    if (!kIsWeb) {
      if (Platform.isIOS) {
        _nativePlatform = SPlatform.ios;
      } else if (Platform.isAndroid) {
        _nativePlatform = SPlatform.android;
      } else if (Platform.isWindows) {
        _nativePlatform = SPlatform.windows;
      } else if (Platform.isLinux) {
        _nativePlatform = SPlatform.linux;
      } else if (Platform.isMacOS) {
        _nativePlatform = SPlatform.mac;
      }
    }

    _currentPlatform = _nativePlatform;
    _webSitesPossible = await canLaunch(Uri(scheme: 'https', path: 'google.com').toString());
  }

  bool get webSitesPossible => _webSitesPossible;

  SPlatform get nativePlatform => _nativePlatform;

  SPlatform get currentPlatform => _currentPlatform;

  set currentPlatform(SPlatform value) => _setCurrentPlatform(value);

  Stream<SDeviceEvent> get deviceEvents => _eventStreamController.stream;

  _setCurrentPlatform(SPlatform value) {
    _currentPlatform = value;
    _eventStreamController.add(SDeviceEvent());
  }

  launchWebSite(BuildContext context, String url) async {
    if (webSitesPossible) {
      final worked = await launch(url);

      if (worked == false) {
        SDisplay.instance.showAlertDialog(context: context, title: "Can't launch web site", message: "I couldn't show this web. Please open it manually: $url");
      }
    } else {
      SDisplay.instance.showAlertDialog(context: context, title: "Can't launch web site", message: "I can't show web sites on this device. Please open this manually:  $url");
    }
  }

  bool isNativeMobile() => _nativePlatform == SPlatform.ios || _nativePlatform == SPlatform.android;
}
