import 'package:fr_philopater/repositories/users_repo/users_firebase_repo_impl.dart';
import 'package:get_it/get_it.dart';

import '../../repositories/users_repo/users_repo.dart';
import '../../view/add_new_member/cubit/add_new_member_cubit.dart';
import '../../view/addictive_service/cubit/addictive_cubit.dart';
import '../../view/app_layout/cubit/app_cubit.dart';
import '../../view/confession_service/cubit/confession_cubit.dart';
import '../../view/edit_member/cubit/edit_member_cubit.dart';
import '../../view/member_profile/cubit/member_profile_cubit.dart';
import '../../view/search/cubit/search_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    // cubits
    sl.registerFactory(() => AppCubit());
    sl.registerFactory(() => AddNewMemberCubit(usersRepo: sl<UsersRepo>()));
    sl.registerFactory(() => EditMemberCubit(usersRepo: sl<UsersRepo>()));
    sl.registerFactory(() => AddictiveCubit(usersRepo: sl<UsersRepo>()));
    sl.registerFactory(() => ConfessionCubit(usersRepo: sl<UsersRepo>()));
    sl.registerFactory(() => MemberProfileCubit(usersRepo: sl<UsersRepo>()));
    sl.registerFactory(() => SearchCubit(usersRepo: sl<UsersRepo>()));

    //Repository
    sl.registerLazySingleton<UsersRepo>(() => UsersFirebaseRepoImpl());
  }
}
