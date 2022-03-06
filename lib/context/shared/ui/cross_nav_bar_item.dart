import 'package:flutter/widgets.dart';

import '../domain/s_enums.dart';

class CrossNavBarItem {
  final IconData icon;
  final String label;
  final Widget screen;
  final SLeadingAction? leading;
  final STrailingAction? trailing;

  const CrossNavBarItem({
    required this.icon,
    required this.label,
    required this.screen,
    this.leading,
    this.trailing,
  })  : assert(label.length > 0),
        super();
}
