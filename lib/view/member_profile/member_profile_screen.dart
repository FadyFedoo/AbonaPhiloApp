import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fr_philopater/core/app_strings/app_strings.dart';
import 'package:fr_philopater/core/enums.dart';
import 'package:fr_philopater/core/styles/text_styles.dart';
import 'package:fr_philopater/generated/assets.dart';
import 'package:fr_philopater/models/user_model.dart';
import 'package:fr_philopater/reuseable_widgets/default_button.dart';
import 'package:fr_philopater/view/app_layout/cubit/app_cubit.dart';
import 'package:fr_philopater/view/member_profile/cubit/member_profile_cubit.dart';
import 'package:fr_philopater/view/member_profile/widgets/about_children_section.dart';
import 'package:fr_philopater/view/member_profile/widgets/last_confession_date_widget.dart';
import 'package:fr_philopater/view/member_profile/widgets/notes_section.dart';
import 'package:fr_philopater/view/member_profile/widgets/sliver_app_bar_widget.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_router/routes.dart';
import '../../core/constants.dart';
import '../../core/services/services_locator.dart';
import '../../core/shared_components.dart';
import '../../core/styles/app_colors.dart';
import '../../reuseable_widgets/default_divider.dart';
import '../../reuseable_widgets/icon_with_text_widget.dart';
import 'cubit/member_profile_state.dart';

class MemberProfileScreen extends StatefulWidget {
  const MemberProfileScreen({super.key, this.user});

  final UserModel? user;

