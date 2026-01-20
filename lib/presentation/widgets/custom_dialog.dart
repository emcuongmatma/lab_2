import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';

void showNotifyDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    fullscreenDialog: true,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.imagesMonkeyFailure, height: 120),
                  const SizedBox(height: 12),
                  Text(
                    AppString.noti,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorLight.neutralEel,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorLight.neutralWolf,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomElevatedButton(
                    onClick: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    text: AppString.gotIt,
                  ),
                ],
              ),
            ),

            Positioned(
              right: -8,
              top: -8,
              child: GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                child: SvgPicture.asset(
                  Assets.iconsIcClose,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showNotifyColumnOptionDialog({
  required BuildContext context,
  required String message,
  String? buttonText1,
  String? buttonText2,
  Function? onAction1,
  Function? onAction2,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.imagesMonkeyFailure, height: 120),
                  const SizedBox(height: 12),
                  Text(
                    AppString.noti,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorLight.neutralEel,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorLight.neutralWolf,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomElevatedButton(
                    onClick: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                      onAction1?.call();
                    },
                    text: buttonText1 ?? "",
                  ),
                  const SizedBox(height: 12),
                  CustomElevatedButton(
                    backgroundButtonColor: Colors.white,
                    textColor: ColorLight.blueLight,
                    padding: const EdgeInsetsGeometry.only(
                      top: 1,
                      left: 1,
                      right: 1,
                      bottom: 5,
                    ),
                    onClick: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                      onAction2?.call();
                    },
                    text: buttonText2 ?? "",
                  ),
                ],
              ),
            ),

            Positioned(
              right: -8,
              top: -8,
              child: GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                child: SvgPicture.asset(
                  Assets.iconsIcClose,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showNotifyRowOptionDialog({
  required BuildContext context,
  required String message,
  String? buttonText1,
  String? buttonText2,
  Function? onAction1,
  Function? onAction2,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.imagesMonkeyFailure, height: 120),
                  const SizedBox(height: 12),
                  Text(
                    AppString.noti,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: ColorLight.neutralEel,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorLight.neutralWolf,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    spacing: 16,
                    children: [
                      Flexible(
                        flex: 1,
                        child: CustomElevatedButton(
                          backgroundButtonColor: Colors.white,
                          textColor: ColorLight.blueLight,
                          padding: const EdgeInsetsGeometry.only(
                            top: 1,
                            left: 1,
                            right: 1,
                            bottom: 5,
                          ),
                          onClick: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                            onAction1?.call();
                          },
                          text: buttonText1 ?? "",
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: CustomElevatedButton(
                          onClick: () {
                            if (context.canPop()) {
                              context.pop();
                            }
                            onAction2?.call();
                          },
                          text: buttonText2 ?? "",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              right: -8,
              top: -8,
              child: GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                child: SvgPicture.asset(
                  Assets.iconsIcClose,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
