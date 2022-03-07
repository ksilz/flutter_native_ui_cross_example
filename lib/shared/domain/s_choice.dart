class SChoice {
  final String label;
  final void Function() action;

  const SChoice({required this.label, required this.action})
      : assert(label.length > 0),
        super();
}
