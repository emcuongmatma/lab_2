import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  final String? username;

  const WelcomeScreen({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 66),
                child: Text(
                  AppString.welcomeToMonkeyStory,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: ColorLight.blueLight,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Stack(
                children: [
                  Positioned(
                    right: 6,
                    child: Image.asset(
                      Assets.imagesFireworkImage,
                      width: 102,
                      height: 102,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 6,
                    child: Image.asset(
                      Assets.imagesFireworkImage,
                      width: 102,
                      height: 102,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 36,
                      right: 36,
                      top: 120,
                    ),
                    child: Image.asset(Assets.imagesRegisterBackgroundImage),
                  ),
                ],
              ),
              const Spacer(),
              CustomElevatedButton(
                text: AppString.continu,
                onClick: () {
                  context.goNamed(
                    AppRouteName.PROFILE_SETUP_ROUTE_NAME,
                    pathParameters: {'username': username ?? ""},
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
