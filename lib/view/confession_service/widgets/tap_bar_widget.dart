import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/enums.dart';
import '../../../reuseable_widgets/selectable_text_and_icon_item.dart';
import '../cubit/confession_cubit.dart';

class TapBarWidget extends StatelessWidget {
  const TapBarWidget({
    super.key,
    required this.cubit,
  });

  final ConfessionCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SelectableTextAndIconItem(
            showSmallCircle: (cubit.users!=null&&cubit.users!.isNotEmpty),
            isSelected: cubit.selectedPeriod == Period.all,
            onPressed: () {
              cubit.selectedPeriod = Period.all;
              cubit.setState();
            },
            text: AppStrings.all,
            assetsImage: null,
          ),
        ),
        const Gap(10),
        Expanded(
          child: SelectableTextAndIconItem(
            showSmallCircle: (cubit.usersWithFortyDaysPeriod!=null&&cubit.usersWithFortyDaysPeriod!.isNotEmpty),
            isSelected: cubit.selectedPeriod == Period.fortyDays,
            onPressed: () {
              cubit.selectedPeriod = Period.fortyDays;
              cubit.setState();
            },
            text: AppStrings.fortyDays,
            assetsImage: null,
          ),
        ),
        const Gap(10),
        Expanded(
          child: SelectableTextAndIconItem(
            showSmallCircle: (cubit.usersWithSixtyDaysPeriod!=null&&cubit.usersWithSixtyDaysPeriod!.isNotEmpty),
            isSelected: cubit.selectedPeriod == Period.sixtyDays,
            onPressed: () {
              cubit.selectedPeriod = Period.sixtyDays;
              cubit.setState();
            },
            text: AppStrings.sixtyDays,
            assetsImage: null,
          ),
        ),
        const Gap(10),
        Expanded(
          child: SelectableTextAndIconItem(
            showSmallCircle: (cubit.usersWithHundredDaysPeriod!=null&&cubit.usersWithHundredDaysPeriod!.isNotEmpty),
            isSelected: cubit.selectedPeriod == Period.hundredDays,
            onPressed: () {
              cubit.selectedPeriod = Period.hundredDays;
              cubit.setState();
            },
            text: AppStrings.hundredDays,
            assetsImage: null,
          ),
        ),
      ],
    );
  }
}
