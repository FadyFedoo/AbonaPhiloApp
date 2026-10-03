import 'package:flutter/material.dart';

import '../core/app_strings/app_strings.dart';
import '../core/styles/icon_broken.dart';
import '../core/styles/text_styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.search,
                    style: MyTextStyles.textStyle14Medium,
                  ),
                ),
                const Icon(
                  IconBroken.Search,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
