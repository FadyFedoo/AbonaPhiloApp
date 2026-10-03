import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/app_strings/app_strings.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/text_styles.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    this.headLineText,
    this.title,
    this.assetsImage,
    this.showDoneButton = false,
    this.showYesOrNoButtons = false, this.yesOnPressed, this.noOnPressed,
  });

  final String? headLineText;
  final String? title;
  final String? assetsImage;
  final bool showDoneButton;
  final bool showYesOrNoButtons;
  final void Function()? yesOnPressed;
  final void Function()? noOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Border radius of 20
          color: Colors.white, // White background color
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (assetsImage != null) Image.asset(assetsImage!),
            // Replace 'your_image.png' with your image path
            const SizedBox(height: 16),
            if (headLineText != null)
              Text(
                headLineText!,
                style: MyTextStyles.textStyle20Bold,
              ),
            const SizedBox(height: 8),
            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: MyTextStyles.textStyle16Medium.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
            if (showDoneButton) ...[
              const Gap(20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    border: Border.all(
                      color: AppColors.primaryColor,
                    )),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.done,
                    style: MyTextStyles.textStyle12Medium,
                  ),
                ),
              ),
            ],
            if (showYesOrNoButtons) ...[
              const Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(
                            color: AppColors.primaryColor,
                          )),
                      child: MaterialButton(
                        onPressed: yesOnPressed,
                        child: Text(
                          AppStrings.yes,
                          style: MyTextStyles.textStyle12Medium,
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          border: Border.all(
                            color: AppColors.primaryColor,
                          )),
                      child: MaterialButton(
                        onPressed:noOnPressed?? () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppStrings.no,
                          style: MyTextStyles.textStyle12Medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
