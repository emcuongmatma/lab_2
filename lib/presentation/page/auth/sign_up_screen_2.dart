import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/data/repository/auth_repository.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/injection.dart' as di;
import 'package:lab_2/presentation/page/auth/model/password_input.dart';
import 'package:lab_2/presentation/widgets/authentication_option.dart';
import 'package:lab_2/presentation/widgets/custom_dialog.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';
import 'package:lab_2/presentation/widgets/custom_password_text_field.dart';
import 'package:lab_2/presentation/widgets/loading_overlay.dart';

class SignUpScreen2 extends StatefulWidget {
  final String? username;

  const SignUpScreen2({super.key, required this.username});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  bool _allValidated = false;
  PasswordInput _password = const PasswordInput.pure();
  PasswordInput _rePassword = const PasswordInput.pure();
  final _repo = di.locator<AuthRepository>();
  bool _isLoading = false;

  Future<void> signUp({required VoidCallback onSuccess, required VoidCallback onFail}) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (widget.username != null) {
        final result = await _repo.signUp(
          widget.username ?? "",
          _password.value,
        );
        if (result.success) {
          onSuccess();
        } else {
          onFail();
        }
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
              if (context.canPop()) {
                context.pop();
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: ColorLight.gray400,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      "Tạo mật khẩu",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: ColorLight.neutralEel,
                      ),
                    ),
                    CustomPasswordTextField(
                      hint: "Nhập mật khẩu",
                      isValid: _password.isValid,
                      isPure: _password.isPure,
                      errorText: _passwordStatusText,
                      validText: "Mật khẩu hợp lệ",
                      validBorderColor: ColorLight.primaryGreen,
                      onChanged: (val) {
                        setState(() {
                          _password = PasswordInput.dirty(val);
                          _allValidated =
                              _password.isValid &&
                              _rePassword.isValid &&
                              _password.value == _rePassword.value;
                        });
                      },
                    ),

                    CustomPasswordTextField(
                      hint: "Nhập lại mật khẩu",
                      validBorderColor: ColorLight.primaryGreen,
                      isValid:
                          _password.value == _rePassword.value &&
                          _password.value.isNotEmpty,
                      isPure: _rePassword.isPure,
                      errorText: _password.value != _rePassword.value
                          ? "Mật khẩu không trùng khớp"
                          : null,
                      validText: _password.value != _rePassword.value
                          ? null
                          : "Mật khẩu trùng khớp",
                      onChanged: (val) {
                        setState(() {
                          _rePassword = PasswordInput.dirty(val);
                          _allValidated =
                              _password.isValid &&
                              _rePassword.isValid &&
                              _password.value == _rePassword.value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: "Tiếp tục",
                    onClick: _allValidated
                        ? () {
                            signUp(
                              onSuccess: () => context.goNamed(
                                AppRouteName.WELCOME_ROUTE_NAME,
                                pathParameters: {
                                  'username': widget.username ?? "",
                                }
                              ),
                              onFail: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Không thể nhận dạng số điện thoại")),
                                );
                              }
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
                    showNotifyDialog(context, "Đăng nhập bằng Google thất bại");
                  },
                  onAppleAction: () {
                    showNotifyDialog(context, "Đăng nhập bằng Apple thất bại");
                  },
                  onAction: () => context.go(AppRoutePath.LOGIN_ROUTE_PATH),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? get _passwordStatusText {
    if (_password.isPure) return null;
    switch (_password.error) {
      case PasswordValidationError.empty:
        return "Không được bỏ trống";
      case PasswordValidationError.tooShort:
        return "Mật khẩu phải có ít nhất 6 ký tự";
      case PasswordValidationError.invalid:
        return "Mật khẩu không hợp lệ";
      default:
        return null;
    }
  }
}
