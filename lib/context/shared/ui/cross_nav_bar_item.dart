import 'package:flutter/widgets.dart';

class CrossNavBarItem {
  final IconData icon;
  final String label;
  final Widget screen;

  const CrossNavBarItem({required this.icon, required this.label, required this.screen})
      : assert(label.length > 0),
        super();
}
