import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_enums.dart';
import '../service/s_device.dart';

class CrossTextField extends StatelessWidget {
  final String label;
  final String hint;

  const CrossTextField({
    Key? key,
    required this.label,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    Widget feedback;

    switch (platform) {
      case SPlatform.android:
        feedback = _buildAndroidWidget();
        break;

      case SPlatform.ios:
        feedback = _buildIosWidget();
        break;

      case SPlatform.mac:
        feedback = _buildMacOsWidget(context);
        break;

      case SPlatform.windows:
        feedback = _buildWindowsWidget();
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = _buildWebWidget(context);
        break;
    }

    return feedback;
  }

  Widget _buildAndroidWidget() => TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
        ),
        keyboardType: TextInputType.text,
      );

  Widget _buildIosWidget() => PlatformTextField(
        hintText: label,
        keyboardType: TextInputType.text,
      );

  Widget _buildMacOsWidget(BuildContext context) => MacosTextField(
        keyboardType: TextInputType.text,
        placeholder: label,
      );

  Widget _buildWindowsWidget() => InfoLabel(
        label: label,
        child: TextBox(
          placeholder: hint,
          keyboardType: TextInputType.text,
        ),
      );

  Widget _buildWebWidget(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
        ),
        keyboardType: TextInputType.text,
      );
}
