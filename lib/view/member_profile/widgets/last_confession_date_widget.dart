import 'package:flutter/material.dart';
import 'package:fr_philopater/view/member_profile/cubit/member_profile_cubit.dart';
import 'package:gap/gap.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/styles/text_styles.dart';
import '../../../reuseable_widgets/custom_dialog.dart';
import '../../../reuseable_widgets/default_divider.dart';
import '../../../reuseable_widgets/icon_with_text_widget.dart';

class LastConfessionDateWidget extends StatelessWidget {
  const LastConfessionDateWidget({
    super.key,
    required this.text, required this.userId, required this.cubit,
  });

  final String text;
  final String userId;
  final MemberProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.lastConfessionDate,
          style: MyTextStyles.textStyle22Bold,
        ),
        const Gap(5),
        Row(
          children: [
            Expanded(
              child: IconWithTextWidget(
                text: text,
                icon: Icons.calendar_month_outlined,
              ),
            ),
            const Gap(5),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return  CustomDialog(
                        showYesOrNoButtons: true,
                        headLineText: AppStrings.renewConfessionDate,
                        title: AppStrings.renewConfessionDateMessage,
                        yesOnPressed: (){
                          cubit.updateUserConfessionDate(id: userId, date: DateTime.now());
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.refresh,
                )),
          ],
        ),
        const Gap(10),
        const DefaultDivider(),
        const Gap(10),
      ],
    );
  }
}
