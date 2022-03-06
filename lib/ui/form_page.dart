import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../context/shared/ui/cross_content_area.dart';
import '../context/shared/ui/cross_form.dart';
import '../context/shared/ui/cross_text_field.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CrossContentArea(
        children: [
          CrossForm(
            children: const [
              CrossTextField(
                label: 'First name',
                hint: 'John',
              ),
              CrossTextField(
                label: 'Last name',
                hint: 'Doe',
              ),
            ],
          ),
        ],
      );
}
