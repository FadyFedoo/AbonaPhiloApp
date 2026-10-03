import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/styles/app_colors.dart';
import '../core/styles/text_styles.dart';

class SelectableTextAndIconItem extends StatelessWidget {
  const SelectableTextAndIconItem({
    super.key,
    required this.onPressed,
    required this.isSelected,
    required this.text,
    required this.assetsImage,
    this.showSmallCircle = false,
  });

  final void Function()? onPressed;
  final bool isSelected;
  final bool showSmallCircle;
  final String? text;
  final String? assetsImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.unselectedItemColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (assetsImage != null) ...[
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Image.asset(assetsImage!,
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor),
                        ),
                        const Gap(10),
                      ],
                      if (text != null) ...[
                        Text(
                          text!,
                          style: MyTextStyles.textStyle14Bold.copyWith(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor),
                        )
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (showSmallCircle)
            const CircleAvatar(
              radius: 5,
              backgroundColor: AppColors.primaryColor,
            ),
        ],
      ),
    );
  }
}
