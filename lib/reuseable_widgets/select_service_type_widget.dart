import 'package:flutter/material.dart';
import 'package:fr_philopater/core/app_strings/app_strings.dart';
import 'package:fr_philopater/core/enums.dart';
import 'package:fr_philopater/generated/assets.dart';
import 'package:fr_philopater/reuseable_widgets/selectable_text_and_icon_item.dart';
import 'package:gap/gap.dart';

class SelectServiceTypeWidget extends StatelessWidget {
  const SelectServiceTypeWidget({
    super.key,
    required this.selectedService,
    required this.onPressed,
  });

  final ServiceType selectedService;
  final ValueChanged<ServiceType> onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SelectableTextAndIconItem(
            isSelected: selectedService == ServiceType.confessions,
            onPressed: () {
              onPressed(ServiceType.confessions);
            },
            text: AppStrings.confessions,
            assetsImage: Assets.imageIconsConfession,
          ),
        ),
        const Gap(10),
        Expanded(
          child: SelectableTextAndIconItem(
            isSelected: selectedService == ServiceType.addictive,
            onPressed: () {
              onPressed(ServiceType.addictive);
            },
            text: AppStrings.addictive,
            assetsImage: Assets.imageIconsAddictive,
          ),
        ),
      ],
    );
  }
}
