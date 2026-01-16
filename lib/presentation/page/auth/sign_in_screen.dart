
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/presentation/widgets/text_span_with_action.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';
import 'package:lab_2/presentation/widgets/custom_normal_textfield.dart';

import '../../../utils/validators.dart';
import '../../widgets/authentication_option.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _monkeyImage = "assets/images/monkey_image.png";
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorLight.gray400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 24,
              children: [
                SizedBox(
                  height: 169,
                  width: 151,
                  child: Image.asset(_monkeyImage),
                ),
                Column(
                  spacing: 12,
                  children: [
                    CustomNormalTextField(
                      hint: "Số điện thoại/Tên đăng nhập",
                      controller: _usernameController,
                    ),
                    PasswordTextField(
                      controller: _passwordController,
                      hint: "Mật khẩu",
                      validator: validatorPassword,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ID thiết bị: 100600",
                          style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: const Color(0xFFAFAFAF),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(8),
                          child: Text(
                            "Quên mật khẩu?",
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: const Color(0xFF777777),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CustomElevatedButton(
                  text: "Đăng nhập",
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      context.pushNamed(AppRouteName.PROFILE_CHOOSE_ROUTE_NAME);
                    }
                  },
                ),
                TextSpanWithAction(
                  text1: "Nếu bạn có mã kích hoạt, ",
                  text2: "Nhập tại đây",
                  onAction: () {},
                ),
                AuthenticationOption(
                  optionText: "Hoặc đăng nhập với",
                  text1: "Bạn chưa có tài khoản? ",
                  text2: "Đăng ký",
                  onAction: () => context.go(AppRoutePath.SIGNUP_ROUTE_PATH),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(bool)? onValidate;
  final bool? autoValid;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.onValidate,
    this.autoValid,
  });

  @override
  State<PasswordTextField> createState() =>
      _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscured = true;
  bool _showHideButton = false;
  Color borderColor = ColorLight.neutralHare;
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          _showHideButton = widget.controller.text.isNotEmpty;
        });
      }
      if (widget.autoValid == true) {
        setState(() {
          isValidated = validatorPassword(widget.controller.text) == null;
          borderColor = isValidated
              ? ColorLight.primaryGreen
              : ColorLight.neutralHare;
        });
        widget.onValidate?.call(isValidated);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscured,
      keyboardType: TextInputType.text,
      validator: widget.validator,
      controller: widget.controller,
      style: GoogleFonts.nunito(
        fontWeight: FontWeight.w800,
        color: ColorLight.neutralWolf,
        fontSize: 18,
      ),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: GoogleFonts.nunito(
          fontWeight: FontWeight.w800,
          color: ColorLight.neutralHare,
          fontSize: 18,
        ),
        suffixIcon: _showHideButton
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
            color: ColorLight.neutralHare,
          ),
          onPressed: () => setState(() => _isObscured = !_isObscured),
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
}

