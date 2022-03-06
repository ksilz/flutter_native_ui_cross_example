import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_enums.dart';
import 's_device.dart';

class SDisplay {
  static final SDisplay instance = SDisplay._privateConstructor();
  static const Color _iosBackgroundGray = Color.fromARGB(255, 243, 243, 243);
  static const Color _niceBlue = Color(0xFF66A3FF);

  SDisplay._privateConstructor() {}

  Color get contentAreaBackgroundColor {
    final platform = SDevice.instance.currentPlatform;
    return platform == SPlatform.ios ? _iosBackgroundGray : Colors.white;
  }

  Color get primaryColor => _niceBlue;

  Color get changeColor => Colors.yellow.shade700;

  Color get cancelColor => Colors.grey;

  showAlertDialog({required BuildContext context, required String title, required String message}) {
    final platform = SDevice.instance.currentPlatform;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        _showMobileDialog(context, title, message);
        break;

      case SPlatform.mac:
        _showMacDialog(context, title, message);
        break;

      case SPlatform.windows:
        _showWindowsDialog(context, title, message);
        break;

      case SPlatform.linux:
      case SPlatform.web:
        _showWebDialog(context, title, message);
        break;
    }
  }

  _showMobileDialog(BuildContext context, String title, String message) => showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            PlatformDialogAction(
              child: PlatformText('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );

  _showMacDialog(BuildContext context, String title, String message) => showMacosAlertDialog(
        context: context,
        builder: (_) => MacosAlertDialog(
          appIcon: const FlutterLogo(
            size: 56,
          ),
          title: Text(
            title,
            style: MacosTheme.of(context).typography.headline,
          ),
          message: Text(
            message,
            textAlign: TextAlign.center,
            style: MacosTheme.of(context).typography.headline,
          ),
          primaryButton: PushButton(
            buttonSize: ButtonSize.large,
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      );

  _showWindowsDialog(BuildContext context, String title, String message) => showDialog(
        context: context,
        builder: (context) => fluent.ContentDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            fluent.Button(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );

  _showWebDialog(fluent.BuildContext context, String title, String message) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
}
