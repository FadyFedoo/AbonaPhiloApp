import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/core/enums.dart';
import 'package:fr_philopater/reuseable_widgets/default_loading_widget.dart';
import 'package:fr_philopater/view/addictive_service/cubit/addictive_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../core/app_router/routes.dart';
import '../../core/constants.dart';
import '../../core/services/services_locator.dart';
import '../../core/shared_components.dart';
import '../../reuseable_widgets/search_widget.dart';
import '../../reuseable_widgets/user_sliver_list_widget.dart';
import 'cubit/addictive_state.dart';

class AddictiveServiceScreen extends StatelessWidget {
  const AddictiveServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddictiveCubit>()..getUsers(serviceType: ServiceType.addictive.name)..startScrollingListener(serviceType: ServiceType.addictive.name),
      child: Builder(
          builder: (context) {
            var cubit=AddictiveCubit.get(context);
            return BlocConsumer<AddictiveCubit, AddictiveState>(
              listener: (context, state) {
                if(state is GetUserErrorState)
                {
                  showToast(text: state.message, state: ToastStates.ERROR);
                }
              },
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    child: RefreshIndicator(
                      onRefresh: () async{
                        cubit.getUsers(serviceType: ServiceType.addictive.name);
                      },
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: cubit.scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: SearchWidget(
                              onTap: () {
                                GoRouter.of(context).push(AppRouter.searchScreen,extra: ServiceType.addictive);
                              },
                            ),
                          ),
                          if(cubit.users==null)
                          const SliverFillRemaining(
                            child: DefaultLoadingWidget(),
                          ),
                          if(cubit.users!=null)
                          UserSliverListWidget(users: cubit.users!),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
      ),
    );

  }
}
