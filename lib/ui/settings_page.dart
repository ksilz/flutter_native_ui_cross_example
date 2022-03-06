import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared/domain/s_enum_utils.dart';
import '../shared/domain/s_enums.dart';
import '../shared/service/s_device.dart';
import '../shared/ui/cross_content_area.dart';
import '../shared/ui/cross_form.dart';
import '../shared/ui/cross_switch.dart';
import '../shared/ui/cross_text.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nativePlatform = SDevice.instance.nativePlatform;

    return CrossContentArea(
      children: [
        CrossForm(
          children: [
            CrossText(
              label: 'You device runs ${SEnumUtils.instance.translatePlatform(nativePlatform)}',
            ),
            if (SDevice.instance.isNativeMobile())
              CrossSwitch(
                label:
                    'Switch to ${nativePlatform == SPlatform.ios ? SEnumUtils.instance.translatePlatform(SPlatform.android) : SEnumUtils.instance.translatePlatform(SPlatform.ios)} style',
                initialValue: nativePlatform != SDevice.instance.currentPlatform,
                onAction: (value) => _switchPlatform(value),
              ),
          ],
        ),
      ],
    );
  }

  _switchPlatform(bool? value) {
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
}
