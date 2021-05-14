import 'package:flutter/material.dart';

class TableHeaderOpacity extends StatelessWidget {
  const TableHeaderOpacity({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: child,
    );
  }
}
