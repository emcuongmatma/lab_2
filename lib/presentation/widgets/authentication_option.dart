import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/presentation/widgets/text_span_with_action.dart';

class AuthenticationOption extends StatelessWidget {
  final Function? onFacebookAction;
  final Function? onGoogleAction;
  final Function? onAppleAction;
  final Function? onAction;
  final String optionText;
  final String text1;
  final String text2;

  const AuthenticationOption({
    super.key,
    this.onFacebookAction,
    this.onGoogleAction,
    this.onAppleAction,
    this.onAction,
    required this.text1,
    required this.text2,
    required this.optionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(thickness: 1, color: ColorLight.neutralHare),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                optionText,
                style: const TextStyle(
                  color: ColorLight.neutralWolf,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const Expanded(
              child: Divider(thickness: 1, color: ColorLight.neutralHare),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          spacing: 12,
          children: [
            _socialButton(
              icon: Assets.iconsIcFacebook,
              color: const Color(0xFF1877F2),
              onTap: () => onFacebookAction?.call(),
            ),
            _socialButton(
              icon: Assets.iconsIcGoogle,
              color: Colors.white,
              onTap: () => onGoogleAction?.call(),
            ),
            _socialButton(
              icon: Assets.iconsIcApple,
              color: Colors.black,
              onTap: () => onAppleAction?.call(),
            ),
          ],
        ),
        const SizedBox(height: 28),
        TextSpanWithAction(text1: text1, text2: text2, onAction: onAction),
      ],
    );
  }
}

Widget _socialButton({
  required String icon,
  required Color color,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1,color: ColorLight.gray300)
        ),
        child: Center(child: SvgPicture.asset(icon, width: 24, height: 24)),
      ),
    ),
  );
}
