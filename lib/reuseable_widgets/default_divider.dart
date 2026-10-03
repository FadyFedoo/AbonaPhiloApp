import 'package:flutter/material.dart';

import '../core/styles/app_colors.dart';

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.greyTextColor,
      thickness: 0.5,
    );
  }
}
