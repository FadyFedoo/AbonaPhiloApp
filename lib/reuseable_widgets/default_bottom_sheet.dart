import 'package:flutter/material.dart';
import 'package:fr_philopater/generated/assets.dart';

import '../core/styles/app_colors.dart';
import '../core/styles/text_styles.dart';
import 'default_image_icon.dart';

void showDefaultBottomSheet({
  required BuildContext context,
  double? radius,
  double? height=320,
  required String text,
  required bool showButton,
   bool isScrollControlled=false,
  String? buttonText,
  void Function()? buttonOnTap,
  Widget? child,
  Widget? child2,
  Widget? child3,
}) {
  showModalBottomSheet(
    isScrollControlled: isScrollControlled,
    context: context,
    enableDrag: true,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(radius ?? 45.0),
      ),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: CustomScrollView(
            slivers: [
              //header widget
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        style: MyTextStyles.textStyle16Bold
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: defaultImageIcon(
                            assetsData: Assets.imageIconsArrowDown)),
                  ],
                ),
              ),
              // scrollable child
              if (child != null)...[
                child,
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),

              ],
              if (child2 != null)...[
                child2,
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
              ] ,
              if (child3 != null)...[
                child3,
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
              ] ,
/*
              // button
              if (showButton)
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: buttonOnTap ??
                        () {
                          Navigator.of(context).pop();
                        },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          buttonText ?? "",
                          style: MyTextStyles.textStyle14Medium,
                        ),
                      ),
                    ),
                  ),
                ),*/
            ],
          ),
        ),
      ),
    ),
  );
}
