```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../core/styles/app_colors.dart';
import '../core/styles/text_styles.dart';

class IconWithTextWidget extends StatelessWidget {
  const IconWithTextWidget({
    super.key,
    required this.text,
    this.svgIcon,
    this.imageIcon,
    this.icon,
    this.faIcon,
    this.color,
    this.height,
    this.width,
    this.style,
  });

  final String text;
  final String? svgIcon;
  final String? imageIcon;

  // Flutter Material/Cupertino icons
  final IconData? icon;

  // Font Awesome icons
  final FaIconData? faIcon;

  final Color? color;
  final double? height;
  final double? width;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (svgIcon != null)
          SvgPicture.asset(
            svgIcon!,
            color: color ?? AppColors.primaryColor,
            width: width,
            height: height,
          ),

        if (icon != null)
          Icon(
            icon,
            color: color ?? AppColors.primaryColor,
            size: height ?? width,
          ),

        if (faIcon != null)
          FaIcon(
            faIcon,
            color: color ?? AppColors.primaryColor,
            size: height ?? width,
          ),

        if (imageIcon != null)
          ImageIcon(
            AssetImage(imageIcon!),
            color: color ?? AppColors.primaryColor,
            size: height ?? width,
          ),

        const Gap(10),

        Flexible(
          child: Text(
            text,
            style: style ??
                MyTextStyles.textStyle14Medium.copyWith(
                  color: AppColors.greyTextColor,
                ),
          ),
        ),
      ],
    );
  }
}
```
