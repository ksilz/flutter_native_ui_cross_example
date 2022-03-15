import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_choice.dart';
import '../domain/s_enums.dart';
import '../service/s_device.dart';
import 'cross_text.dart';

class CrossSelection extends StatefulWidget {
  final String label;
  final List<SChoice> children;
  final String initialValue;

  const CrossSelection({Key? key, required this.children, required this.initialValue, required this.label})
      : assert(children.length > 0),
        assert(initialValue.length > 0),
        assert(label.length > 0),
        super(key: key);

  @override
  State<CrossSelection> createState() => _CrossSelectionState();
}

class _CrossSelectionState extends State<CrossSelection> {
  late String? _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    Widget feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        feedback = SDevice.instance.isNativeMobile() ? Container() : Material(child: _buildWebWidget(context));
        break;

      case SPlatform.mac:
        feedback = _buildMacOsWidget(context);
        break;

      case SPlatform.windows:
        feedback = _buildWindowsWidget(context);
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = _buildWebWidget(context);
        break;
    }

    return feedback;
  }

  Widget _buildMacOsWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrossText(label: widget.label),
          ...widget.children
              .map<Widget>(
                (aChoice) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: MacosRadioButton<String>(
                          value: aChoice.label,
                          onChanged: (value) => _updateChoiceFromLabel(value, aChoice),
                          groupValue: _currentValue,
                        ),
                      ),
                      Text(aChoice.label),
                    ],
                  ),
                ),
              )
              .toList()
        ],
      );

  Widget _buildWindowsWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrossText(label: widget.label),
          ...List.generate(
            widget.children.length,
            (index) => Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: RadioButton(
                      content: Text(widget.children[index].label),
                      onChanged: (value) {
                        if (value) {
                          _updateChoiceFromLabel(widget.children[index].label, widget.children[index]);
                        }
                      },
                      checked: _currentValue == widget.children[index].label,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
        ],
      );

  Widget _buildWebWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrossText(label: widget.label),
          ...widget.children
              .map<Widget>(
                (aChoice) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Radio<String>(
                          value: aChoice.label,
                          onChanged: (value) => _updateChoiceFromLabel(value, aChoice),
                          groupValue: _currentValue,
                        ),
                      ),
                      Text(aChoice.label),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      );

  void _updateChoiceFromLabel(String? value, SChoice aChoice) {
    setState(() => _currentValue = value);
    if (_currentValue == aChoice.label) {
      aChoice.action();
    }
  }
}
