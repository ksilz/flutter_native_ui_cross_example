import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_enums.dart';
import '../service/s_device.dart';
import '../service/s_display.dart';

class CrossButton extends StatelessWidget {
  final SButtonType type;
  final String label;
  final IconData? icon;
  final bool small;
  final void Function() onAction;

  const CrossButton({
    Key? key,
    this.type = SButtonType.navigation,
    required this.label,
    this.icon,
    this.small = false,
    required this.onAction,
  })  : assert(label.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    Color fillColor;
    Color textColor;

    switch (type) {
      case SButtonType.navigation:
        fillColor = SDisplay.instance.primaryColor;
        textColor = Colors.white;
        break;

      case SButtonType.cancel:
        fillColor = SDisplay.instance.cancelColor;
        textColor = Colors.black;
        break;

      case SButtonType.change:
        fillColor = SDisplay.instance.changeColor;
        textColor = Colors.black;
        break;
    }

    Widget feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        feedback = _buildMobileWidget(context, fillColor, textColor);
        break;

      case SPlatform.mac:
        feedback = _buildMacWidget(context, fillColor, textColor);
        break;

      case SPlatform.windows:
        feedback = _buildWindowsWidget(context, fillColor, textColor);
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = _buildWebWidget(context, fillColor, textColor);
        break;
    }

    return feedback;
  }

  Widget _buildMobileWidget(BuildContext context, Color fillColor, Color textColor) => PlatformElevatedButton(
        onPressed: onAction,
        child: PlatformText(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        color: fillColor,
        cupertino: (_, __) => CupertinoElevatedButtonData(
          padding: small ? const EdgeInsets.only(left: 16, right: 16) : null,
        ),
      );

  Widget _buildMacWidget(BuildContext context, Color fillColor, Color textColor) => PushButton(
        color: fillColor,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        onPressed: onAction,
        buttonSize: ButtonSize.large,
      );

  Widget _buildWindowsWidget(BuildContext context, Color fillColor, Color textColor) => fluent.FilledButton(
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onAction,
      );

  Widget _buildWebWidget(BuildContext context, Color fillColor, Color textColor) => ElevatedButton(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.button?.fontSize,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(fillColor),
        ),
        onPressed: onAction,
      );
}
