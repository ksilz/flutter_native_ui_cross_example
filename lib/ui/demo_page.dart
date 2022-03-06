import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../context/shared/ui/cross_content_area.dart';
import '../context/shared/ui/cross_text_field.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CrossContentArea(
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
      );
}
