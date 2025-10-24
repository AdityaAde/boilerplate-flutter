import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../modules/modules.dart';
import '../../injector.dart';

@RoutePage()
class HomeWrapper extends StatelessWidget implements AutoRouteWrapper {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<TestCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<PostsCubit>()..fetchPosts(),
        ),
      ],
      child: this,
    );
  }
}
