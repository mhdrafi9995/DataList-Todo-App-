import 'package:bloc_sample/widget/text.dart';
import 'package:flutter/material.dart';

class BoxDataWidget extends StatelessWidget {
  const BoxDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'NAME',
          ),
          TextWidget(
            text: 'Type',
          ),
          TextWidget(
            text: 'Priority',
          ),
        ]);
  }
}
