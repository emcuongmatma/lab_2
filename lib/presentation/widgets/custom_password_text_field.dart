import 'package:flutter/material.dart';
import 'package:lab_2/common/colors.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String hint;
  final bool isValid;
  final bool isPure;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? errorText;
  final String? validText;
  final Color validBorderColor;
  const CustomPasswordTextField({
    super.key,
    required this.hint,
    this.onChanged,
    required this.isValid,
    required this.isPure,
    this.errorText,
    this.validText,
    this.controller,
    this.validBorderColor = ColorLight.neutralHare
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isObscured = true;

  Color get _mainColor {
    if (widget.isPure) return ColorLight.neutralHare;
    return widget.isValid ? widget.validBorderColor : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: ColorLight.neutralWolf,
            fontSize: 20,
          ),
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ColorLight.neutralHare,
              fontSize: 20,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _mainColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _mainColor,),
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _mainColor
              ),
            ),
          ),
      ],
    );
  }
}
