import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;

  const TextWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,
      
            style: const TextStyle(
              overflow: TextOverflow.fade,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            )),
      ],
    );
  }
}