  @override
  State<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<MemberProfileCubit>(),
        child: Builder(builder: (context) {
          var cubit = MemberProfileCubit.get(context);
          return BlocConsumer<MemberProfileCubit, MemberProfileState>(
            listener: (context, state) {
              if (state is DeleteUserErrorState) {
                showToast(text: state.message, state: ToastStates.ERROR);
              }
              if (state is DeleteUserSuccessState) {
                showToast(
                    text: AppStrings.deletedSuccessfully,
                    state: ToastStates.SUCCESS);
                GoRouter.of(context).go(AppRouter.refreshAppScreen);
              }
              if (state is UpdateUserConfessionDateErrorState) {
                showToast(text: state.message, state: ToastStates.ERROR);
              }
              if (state is UpdateUserConfessionDateSuccessState) {
                showToast(
                    text: AppStrings.updatedSuccessfully,
                    state: ToastStates.SUCCESS);
                widget.user?.lastConfessionDate = DateTime.now();
                cubit.setState();
              }
            },
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverAppBarWidget(
                    widget: widget,
                    cubit: cubit,
                  ),
                  const SliverGap(20),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (widget.user?.image != null) ...[
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.user!.name!,
                                    style: MyTextStyles.textStyle22Bold,
                                  ),
                                ),
                                Text(
                                  widget.user?.serviceType ==
                                          ServiceType.confessions.name
                                      ? AppStrings.confessions
                                      : AppStrings.addictive,
                                  style:
                                      MyTextStyles.textStyle14Regular.copyWith(
                                    color: AppColors.customBlue,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                          ],
                          if (widget.user?.address != null &&
                              widget.user!.address!.isNotEmpty) ...[
                            IconWithTextWidget(
                              text: widget.user!.address!,
                              icon: Icons.pin_drop_outlined,
                            ),
                            const Gap(10),
                          ],
                          if (widget.user?.phone != null &&
                              widget.user!.phone!.isNotEmpty) ...[
                            InkWell(
                              onTap: () {
                                AppCubit.get(context)
                                    .launchCall(widget.user!.phone!);
                              },
                              child: IconWithTextWidget(
                                text: widget.user!.phone!,
                                icon: Icons.phone_outlined,
                              ),
                            ),
                            const Gap(10),
                          ],
                          if (widget.user?.job != null &&
                              widget.user!.job!.isNotEmpty) ...[
                            IconWithTextWidget(
                              text: widget.user!.job!,
                              icon: Icons.work_outline,
                            ),
                            const Gap(10),
                          ],
                          if (widget.user?.birthdate != null) ...[
                            IconWithTextWidget(
                              text: dateFormat(
                                  date: widget.user!.birthdate!,
                                  context: context),
                              icon: Icons.cake_outlined,
                            ),
                            const Gap(10),
                          ],
                          if (widget.user?.maritalStatus != null &&
                              widget.user!.maritalStatus!.isNotEmpty) ...[
                            IconWithTextWidget(
                              text: widget.user!.maritalStatus!,
                              icon: FontAwesomeIcons.heart,
                            ),
                            const Gap(10),
                          ],
                          const DefaultDivider(),
                          const Gap(10),
                          if (widget.user?.lastConfessionDate != null) ...[
                            LastConfessionDateWidget(
                              cubit: cubit,
                              userId: widget.user!.documentId!,
                              text: dateFormat(
                                  date: widget.user!.lastConfessionDate!,
                                  context: context),
                            ),
                          ],
                          if (widget.user?.marriageDate != null) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.marriageDate,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(5),
                                IconWithTextWidget(
                                  text: dateFormat(
                                      date: widget.user!.marriageDate!,
                                      context: context),
                                  icon: Icons.calendar_month_outlined,
                                ),
                                const Gap(10),
                                const DefaultDivider(),
                                const Gap(10),
                              ],
                            ),
                          ],
                          if (widget.user?.wifeName != null &&
                              widget.user!.wifeName!.isNotEmpty) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.wifeName,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(5),
                                IconWithTextWidget(
                                  text: widget.user!.wifeName!,
                                  icon: Icons.person_outlined,
                                ),
                                const Gap(10),
                                const DefaultDivider(),
                                const Gap(10),
                              ],
                            ),
                          ],
                          if (widget.user?.aboutChildren != null &&
                              widget.user!.aboutChildren!.isNotEmpty) ...[
                            AboutChildrenSection(
                                text: widget.user!.aboutChildren!),
                          ],
                          if (widget.user?.notes != null &&
                              widget.user!.notes!.isNotEmpty) ...[
                            NotesSection(text: widget.user!.notes!),
                          ],
                          if (widget.user?.addictionType != null &&
                              widget.user!.addictionType!.isNotEmpty) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.addictionType,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(5),
                                IconWithTextWidget(
                                  text: widget.user!.addictionType!,
                                  imageIcon: Assets.imageIconsAddictive,
                                ),
                                const Gap(10),
                                const DefaultDivider(),
                                const Gap(10),
                              ],
                            ),
                          ],

                          if (widget.user?.materialType != null &&
                              widget.user!.materialType!.isNotEmpty) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.materialType,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(5),
                                IconWithTextWidget(
                                  text: widget.user!.materialType!,
                                  imageIcon: Assets.imageIconsAddictive,
                                ),
                                const Gap(10),
                                const DefaultDivider(),
                                const Gap(10),
                              ],
                            ),
                          ],
                          if (widget.user?.addictionStartDate != null) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.addictionStartDate,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(5),
                                IconWithTextWidget(
                                  text: dateFormat(
                                      date: widget.user!.addictionStartDate!,
                                      context: context),
                                  icon: Icons.calendar_month_outlined,
                                ),
                                const Gap(10),
                                const DefaultDivider(),
                                const Gap(10),
                              ],
                            ),
                          ],
                          if (widget.user?.previousSetbacks != null &&
                              widget.user!.previousSetbacks!.isNotEmpty) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.previousSetbacks,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(5),
                                IconWithTextWidget(
                                  text: widget.user!.previousSetbacks!,
                                  icon: Icons.trending_down_sharp,
                                ),
                                const Gap(10),
                                const DefaultDivider(),
                                const Gap(10),
                              ],
                            ),
                          ],
                          if (widget.user?.lastRecoveryDate != null) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.lastRecoveryDate,
                                  style: MyTextStyles.textStyle22Bold,
                                ),
                                const Gap(5),
                                IconWithTextWidget(
                                  text: dateFormat(
                                      date: widget.user!.lastRecoveryDate!,
                                      context: context),
                                  icon: Icons.calendar_month_outlined,
                                ),
                                const Gap(10),
                                const DefaultDivider(),
                                const Gap(10),
                              ],
                            ),
                          ],
                          DefaultButton(
                            text: AppStrings.edit,
                            onTap: () {
                              GoRouter.of(context).push(
                                  AppRouter.editMemberScreen,
                                  extra: widget.user);
                            },
                          ),
                          const Gap(10),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
