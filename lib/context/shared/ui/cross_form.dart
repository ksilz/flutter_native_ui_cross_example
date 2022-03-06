import 'package:flutter/widgets.dart';

import '../domain/s_enums.dart';
import '../service/s_device.dart';
import '../service/s_display.dart';
import 'cross_button.dart';

class CrossForm extends StatelessWidget {
  final List<Widget> children;

  const CrossForm({Key? key, required this.children})
      : assert(children.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    final allWidgets = [...children];

    if (platform != SPlatform.android && platform != SPlatform.ios) {
      Widget buttons;

      switch (platform) {
        case SPlatform.android:
        case SPlatform.ios:
          // we shouldn't arrive here
          buttons = Container();
          break;

        case SPlatform.mac:
          buttons = _calculateMacFormButtons(context);
          break;

        case SPlatform.windows:
          buttons = _calculateWindowsFormButtons(context);
          break;

        case SPlatform.linux:
        case SPlatform.web:
          buttons = _calculateWebFormButtons(context);
          break;
      }

      allWidgets.add(buttons);
    }

    return Column(children: allWidgets);
  }

  Widget _calculateMacFormButtons(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32, right: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CrossButton(
                onAction: () => _onCancel(context),
                type: SButtonType.cancel,
                label: 'Cancel',
              ),
            ),
            CrossButton(
              onAction: () => _onSave(context),
              label: 'Save',
            )
          ],
        ),
      );

  Widget _calculateWebFormButtons(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CrossButton(
                onAction: () => _onCancel(context),
                type: SButtonType.cancel,
                label: 'Cancel',
              ),
            ),
            CrossButton(
              onAction: () => _onSave(context),
              label: 'Save',
            )
          ],
        ),
      );

  Widget _calculateWindowsFormButtons(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CrossButton(
                onAction: () => _onCancel(context),
                type: SButtonType.cancel,
                label: 'Cancel',
              ),
            ),
            CrossButton(
              onAction: () => _onSave(context),
              label: 'Save',
            )
          ],
        ),
      );

  void _onSave(BuildContext context) => SDisplay.instance.showAlertDialog(
      context: context,
      title: 'Save Simulation',
      message: 'This is where the '
          'form would be saved.');

  void _onCancel(BuildContext context) => SDisplay.instance.showAlertDialog(
      context: context,
      title: 'Cancel Simulation',
      message: 'This is where the '
          'form input would be canceled.');
}
