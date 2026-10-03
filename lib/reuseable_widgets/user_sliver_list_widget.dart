import 'package:flutter/material.dart';
import 'package:fr_philopater/reuseable_widgets/user_card_widget.dart';

import '../models/user_model.dart';
import 'empty_list_widget.dart';

class UserSliverListWidget extends StatelessWidget {
  const UserSliverListWidget({
    super.key,
    required this.users,
  });

  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? const SliverFillRemaining(
            child: EmptyListWidget(),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return UserCard(user: users[index]);
              },
              childCount: users.length,
            ),
          );
  }
}
