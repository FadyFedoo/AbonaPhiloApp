import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_router/routes.dart';
import '../../reuseable_widgets/default_loading_widget.dart';

class RefreshAppScreen extends StatefulWidget {
  const RefreshAppScreen({super.key});

  @override
  State<RefreshAppScreen> createState() => _RefreshAppScreenState();
}

class _RefreshAppScreenState extends State<RefreshAppScreen> {
  @override
  void initState() {
    initNavigateToHomeView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultLoadingWidget(),
    );
  }

  void initNavigateToHomeView() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      GoRouter.of(context).go(AppRouter.appLayoutScreen);
    });
  }
}
