import 'package:flutter/material.dart';

import '../core/styles/app_colors.dart';
import '../core/styles/text_styles.dart';

class UnitItemDataRow extends StatelessWidget {
  const UnitItemDataRow({super.key, required this.text, required this.icon, this.textColor});

  final String text;
  final Color? textColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) icon!,
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            style: MyTextStyles.textStyle18Medium.copyWith(
              color: textColor??AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
