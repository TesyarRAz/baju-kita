import 'package:flutter/material.dart';

typedef ChildBuilder = Widget Function(Widget);

class ConditionalWidget extends StatelessWidget {
  final bool condition;
  final Widget child;
  final ChildBuilder builder;

  const ConditionalWidget({
    required this.condition,
    required this.builder,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? child : builder(child);
  }
}
