import 'package:flutter/material.dart';

class CrossHeading extends StatelessWidget {
  final String label;

  const CrossHeading({Key? key, required this.label})
      : assert(label.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline5?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
