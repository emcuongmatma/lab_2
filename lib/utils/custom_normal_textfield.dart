import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/utils/validators.dart';

import '../common/colors.dart';

class CustomNormalTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(bool)? onValidate;
  final bool? autoValid;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const CustomNormalTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.onValidate,
    this.autoValid,
    this.textInputAction,
    this.validator, this.focusNode,
  });

  @override
  State<CustomNormalTextField> createState() => _CustomNormalTextFieldState();
}

class _CustomNormalTextFieldState extends State<CustomNormalTextField> {
  Color borderColor = ColorLight.neutralHare;
  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      validator: widget.validator ?? validatorPhone,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      style: GoogleFonts.nunito(
        fontWeight: FontWeight.w800,
        color: ColorLight.neutralWolf,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.w800,
          color: ColorLight.neutralHare,
          fontSize: 18,
        ),
        suffixIcon: isValidated
            ? IconButton(
                padding: const EdgeInsets.only(right: 24),
                onPressed: () {},
                icon: SvgPicture.asset("assets/icons/ic_validated.svg"),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.autoValid == true) {
      widget.controller.addListener(() {
        if (mounted) {
          setState(() {
            isValidated = widget.validator?.call(widget.controller.text) == null ;
            borderColor = isValidated
                ? ColorLight.primaryGreen
                : ColorLight.neutralHare;
          });
          widget.onValidate?.call(isValidated);
        }
      });
    }
  }
}
