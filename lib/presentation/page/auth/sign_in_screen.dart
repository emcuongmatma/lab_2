import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/data/repository/auth_repository.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/presentation/page/auth/model/password_input.dart';
import 'package:lab_2/presentation/page/auth/model/username_input.dart';
import 'package:lab_2/presentation/widgets/authentication_option.dart';
import 'package:lab_2/presentation/widgets/custom_dialog.dart';
import 'package:lab_2/presentation/widgets/custom_password_text_field.dart';
import 'package:lab_2/presentation/widgets/custom_phone_text_field.dart';
import 'package:lab_2/presentation/widgets/loading_overlay.dart';
import 'package:lab_2/presentation/widgets/text_span_with_action.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';
import 'package:lab_2/injection.dart' as di;

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _repo = di.locator<AuthRepository>();
  final _controller = TextEditingController();
  String _username = "";
  String _password = "";
  PhoneInput _usernameInput = const PhoneInput.pure();
  PasswordInput _passwordInput = const PasswordInput.pure();
  bool _isLoading = false;
  int _failedAttemptsCount = 0;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String? get _usernameStatusText {
    if (_usernameInput.isPure) return null;
    switch (_usernameInput.error) {
      case PhoneValidationError.empty:
        return "Không được bỏ trống";
      case PhoneValidationError.invalid:
        return "Số điện thoại cần nhập 6 - 15 chữ số";
      case PhoneValidationError.notFound:
        return "Số điện thoại hoặc mật khẩu không đúng";
      default:
        return null;
    }
  }

  String? get _passwordStatusText {
    if (_passwordInput.isPure) return null;
    switch (_passwordInput.error) {
      case PasswordValidationError.empty:
        return "Không được bỏ trống";
      default:
        return null;
    }
  }

  Future<void> submit({
    required VoidCallback onSuccess,
    required VoidCallback showForgotPasswordDialog,
  }) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await _repo.login(_username, _password);
      if (result.success) {
        onSuccess.call();
      } else {
        setState(() {
          _usernameInput = PhoneInput.dirty(_username, true);
          _passwordInput = const PasswordInput.pure();
          _controller.clear();
          _failedAttemptsCount++;
          if (_failedAttemptsCount == 5) showForgotPasswordDialog();
        });
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
            onPressed: () {},
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
                  spacing: 12,
                  children: [
                    CustomPhoneTextField(
                      hint: "Số điện thoại/Tên đăng nhập",
                      isValid: _usernameInput.isValid,
                      isPure: _usernameInput.isPure,
                      errorText: _usernameStatusText,
                      onChanged: (val) {
                        setState(() {
                          _usernameInput = const PhoneInput.pure();
                          _username = val;
                        });
                      },
                    ),
                    CustomPasswordTextField(
                      hint: "Mật khẩu",
                      isValid: _passwordInput.isValid,
                      isPure: _passwordInput.isPure,
                      errorText: _passwordStatusText,
                      controller: _controller,
                      onChanged: (val) {
                        setState(() {
                          _passwordInput = const PasswordInput.pure();
                          _password = val;
                        });
                      },
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
                    setState(() {
                      _usernameInput = PhoneInput.dirty(_username);
                      _passwordInput = PasswordInput.dirty(_password);
                    });
                    if (_usernameInput.isValid && _passwordInput.isValid) {
                      submit(
                        onSuccess: () => context.pushNamed(
                          AppRouteName.PROFILE_CHOOSE_ROUTE_NAME,
                        ),
                        showForgotPasswordDialog: () {
                          showNotifyColumnOptionDialog(
                            context: context,
                            message:
                                "Bạn đã nhập sai mật khẩu quá 5 lần.\nChọn \"Quên mật khẩu\" để khôi phục nhé.",
                            buttonText1: "Quên mật khẩu",
                            buttonText2: "Thử lại",
                            onAction2:() {
                              setState(() {
                                _failedAttemptsCount = 0;
                              });
                            }
                          );
                        },
                      );
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
                  onAction: () => context.push(AppRoutePath.SIGNUP_ROUTE_PATH),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
