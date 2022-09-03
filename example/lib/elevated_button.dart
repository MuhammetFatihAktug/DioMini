import 'package:flutter/material.dart';

class ElevatedButtonView extends StatelessWidget {
  const ElevatedButtonView({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
