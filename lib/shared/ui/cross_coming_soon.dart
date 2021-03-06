import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cross_content_area.dart';
import 'cross_heading.dart';

class CrossComingSoon extends StatelessWidget {
  final String label;

  const CrossComingSoon({Key? key, required this.label})
      : assert(label.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) => CrossContentArea(
        children: [
          CrossHeading(
            label: 'Coming soon: $label'.toUpperCase(),
          ),
        ],
      );
}
