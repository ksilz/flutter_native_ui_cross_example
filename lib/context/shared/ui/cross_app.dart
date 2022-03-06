import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_enums.dart';
import '../service/s_device.dart';

class CrossApp extends StatelessWidget {
  final String title;
  final Widget home;

  const CrossApp({Key? key, required this.title, required this.home})
      : assert(title.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    var feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        feedback = PlatformApp(title: title, home: home);
        break;

      case SPlatform.windows:
        feedback = FluentApp(title: title, home: home);
        break;

      case SPlatform.mac:
        feedback = MacosApp(title: title, home: home);
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = MaterialApp(title: title, home: home);
        break;
    }

    return feedback;
  }
}
