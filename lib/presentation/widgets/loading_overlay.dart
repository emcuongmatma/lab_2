import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_2/generated/assets.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AbsorbPointer(
            child: Scaffold(
              backgroundColor: Colors.black26,
              body: Stack(
                children: [
                  Center(child: SvgPicture.asset(Assets.iconsIcLoading)),
                  const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
