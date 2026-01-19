import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/data/repository/auth_repository.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/injection.dart' as di;
import 'package:lab_2/presentation/page/auth/model/username_input.dart';
import 'package:lab_2/presentation/widgets/authentication_option.dart';
import 'package:lab_2/presentation/widgets/custom_dialog.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';
import 'package:lab_2/presentation/widgets/custom_phone_text_field.dart';
import 'package:lab_2/presentation/widgets/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  PhoneInput _usernameInput = const PhoneInput.pure();
  final _repo = di.locator<AuthRepository>();
  bool _isLoading = false;

  Future<void> checkPhoneNumber({
    required VoidCallback onSuccess,
    required VoidCallback showPhoneUsedDialog,
  }) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await _repo.isAvailable(_usernameInput.value);
      if (result.data == true) {
        onSuccess();
      } else {
        showPhoneUsedDialog();
      }
    } catch (e) {
      return;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.goNamed(AppRouteName.LOGIN_ROUTE_NAME);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorLight.gray400,
            ),
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
                    child: Image.asset(Assets.imagesMonkeyImage),
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
                      CustomPhoneTextField(
                        hint: "Số điện thoại",
                        isValid: _usernameInput.isValid,
                        isPure: _usernameInput.isPure,
                        textInputAction: TextInputAction.done,
                        validText: "Số điện thoại khả dụng",
                        validBorderColor: ColorLight.primaryGreen,
                        onChanged: (val) {
                          setState(() {
                            _usernameInput = PhoneInput.dirty(val);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: "Tiếp tục",
                      onClick: _usernameInput.isValid
                          ? () {
                              checkPhoneNumber(
                                onSuccess: () => context.pushNamed(
                                  AppRouteName.SIGNUP_2_ROUTE_NAME,
                                  pathParameters: {
                                    'username': _usernameInput.value,
                                  },
                                ),
                                showPhoneUsedDialog: () {
                                  showNotifyRowOptionDialog(
                                    context: context,
                                    message:
                                        "Số điện thoại này đã được đăng ký với Monkey, ba mẹ hãy đăng nhập nhé.",
                                    buttonText1: "Huỷ",
                                    buttonText2: "Đăng nhập",
                                    onAction2: () => context.pushNamed(
                                      AppRouteName.LOGIN_ROUTE_NAME,
                                    ),
                                  );
                                },
                              );
                            }
                          : null,
                    ),
                  ),
                  AuthenticationOption(
                    optionText: "Hoặc đăng ký với",
                    text1: "Tôi đã có tài khoản. ",
                    text2: "Đăng nhập",
                    onFacebookAction: () {
                      showNotifyDialog(
                        context,
                        "Đăng nhập bằng Facebook thất bại",
                      );
                    },
                    onGoogleAction: () {
                      showNotifyDialog(
                        context,
                        "Đăng nhập bằng Google thất bại",
                      );
                    },
                    onAppleAction: () {
                      showNotifyDialog(
                        context,
                        "Đăng nhập bằng Apple thất bại",
                      );
                    },
                    onAction: () {
                      if (_usernameInput.value.isNotEmpty) {
                        showNotifyRowOptionDialog(
                          context: context,
                          message:
                              "Ba mẹ sẽ mất đi hồ sơ học ${_usernameInput.value}, ba mẹ có muốn đăng nhập không?",
                          buttonText1: "Huỷ",
                          buttonText2: "Đăng nhập",
                          onAction2: () =>
                              context.goNamed(AppRouteName.LOGIN_ROUTE_NAME),
                        );
                      } else {
                        context.goNamed(AppRouteName.LOGIN_ROUTE_NAME);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
