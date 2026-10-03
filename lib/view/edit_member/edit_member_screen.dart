import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/core/app_router/routes.dart';
import 'package:fr_philopater/core/app_strings/app_strings.dart';
import 'package:fr_philopater/core/constants.dart';
import 'package:fr_philopater/core/enums.dart';
import 'package:fr_philopater/core/shared_components.dart';
import 'package:fr_philopater/core/styles/text_styles.dart';
import 'package:fr_philopater/reuseable_widgets/default_radio_button.dart';
import 'package:fr_philopater/reuseable_widgets/designed_form_field.dart';
import 'package:fr_philopater/reuseable_widgets/headers_text_widget.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/services/services_locator.dart';
import '../../core/styles/app_colors.dart';
import '../../models/user_model.dart';
import '../../reuseable_widgets/default_button.dart';
import '../../reuseable_widgets/select_image_alert.dart';
import '../../reuseable_widgets/select_service_type_widget.dart';
import 'cubit/edit_member_cubit.dart';
import 'cubit/edit_member_state.dart';

class EditMemberScreen extends StatelessWidget {
  const EditMemberScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    DateTime? nowDateTime = DateTime.now();

    var cubit = sl<EditMemberCubit>()..resetData(user: user);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          AppStrings.addNewMember,
          style: MyTextStyles.textStyle18Bold,
        ),
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocConsumer<EditMemberCubit, EditMemberState>(
          listener: (context, state) {
            if (state is UploadImageToFirebaseFailureState) {
              showToast(state: ToastStates.ERROR, text: state.message);
            }
            if (state is EditMemberFailureState) {
              showToast(state: ToastStates.ERROR, text: state.message);
            }
            if (state is UploadImageToFirebaseSuccessState) {
              cubit.editMember(imageUrl: state.imageUrl,oldImage: user.image!,docId: user.documentId!);
            }
            if (state is EditMemberSuccessState) {
              showToast(
                  state: ToastStates.SUCCESS,
                  text: AppStrings.editMemberSuccessfully);
              GoRouter.of(context).go(AppRouter.refreshAppScreen);
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(appPadding),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserImageSection(
                            cubit: cubit,
                            image: user.image!,
                          ),
                          const Gap(10),
                          const HeaderTextWidget(text: AppStrings.serviceType),
                          const Gap(10),
                          SelectServiceTypeWidget(
                            onPressed: (service) {
                              cubit.selectedService = service;
                              cubit.setState();
                            },
                            selectedService: cubit.selectedService,
                          ),
                          const Gap(10),
                          const HeaderTextWidget(text: AppStrings.name),
                          const Gap(10),
                          DesignedFormField(
                            controller: cubit.nameController,
                            type: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.thisFieldIsRequired;
                              }
                            },
                          ),
                          const Gap(10),
                          const HeaderTextWidget(text: AppStrings.phone),
                          const Gap(10),
                          DesignedFormField(
                            controller: cubit.phoneController,
                            type: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.thisFieldIsRequired;
                              }
                            },
                          ),
                          const Gap(10),
                          const HeaderTextWidget(text: AppStrings.job),
                          const Gap(10),
                          DesignedFormField(
                            controller: cubit.jobController,
                            type: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return AppStrings.thisFieldIsRequired;
                              // }
                            },
                          ),
                          const Gap(10),
                          const HeaderTextWidget(text: AppStrings.address),
                          const Gap(10),
                          DesignedFormField(
                            controller: cubit.addressController,
                            type: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return AppStrings.thisFieldIsRequired;
                              // }
                            },
                          ),
                          const Gap(10),
                          const HeaderTextWidget(text: AppStrings.birthdayDate),
                          const Gap(10),
                          DesignedFormField(
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              color: AppColors.primaryColor,
                            ),
                            controller: cubit.birthdayDateController,
                            type: TextInputType.text,
                            readOnly: true,
                            onTap: () {
                              showIOSDatePicker(
                                  nowDateTime: nowDateTime,
                                  ctx: context,
                                  onConfirm: (val) {
                                    cubit.birthdayDate = val;
                                    cubit.birthdayDateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(cubit.birthdayDate!)
                                            .toString();
                                    cubit.setState();
                                  });
                            },
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.thisFieldIsRequired;
                              }
                            },
                          ),
                          const Gap(10),
                          const HeaderTextWidget(
                              text: AppStrings.lastConfessionDate),
                          const Gap(10),
                          DesignedFormField(
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              color: AppColors.primaryColor,
                            ),
                            controller: cubit.lastConfessionDateController,
                            type: TextInputType.text,
                            readOnly: true,
                            onTap: () {
                              showIOSDatePicker(
                                  nowDateTime: nowDateTime,
                                  ctx: context,
                                  onConfirm: (val) {
                                    cubit.lastConfessionDate = val;
                                    cubit.lastConfessionDateController.text =
                                        DateFormat('yyyy-MM-dd')
                                            .format(cubit.lastConfessionDate!)
                                            .toString();
                                    cubit.setState();
                                  });
                            },
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.thisFieldIsRequired;
                              }
                            },
                          ),
                          const Gap(10),
                          // addictive section
                          if (cubit.selectedService ==
                              ServiceType.addictive) ...[
                            const HeaderTextWidget(
                                text: AppStrings.addictionType),
                            const Gap(10),
                            DesignedFormField(
                              controller: cubit.addictionTypeController,
                              type: TextInputType.text,
                              allowMultiLines: true,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                            const HeaderTextWidget(
                                text: AppStrings.materialType),
                            const Gap(10),
                            DesignedFormField(
                              controller: cubit.materialTypeController,
                              type: TextInputType.text,
                              allowMultiLines: true,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                            const HeaderTextWidget(
                                text: AppStrings.previousSetbacks),
                            const Gap(10),
                            DesignedFormField(
                              controller: cubit.previousSetbacksController,
                              type: TextInputType.text,
                              allowMultiLines: true,
                              minLines: 3,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                            const HeaderTextWidget(
                                text: AppStrings.addictionStartDate),
                            const Gap(10),
                            DesignedFormField(
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primaryColor,
                              ),
                              controller: cubit.addictionStartDateController,
                              type: TextInputType.text,
                              readOnly: true,
                              onTap: () {
                                showIOSDatePicker(
                                    nowDateTime: nowDateTime,
                                    ctx: context,
                                    onConfirm: (val) {
                                      cubit.addictionStartDate = val;
                                      cubit.addictionStartDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(cubit.addictionStartDate!)
                                              .toString();
                                      cubit.setState();
                                    });
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                            const HeaderTextWidget(
                                text: AppStrings.lastRecoveryDate),
                            const Gap(10),
                            DesignedFormField(
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primaryColor,
                              ),
                              controller: cubit.lastRecoveryDateController,
                              type: TextInputType.text,
                              readOnly: true,
                              onTap: () {
                                showIOSDatePicker(
                                    nowDateTime: nowDateTime,
                                    ctx: context,
                                    onConfirm: (val) {
                                      cubit.lastRecoveryDate = val;
                                      cubit.lastRecoveryDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(cubit.lastRecoveryDate!)
                                              .toString();
                                      cubit.setState();
                                    });
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                          ],
                          const HeaderTextWidget(
                              text: AppStrings.maritalStatus),
                          const Gap(10),
                          MaritalStatusSection(cubit: cubit),
                          if (cubit.maritalStatus == AppStrings.married) ...[
                            const HeaderTextWidget(
                                text: AppStrings.marriageDate),
                            const Gap(10),
                            DesignedFormField(
                              suffixIcon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.primaryColor,
                              ),
                              controller: cubit.marriageDateController,
                              type: TextInputType.text,
                              readOnly: true,
                              onTap: () {
                                showIOSDatePicker(
                                    nowDateTime: nowDateTime,
                                    ctx: context,
                                    onConfirm: (val) {
                                      cubit.marriageDate = val;
                                      cubit.marriageDateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(cubit.marriageDate!)
                                              .toString();
                                      cubit.setState();
                                    });
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                            const HeaderTextWidget(text: AppStrings.wifeName),
                            const Gap(10),
                            DesignedFormField(
                              controller: cubit.wifeNameController,
                              type: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                            const HeaderTextWidget(
                                text: AppStrings.aboutChildren),
                            const Gap(10),
                            DesignedFormField(
                              controller: cubit.aboutChildrenController,
                              type: TextInputType.text,
                              allowMultiLines: true,
                              minLines: 3,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                // if (value.isEmpty) {
                                //   return AppStrings.thisFieldIsRequired;
                                // }
                              },
                            ),
                            const Gap(10),
                          ],
                          const HeaderTextWidget(text: AppStrings.notes),
                          const Gap(10),
                          DesignedFormField(
                            controller: cubit.notesController,
                            type: TextInputType.text,
                            allowMultiLines: true,
                            minLines: 3,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              // if (value.isEmpty) {
                              //   return AppStrings.thisFieldIsRequired;
                              // }
                            },
                          ),
                          const Gap(20),
                          DefaultButton(
                            loadingController:
                                (state is UploadImageToFirebaseLoadingState ||
                                    state is EditMemberLoadingState),
                            text: AppStrings.edit,
                            onTap: () {
                              if (cubit.formKey.currentState!.validate()) {
                                if(cubit.image!=null){
                                  cubit.uploadImageToFirebase();
                                }
                                else{
                                  cubit.editMember(imageUrl: user.image!,docId: user.documentId!);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MaritalStatusSection extends StatelessWidget {
  const MaritalStatusSection({
    super.key,
    required this.cubit,
  });

  final EditMemberCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                AppStrings.single,
                style: MyTextStyles.textStyle18Medium,
              ),
              const Gap(5),
              DefaultRadioButton(
                  value: AppStrings.single,
                  selectedValue: cubit.maritalStatus,
                  onChanged: (val) {
                    cubit.maritalStatus = val!;
                    cubit.setState();
                  }),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                AppStrings.married,
                style: MyTextStyles.textStyle18Medium,
              ),
              const Gap(5),
              DefaultRadioButton(
                  value: AppStrings.married,
                  selectedValue: cubit.maritalStatus,
                  onChanged: (val) {
                    cubit.maritalStatus = val!;
                    cubit.setState();
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class UserImageSection extends StatelessWidget {
  const UserImageSection({
    super.key,
    required this.cubit,
    required this.image,
  });

  final EditMemberCubit cubit;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            if (cubit.image != null) {
              cubit.removeImage();
            } else {
              selectImageAlert(
                cubit: cubit,
                context: context,
              );
            }
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: cubit.image != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        cubit.image!,
                      ))
                  : null,
            ),
            child: cubit.image == null
                ? CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                  )
                : null,
          )),
    );
  }
}
