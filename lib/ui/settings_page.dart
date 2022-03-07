import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_ui_cross_example/shared/ui/cross_drop_down.dart';

import '../shared/domain/s_choice.dart';
import '../shared/domain/s_enum_utils.dart';
import '../shared/domain/s_enums.dart';
import '../shared/service/s_device.dart';
import '../shared/ui/cross_content_area.dart';
import '../shared/ui/cross_switch.dart';
import '../shared/ui/cross_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nativePlatform = SDevice.instance.nativePlatform;
    final currentPlatform = SDevice.instance.currentPlatform;

    return CrossContentArea(
      children: [
        CrossText(
          label: 'You device runs ${SEnumUtils.instance.translatePlatform(nativePlatform)}',
        ),
        if (SDevice.instance.isNativeMobile())
          CrossSwitch(
            label:
                'Switch to ${nativePlatform == SPlatform.ios ? SEnumUtils.instance.translatePlatform(SPlatform.android) : SEnumUtils.instance.translatePlatform(SPlatform.ios)} style',
            initialValue: nativePlatform != currentPlatform,
            onAction: (value) => _switchMobilePlatform(value),
          ),
        if (SDevice.instance.isNativeMobile() == false)
          CrossDropDown(
              children: SPlatform.values
                  .map<SChoice>(
                    (aPlatform) => SChoice(
                      label: SEnumUtils.instance.translatePlatform(aPlatform),
                      action: () => _switchPlatform(aPlatform),
                    ),
                  )
                  .toList(),
              initialValue: SEnumUtils.instance.translatePlatform(currentPlatform))
      ],
    );
  }

  _switchMobilePlatform(bool? value) {
    final nativePlatform = SDevice.instance.nativePlatform;

    if (nativePlatform == SPlatform.ios || nativePlatform == SPlatform.android) {
      final realValue = value != null && value;

      if (nativePlatform == SPlatform.ios) {
        SDevice.instance.currentPlatform = realValue ? SPlatform.android : SPlatform.ios;
      } else {
        SDevice.instance.currentPlatform = realValue ? SPlatform.ios : SPlatform.android;
      }
    }
  }

  _switchPlatform(SPlatform value) {
    SDevice.instance.currentPlatform = value;
  }
}
