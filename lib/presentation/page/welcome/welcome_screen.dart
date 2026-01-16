import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  final backgroundImage = "assets/images/register_background_image.png";
  final fireworkImage = "assets/images/firework_image.png";

  const WelcomeScreen({super.key});

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
                  "Chào mừng bạn đến Monkey Stories",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
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
                    child: Image.asset(fireworkImage, width: 102, height: 102),
                  ),
                  Positioned(
                    top: 40,
                    left: 6,
                    child: Image.asset(fireworkImage, width: 102, height: 102),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 36,
                      right: 36,
                      top: 120,
                    ),
                    child: Image.asset(backgroundImage),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsetsGeometry.only(bottom: 36),
                child: CustomElevatedButton(text: "Tiếp tục", onClick: () {
                  context.goNamed(AppRouteName.PROFILE_SETUP_ROUTE_NAME);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
