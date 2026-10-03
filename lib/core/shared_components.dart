import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fr_philopater/core/styles/app_colors.dart';
import 'package:fr_philopater/core/styles/text_styles.dart';
import 'package:fr_philopater/core/values_manager.dart';


Widget defaultButton(
        {double? height,
        required color,
        required onPressed,
        text,
        textStyle}) =>
    Container(
      width: double.infinity,
      height: 40.h,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );

void showToast({
  String? text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { ERROR, SUCCESS, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget designedFormField({
  bool allowMultiLines = false,
  bool readOnly = false,
  // fontColor,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  bool textDirectionRight = false,
  String? label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  onSubmit,
  onChange,
  onTap,
  validator,
  function,
  Color? borderColor,
  required BuildContext context,
  double? borderRadius,
  String? hintText,
  TextStyle? hintStyle,
  TextStyle? errorStyle,
  TextStyle? labelStyle,
  TextStyle? style,
}) =>
    TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      readOnly: readOnly,
      maxLines: allowMultiLines ? null : 1,
      style: style ??
          TextStyle(
            color: Colors.black,
          ),
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      validator: validator,
      // textDirection: textDirectionRight ? TextDirection.rtl : TextDirection.ltr,
      // textAlign: textDirectionRight ? TextAlign.right : TextAlign.left,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        hintText: hintText,
        errorStyle: errorStyle ??
            TextStyle(
              fontSize: 12.sp,
              color: Colors.red,
            ),
        labelStyle: labelStyle ??
            TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
            ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          borderSide: BorderSide(
            color: borderColor != null
                ? borderColor
                : Theme.of(context).primaryColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          borderSide: BorderSide(
            color: borderColor != null
                ? borderColor
                : Theme.of(context).primaryColor,
            width: 1.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0.w,
          ),
        ),
        labelText: label,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.primaryColor,
                size: 20.sp,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(
                  suffixIcon,
                  color: Colors.black,
                  size: 20.sp,
                ),
                onPressed: function,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        ),
      ),
    );

Widget myDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Container(
      width: double.infinity,
      height: 1,
      color: AppColors.dividerColor,
    ),
  );
}

// Widget defaultCircularProgressIndicator() {
//   return Platform.isIOS
//       ? const CircularProgressIndicator.adaptive()
//       : Center(
//           child: const CircularProgressIndicator(
//             color: AppColors.primaryColor,
//           ),
//         );
// }

Widget SettingsDivider() {
  return Padding(
    padding: EdgeInsets.all(AppPadding.p8),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0), // Adjust the values as needed
          topRight: Radius.circular(5.0),
        ),
      ),
      child: const ClipOval(
        child: Divider(
          height: 1,
          thickness: 2,
          color: AppColors.whiteColor,
        ),
      ),
    ),
  );
}

Widget HeadlineText({required String text}) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p8,
      ),
      child: Text(
        text,
        style: MyTextStyles.textStyle16Medium,
      ),
    );
Widget MediumHeadlineText({required String text}) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p8,
      ),
      child: Text(
        text,
        style: MyTextStyles.textStyle18Bold,
      ),
    );

Widget LargeHeadlineText({required String text}) => Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p8,
        vertical: AppPadding.p8,
      ),
      child: Text(
        text,
        style: MyTextStyles.textStyle20Bold,
      ),
    );
