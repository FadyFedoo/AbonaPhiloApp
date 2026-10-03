import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/styles/text_styles.dart';
import '../../../reuseable_widgets/default_divider.dart';

class AboutChildrenSection extends StatelessWidget {
  const AboutChildrenSection({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutChildren,
          style: MyTextStyles.textStyle22Bold,
        ),
        const Gap(5),
        Text(
          text,
          style: MyTextStyles.textStyle18Medium,
        ),
        const Gap(10),
        const DefaultDivider(),
        const Gap(10),
      ],
    );
  }
}
