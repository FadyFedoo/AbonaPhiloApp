import 'package:flutter/material.dart';

import '../../core/styles/app_colors.dart';

class LoginIconButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget icon;
  final double? borderRadius;
  final TextStyle? textStyle;
  final void Function()? onTap;
  const LoginIconButton({
    super.key, this.height, this.width, this.borderRadius, this.textStyle, this.onTap, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 55,
        width: width ?? double.infinity,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius??6),
          color: AppColors.loginButtonsColor,
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
