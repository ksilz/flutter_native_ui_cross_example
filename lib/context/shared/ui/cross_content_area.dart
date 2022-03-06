import 'package:flutter/widgets.dart';

class CrossContentArea extends StatelessWidget {
  final List<Widget> children;

  const CrossContentArea({Key? key, required this.children})
      : assert(children.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
