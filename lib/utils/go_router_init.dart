import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_2/presentation/page/auth/profile_screen.dart';
import 'package:lab_2/presentation/page/auth/sign_in_screen.dart';
import 'package:lab_2/presentation/page/auth/sign_up_screen.dart';
import 'package:lab_2/presentation/page/auth/sign_up_screen_2.dart';
import 'package:lab_2/presentation/page/welcome/profile_finish_screen.dart';
import 'package:lab_2/presentation/page/welcome/profile_setup_screen.dart';
import 'package:lab_2/presentation/page/welcome/welcome_screen.dart';

import '../common/routes.dart';

GoRouter router = GoRouter(
  initialLocation: AppRoutePath.LOGIN_ROUTE_PATH ,
  routes: <RouteBase>[
    GoRoute(
      name: AppRouteName.LOGIN_ROUTE_NAME,
      path: AppRoutePath.LOGIN_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SignInScreen();
      },
    ),
    GoRoute(
      name: AppRouteName.SIGNUP_ROUTE_NAME,
      path: AppRoutePath.SIGNUP_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      name: AppRouteName.SIGNUP_2_ROUTE_NAME,
      path: AppRoutePath.SIGNUP_2_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        final username = state.pathParameters['username'];
        return SignUpScreen2(username: username);
      },
    ),
    GoRoute(
      name: AppRouteName.WELCOME_ROUTE_NAME,
      path: AppRoutePath.WELCOME_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        final username = state.pathParameters['username'];
        return WelcomeScreen(username: username);
      },
    ),

    GoRoute(
      name: AppRouteName.PROFILE_SETUP_ROUTE_NAME,
      path: AppRoutePath.PROFILE_SETUP_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        final username = state.pathParameters['username'];
        return ProfileSetupScreen(username: username);
      },
    ),

    GoRoute(
      name: AppRouteName.PROFILE_FINISH_ROUTE_NAME,
      path: AppRoutePath.PROFILE_FINISH_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        final userInfo = state.extra as Map<String, Object?>;
        return ProfileFinishScreen(userInfo:  userInfo);
      },
    ),

    GoRoute(
      name: AppRouteName.PROFILE_CHOOSE_ROUTE_NAME,
      path: AppRoutePath.PROFILE_CHOOSE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),

  ],
);