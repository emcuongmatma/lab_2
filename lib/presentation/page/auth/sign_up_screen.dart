import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/core/network/dio.dart';
import 'package:lab_2/data/api/auth_api.dart';
import 'package:lab_2/data/repository/auth_repository.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';
import 'package:lab_2/presentation/widgets/custom_normal_textfield.dart';
import 'package:lab_2/utils/validators.dart';
import '../../widgets/authentication_option.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _monkeyImage = "assets/images/monkey_image.png";
  final _usernameController = TextEditingController();
  bool _usernameValidated = false;
  final repo = AuthRepository(AuthApi(DioClient.create()));

  Future<void> checkPhoneNumber({required VoidCallback onSuccess}) async {
    try {
      final result = await repo.isAvailable(_usernameController.text);

      if (!result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Số điện thoại này đã được đăng ký!")),
        );
      } else {
        onSuccess();
      }
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.goNamed(AppRouteName.LOGIN_ROUTE_NAME);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: ColorLight.gray400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
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
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      "Nhập số điện thoại",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: ColorLight.neutralEel,
                      ),
                    ),
                    CustomNormalTextField(
                      hint: "Số điện thoại",
                      controller: _usernameController,
                      validator: validatorPhone,
                      onValidate: (isValidated) {
                        setState(() {
                          _usernameValidated = isValidated;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      autoValid: true,
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: "Tiếp tục",
                    onClick: _usernameValidated
                        ? () {
                            checkPhoneNumber(
                              onSuccess: () => context.pushNamed(
                                AppRouteName.SIGNUP_2_ROUTE_NAME,
                                pathParameters: {
                                  'username': _usernameController.text,
                                },
                              ),
                            );
                          }
                        : null,

                  ),
                ),
                AuthenticationOption(
                  optionText: "Hoặc đăng ký với",
                  text1: "Tôi đã có tài khoản. ",
                  text2: "Đăng nhập",
                  onAction: () =>
                      context.goNamed(AppRouteName.LOGIN_ROUTE_NAME),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
