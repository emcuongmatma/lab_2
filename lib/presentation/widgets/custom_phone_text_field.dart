import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w800,
            color: ColorLight.neutralWolf,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.w800,
              color: ColorLight.neutralHare,
              fontSize: 18,
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
              borderSide: BorderSide(color: _mainColor, width: 2),
            ),
          ),
        ),

        if (!isPure)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Text(
              isValid ? (validText ?? "") : (errorText ?? ""),
              style: GoogleFonts.nunito(
                color: _mainColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}