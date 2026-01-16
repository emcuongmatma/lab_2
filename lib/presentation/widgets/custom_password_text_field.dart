import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/colors.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String hint;
  final bool isValid;
  final bool isPure;
  final Function(String)? onChanged;
  final String? errorText;
  final String? validText;

  const CustomPasswordTextField({
    super.key,
    required this.hint,
    this.onChanged,
    required this.isValid,
    required this.isPure,
    this.errorText,
    this.validText,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isObscured = true;

  Color get _mainColor {
    if (widget.isPure) return ColorLight.neutralHare;
    return widget.isValid ? ColorLight.primaryGreen : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: _isObscured,
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w800,
            color: ColorLight.neutralWolf,
            fontSize: 18,
          ),
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.nunito(
              fontWeight: FontWeight.w800,
              color: ColorLight.neutralHare,
              fontSize: 18,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _mainColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _mainColor, width: 2),
            ),

            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: ColorLight.neutralHare,
              ),
              onPressed: () => setState(() => _isObscured = !_isObscured),
            ),
          ),
        ),

        if (!widget.isPure)
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 12),
            child: Text(
              widget.isValid
                  ? (widget.validText ?? "")
                  : (widget.errorText ?? ""),
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

enum PasswordValidationError { empty, invalid, tooShort }

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');

  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 6) return PasswordValidationError.tooShort;
    return null;
  }
}
