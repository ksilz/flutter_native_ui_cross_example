import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CrossComingSoon extends StatelessWidget {
  final String label;

  const CrossComingSoon({Key? key, required this.label})
      : assert(label.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Coming soon: $label'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline3?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
