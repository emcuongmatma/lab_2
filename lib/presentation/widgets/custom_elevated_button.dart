import 'package:flutter/material.dart';
import 'package:lab_2/common/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onClick;
  final Color textColor;
  final Color backgroundButtonColor;
  final EdgeInsetsGeometry padding;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.onClick,
    this.textColor = Colors.white,
    this.backgroundButtonColor = ColorLight.blueLight,
    this.padding = const EdgeInsets.only(bottom: 6),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: onClick == null ? ColorLight.gray300 : ColorLight.blueLightShadow,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: onClick == null ? ColorLight.neutralSwain :backgroundButtonColor,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 20,
              color: onClick == null ? ColorLight.disableButtonText : textColor,
            ),
          ),
        ),
      ),
    );
  }
}
