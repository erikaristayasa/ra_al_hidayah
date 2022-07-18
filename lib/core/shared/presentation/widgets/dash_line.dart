import 'package:flutter/material.dart';

class DashLine extends StatelessWidget {
  const DashLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        150 ~/ 2,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey[200],
            height: 2,
          ),
        ),
      ),
    );
  }
}
