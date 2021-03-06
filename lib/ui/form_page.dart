import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared/ui/cross_content_area.dart';
import '../shared/ui/cross_form.dart';
import '../shared/ui/cross_switch.dart';
import '../shared/ui/cross_text_field.dart';

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
                initialValue: false,
                onAction: (_) => {},
              ),
            ],
          ),
        ],
      );
}
