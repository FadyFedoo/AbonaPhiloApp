import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fr_philopater/core/app_router/routes.dart';
import 'package:fr_philopater/core/constants.dart';
import 'package:fr_philopater/reuseable_widgets/default_loading_widget.dart';
import 'package:fr_philopater/view/confession_service/widgets/tap_bar_widget.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../core/enums.dart';
import '../../core/services/services_locator.dart';
import '../../core/shared_components.dart';
import '../../reuseable_widgets/search_widget.dart';
import '../../reuseable_widgets/user_sliver_list_widget.dart';
import 'cubit/confession_cubit.dart';
import 'cubit/confession_state.dart';

class ConfessionServiceScreen extends StatefulWidget {
  const ConfessionServiceScreen({super.key});

  @override
  State<ConfessionServiceScreen> createState() =>
      _ConfessionServiceScreenState();
}

class _ConfessionServiceScreenState extends State<ConfessionServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ConfessionCubit>()
      ..getUsersWithBirthdayToday()..getUsersWithMarriageDateToday()
        ..getUsersWithHundredDaysPeriod(
            serviceType: ServiceType.confessions.name)
        ..getUsersWithSixtyDaysPeriod(serviceType: ServiceType.confessions.name)
        ..getUsers(serviceType: ServiceType.confessions.name)
        ..getUsersWithFortyDaysPeriod(serviceType: ServiceType.confessions.name)
        ..startScrollingListener(serviceType: ServiceType.confessions.name),
      child: Builder(builder: (context) {
        var cubit = ConfessionCubit.get(context);
        return BlocConsumer<ConfessionCubit, ConfessionState>(
          listener: (context, state) {
            if (state is GetUserErrorState) {
              showToast(text: state.message, state: ToastStates.ERROR);
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: appPadding),
                child: RefreshIndicator(
                  onRefresh: () async {
                    switch (cubit.selectedPeriod) {
                      case Period.all:
                        cubit.getUsers(
                            serviceType: ServiceType.confessions.name);
                        break;
                      case Period.fortyDays:
                        cubit.getUsersWithFortyDaysPeriod(
                            serviceType: ServiceType.confessions.name);
                        break;
                      case Period.sixtyDays:
                        cubit.getUsersWithSixtyDaysPeriod(
                            serviceType: ServiceType.confessions.name);
                        break;
                      case Period.hundredDays:
                        cubit.getUsersWithHundredDaysPeriod(
                            serviceType: ServiceType.confessions.name);
                        break;
                    }
                  },
                  child: CustomScrollView(
                    controller: cubit.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: SearchWidget(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.searchScreen,
                                extra: ServiceType.confessions);
                          },
                        ),
                      ),
                      const SliverGap(20),
                      SliverToBoxAdapter(
                        child: TapBarWidget(cubit: cubit),
                      ),
                      const SliverGap(20),
                      if (cubit.users == null)
                        const SliverFillRemaining(
                          child: DefaultLoadingWidget(),
                        ),

                      // all users list
                      if (cubit.selectedPeriod == Period.all &&
                          cubit.users != null)
                        UserSliverListWidget(users: cubit.users!),

                      // 40 days users list
                      if (cubit.selectedPeriod == Period.fortyDays &&
                          cubit.usersWithFortyDaysPeriod != null)
                        UserSliverListWidget(
                            users: cubit.usersWithFortyDaysPeriod!),

                      // 60 days users list
                      if (cubit.selectedPeriod == Period.sixtyDays &&
                          cubit.usersWithSixtyDaysPeriod != null)
                        UserSliverListWidget(
                            users: cubit.usersWithSixtyDaysPeriod!),

                      // 100 days users list
                      if (cubit.selectedPeriod == Period.hundredDays &&
                          cubit.usersWithHundredDaysPeriod != null)
                        UserSliverListWidget(
                            users: cubit.usersWithHundredDaysPeriod!),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
