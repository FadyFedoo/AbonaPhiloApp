import 'dart:io';

import 'package:flutter/material.dart';

import '../core/styles/app_colors.dart';

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({super.key,  this.size});
  final double? size ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height:size?? 30,
        width:size?? 30,
        child: FittedBox(
          child: Platform.isIOS
              ? const CircularProgressIndicator.adaptive(
                  backgroundColor: AppColors.primaryColor,
                )
              : const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
        ),
      ),
    );
  }
}
