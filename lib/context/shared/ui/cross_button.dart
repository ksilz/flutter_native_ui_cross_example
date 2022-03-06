import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_enums.dart';
import '../service/s_device.dart';

class CrossButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final void Function() onAction;

  const CrossButton({
    Key? key,
    required this.label,
    this.icon,
    required this.onAction,
  })  : assert(label.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    Widget feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        feedback = _buildMobileWidget();
        break;

      case SPlatform.mac:
        feedback = _buildMacWidget();
        break;

      case SPlatform.windows:
        feedback = _buildWindowsWidget();
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = _buildWebWidget();
        break;
    }

    return feedback;
  }

  Widget _buildMobileWidget() => PlatformElevatedButton(
        onPressed: onAction,
        child: PlatformText(label),
      );

  Widget _buildMacWidget() => PushButton(
        child: Text(label),
        onPressed: onAction,
        buttonSize: ButtonSize.large,
      );

  Widget _buildWindowsWidget() => Button(
        child: Text(label),
        onPressed: onAction,
      );

  Widget _buildWebWidget() => ElevatedButton(
        child: Text(label),
        onPressed: onAction,
      );
}
