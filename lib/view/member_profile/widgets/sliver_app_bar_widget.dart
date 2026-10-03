import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fr_philopater/view/member_profile/cubit/member_profile_cubit.dart';

import '../../../core/app_strings/app_strings.dart';
import '../../../core/styles/app_colors.dart';
import '../../../reuseable_widgets/custom_dialog.dart';
import '../../../reuseable_widgets/default_shimmer.dart';
import '../../view_image/view_image_screen.dart';
import '../member_profile_screen.dart';

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    required this.widget, required this.cubit,
  });

  final MemberProfileScreen widget;
  final MemberProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return  CustomDialog(
                      showYesOrNoButtons: true,
                      headLineText: AppStrings.delete,
                      title: AppStrings.deleteMemberDataMessage,
                      yesOnPressed: (){
                        cubit.deleteUserImage(id: widget.user!.documentId!,image: widget.user!.image!);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
      expandedHeight: 300.0,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24.0),
            bottomRight: Radius.circular(24.0),
          ),
          child: InkWell(
            onTap: () {
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImageScreen(images: [widget.user!.image], index: 0,),));
            },
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.user?.image ?? "",
              placeholder: (context, url) =>
              const DefaultShimmer(height: 300, width: double.infinity),
              errorWidget: (context, url, error) => const Center(
                  child: Icon(
                    Icons.error,
                    color: AppColors.primaryColor,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
