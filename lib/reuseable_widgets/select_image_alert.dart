import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/text_styles.dart';

void selectImageAlert({
  required BuildContext context,
  required cubit,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title:  Text('اختر صورة',
            style: MyTextStyles.textStyle16Bold,

          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.height / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                    //Navigator.pop(context);
                    cubit.getImage(ImageSource.gallery);
                  },
                  child: Container(
                    color: Colors.grey[300],
                    width: 120,
                    height: 120,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image,
                          //color: AppColors.customYellow,
                          size: 30,
                        ),
                        Text(
                          'الاستوديو',
                          style: MyTextStyles.textStyle16Bold,

                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                    //Navigator.pop(context);
                    cubit.getImage(ImageSource.camera);
                  },
                  child: Container(
                    color: AppColors.backgroundColor,
                    width: 120,
                    height: 120,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                        Text(
                            'الكاميرا',
                          style: MyTextStyles.textStyle16Bold,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
