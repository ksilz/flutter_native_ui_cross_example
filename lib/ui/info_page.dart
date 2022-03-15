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
            label: 'This project belongs to the "Getting Started With Flutter" guide from the "Better Projects Faster" site.',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CrossButton(
                label: 'View Talk Page',
                onAction: () => SDevice.instance.launchWebSite(context, 'https://betterprojectsfaster.com/guide/getting-started-flutter/#sample-application-native-look--feel-with-flutter'),
              ),
            ],
          ),
        ],
      );
}
