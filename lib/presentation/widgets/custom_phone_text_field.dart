import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/generated/assets.dart';

class CustomPhoneTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool isValid;
  final bool isPure;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? errorText;
  final String? validText;
  final Function(String)? onChanged;
  final Color validBorderColor;

  const CustomPhoneTextField({
    super.key,
    this.controller,
    required this.hint,
    this.textInputAction,
    this.focusNode,
    required this.isValid,
    required this.isPure,
    this.errorText,
    this.validText,
    this.onChanged,
    this.validBorderColor = ColorLight.neutralHare
  });

  Color get _mainColor {
    if (isPure) return ColorLight.neutralHare;
    return isValid ? validBorderColor : Colors.red;
  }

  bool get _shouldShowValidIcon => !isPure && isValid && validText != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.next,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: ColorLight.neutralWolf,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ColorLight.neutralHare,
              fontSize: 20,
            ),
            suffixIcon: _shouldShowValidIcon
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(Assets.iconsIcValidated),
            )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _mainColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _mainColor),
            ),
          ),
        ),

        if (!isPure)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Text(
              isValid ? (validText ?? "") : (errorText ?? ""),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _mainColor,
              ),
            ),
          ),
      ],
    );
  }
}