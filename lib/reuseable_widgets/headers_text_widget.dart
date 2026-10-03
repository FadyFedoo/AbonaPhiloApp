import 'package:flutter/material.dart';

import '../../../core/styles/text_styles.dart';

class HeaderTextWidget extends StatelessWidget {
  const HeaderTextWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyTextStyles.textStyle18Bold,
    );
  }
}
