import 'package:flutter/material.dart';
import '../../core/styles/app_colors.dart';
import '../core/constants.dart';
import '../core/styles/text_styles.dart';

class DesignedFormField extends StatelessWidget {
  final bool allowMultiLines;
  final bool readOnly;
  final bool isPassword;
  final bool enabled;
  final bool disableFocus;
  final TextEditingController? controller;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final String? label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final dynamic onSubmit;
  final dynamic onChange;
  final dynamic onTap;
  final dynamic validator;
  final dynamic function;
  final Color? borderColor;
  final Color? cursorColor;
  final Color? prefixIconColor;
  final double? borderRadius;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final int? minLines;

  const DesignedFormField(
      {super.key,
      this.allowMultiLines = false,
      this.readOnly = false,
      this.isPassword = false,
      this.enabled = true,
      this.disableFocus = false,
      this.controller,
      this.type,
      this.label,
      this.prefixIcon,
      this.suffixIcon,
      this.onSubmit,
      this.onChange,
      this.onTap,
      this.validator,
      this.function,
      this.borderColor,
      this.borderRadius,
      this.hintText,
      this.hintStyle,
      this.errorStyle,
      this.labelStyle,
      this.style,
      this.textInputAction,
      this.cursorColor,
      this.prefixIconColor,
      this.minLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      onTapOutside: disableFocus
          ? (event) {}
          : (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      readOnly: readOnly,
      maxLines: allowMultiLines ? null : 1,
      style: style ?? MyTextStyles.textStyle18Medium,
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      onFieldSubmitted: onSubmit,
      textInputAction: textInputAction,
      onChanged: onChange,
      onTap: onTap,
      enabled: enabled,
      obscureText: isPassword,
      validator: validator,
      cursorColor: cursorColor ?? primaryColor,
      decoration: InputDecoration(
        // fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        hintText: hintText,
        hintStyle: hintStyle ??
            MyTextStyles.textStyle16Regular
                .copyWith(
              fontWeight: FontWeight.w400,
            )
                .copyWith(color: AppColors.greyTextColor),
        labelText: label,
        labelStyle: labelStyle ?? MyTextStyles.textStyle22Bold,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
          borderSide: BorderSide(
            color: borderColor ?? primaryColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
          borderSide: BorderSide(
            color: primaryColor,
            width: 0.8,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
          borderSide: BorderSide(
            color: borderColor ?? Colors.grey,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 2.0,
          ),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
          prefixIcon,
          color: prefixIconColor ?? AppColors.greyTextColor,
          size: 20,
        )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: suffixIcon!,
            onPressed: function,
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 40.0),
        ),
      ),
    );
  }
}
