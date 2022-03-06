import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_enums.dart';
import '../service/s_device.dart';

class CrossSwitch extends fluent.StatefulWidget {
  final String label;
  final bool initialValue;
  final void Function(bool?) onAction;

  const CrossSwitch({
    Key? key,
    required this.label,
    required this.onAction,
    required this.initialValue,
  })  : assert(label.length > 0),
        super(key: key);

  @override
  fluent.State<CrossSwitch> createState() => _CrossSwitchState();
}

class _CrossSwitchState extends fluent.State<CrossSwitch> {
  late bool selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    Widget feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        feedback = _buildMobileWidget(context);
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

  Widget _buildMobileWidget(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label),
          PlatformSwitch(
            onChanged: (value) => _updateValue(value),
            value: selectedValue,
          ),
        ],
      );

  Widget _buildMacWidget() => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: MacosCheckbox(
                onChanged: (value) => _updateValue(value),
                value: selectedValue,
              ),
            ),
            Text(widget.label),
          ],
        ),
      );

  Widget _buildWindowsWidget() => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: fluent.Checkbox(
                onChanged: (value) => _updateValue(value),
                checked: selectedValue,
              ),
            ),
                  Text(widget.label),
          ],
        ),
      );

  Widget _buildWebWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label),
          Switch(
            onChanged: (value) => _updateValue(value),
            value: selectedValue,
          ),
        ],
      );

  _updateValue(bool? newValue) {
    setState(() {
      selectedValue = newValue ?? false;
    });

    widget.onAction(newValue);
  }
}
