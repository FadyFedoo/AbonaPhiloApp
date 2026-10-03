import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fr_philopater/core/app_router/routes.dart';
import 'package:go_router/go_router.dart';

import '../core/constants.dart';
import '../core/styles/app_colors.dart';
import '../core/styles/text_styles.dart';
import '../models/user_model.dart';
import 'default_shimmer.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRouter.memberProfileScreen, extra: user);
      },
      child: Card(
        surfaceTintColor: Colors.white,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: user.image ?? "",
                  placeholder: (context, url) =>
                      const DefaultShimmer(height: 80, width: 80),
                  errorWidget: (context, url, error) => const Center(
                      child: Icon(
                    Icons.error,
                    color: AppColors.primaryColor,
                  )),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? "",
                      style: MyTextStyles.textStyle18Bold,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.phone ?? "",
                      style: MyTextStyles.textStyle16Medium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "${daysBetween(startDate: user.lastConfessionDate!,endDate: DateTime.now())} يوم",
                      style: MyTextStyles.textStyle16Medium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
