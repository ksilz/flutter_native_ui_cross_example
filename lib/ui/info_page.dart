import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../shared/service/s_device.dart';
import '../shared/ui/cross_button.dart';
import '../shared/ui/cross_content_area.dart';
import '../shared/ui/cross_heading.dart';
import '../shared/ui/cross_text.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CrossContentArea(
        children: [
          const CrossHeading(label: 'Welcome to This Flutter Native UI Example!'),
          const CrossText(
            label: 'This project belongs to a conference talk from JavaLand 2021 \'Flutter for Java Developers: Web, Mobile & Desktop Front-Ends from 1 Code Base?\'.',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CrossButton(
                label: 'View Talk Page',
                onAction: () => SDevice.instance.launchWebSite(context, 'https://bpf.li/hum'),
              ),
            ],
          ),
        ],
      );
}
