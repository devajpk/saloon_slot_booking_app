import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_k/comman/router/app_router_constant.dart';
import 'package:project_k/feature/authentication/presentation/view/splash_screen.dart';


GoRouter returnRouter() {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {},
    routes: [
      GoRoute(
        path: '/',
        name: MyAppRouteConstance.splashPage,
        builder: (context, state) => const SplashScreen(),
      ),
    ]
  );
}
