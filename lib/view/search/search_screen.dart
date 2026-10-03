import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/core/constants.dart';
import 'package:fr_philopater/core/shared_components.dart';
import 'package:fr_philopater/core/styles/icon_broken.dart';
import 'package:fr_philopater/reuseable_widgets/designed_form_field.dart';
import 'package:fr_philopater/view/search/cubit/search_cubit.dart';
import 'package:gap/gap.dart';

import '../../core/app_strings/app_strings.dart';
import '../../core/enums.dart';
import '../../core/services/services_locator.dart';
import '../../core/styles/text_styles.dart';
import '../../reuseable_widgets/empty_list_widget.dart';
import '../../reuseable_widgets/user_sliver_list_widget.dart';
import 'cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.serviceType});

  final ServiceType serviceType;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
          AppStrings.search,
          style: MyTextStyles.textStyle18Bold,
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<SearchCubit>()
          ..startScrollingListener(
            serviceType: widget.serviceType.name,
          ),
        child: Builder(builder: (context) {
          var cubit = SearchCubit.get(context);
          return BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {
              if (state is GetUserErrorState) {
                showToast(state: ToastStates.ERROR, text: state.message);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: appPadding),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: DesignedFormField(
                        controller: cubit.searchController,
                        type: TextInputType.name,
                        textInputAction: TextInputAction.search,
                        suffixIcon: const Icon(
                          IconBroken.Search,
                          color: Colors.black,
                        ),
                        onSubmit: (val) {
                          cubit.searchUsers(serviceType: widget.serviceType.name);
                        },
                      ),
                    ),
                    const SliverGap(20),
                    if (cubit.searchController.text.isNotEmpty &&
                        cubit.users == null)
                      const SliverFillRemaining(
                        child: EmptyListWidget(),
                      ),
                    if (cubit.searchController.text.isNotEmpty &&
                        cubit.users != null)
                      UserSliverListWidget(users: cubit.users!)
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
