import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../context/shared/domain/s_enums.dart';
import '../context/shared/service/s_device.dart';
import '../context/shared/ui/cross_content_area.dart';
import '../context/shared/ui/cross_form.dart';
import '../context/shared/ui/cross_switch.dart';
import '../context/shared/ui/cross_text_field.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CrossContentArea(
        children: [
          CrossForm(
            children: [
              const CrossTextField(
                label: 'First name',
                hint: 'John',
              ),
              const CrossTextField(
                label: 'Last name',
                hint: 'Doe',
              ),
              CrossSwitch(
                label: 'VIP customer',
                initialValue: SDevice.instance.nativePlatform != SDevice.instance.currentPlatform,
                onAction: (value) => _switchPlatform(value),
              ),
            ],
          ),
        ],
      );

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
