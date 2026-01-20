import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/domain/usecase/auth_usecase.dart';
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
  final _authUseCase = di.locator<AuthUseCase>();
  bool _isLoading = false;

  Future<void> signUp({
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    setState(() {
      _isLoading = true;
    });
    if (widget.username != null) {
      final result = await _authUseCase.signup(
        phone: widget.username ?? "",
        password: _password.value,
      );
      result.match((failure) => onFail(), (_) => onSuccess());
    }

    setState(() {
      _isLoading = false;
    });
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
                      AppString.createPassword,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: ColorLight.neutralEel,
                      ),
                    ),
                    CustomPasswordTextField(
                      hint: AppString.enterPassword,
                      isValid: _password.isValid,
                      isPure: _password.isPure,
                      errorText: _passwordStatusText,
                      validText: AppString.passwordValid,
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
                      hint: AppString.reEnterPassword,
                      validBorderColor: ColorLight.primaryGreen,
                      isValid:
                          _password.value == _rePassword.value &&
                          _password.value.isNotEmpty,
                      isPure: _rePassword.isPure,
                      errorText: _password.value != _rePassword.value
                          ? AppString.passwordNotMatch
                          : null,
                      validText: _password.value != _rePassword.value
                          ? null
                          : AppString.passwordMatch,
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
                    text: AppString.continu,
                    onClick: _allValidated
                        ? () {
                            signUp(
                              onSuccess: () => context.goNamed(
                                AppRouteName.WELCOME_ROUTE_NAME,
                                pathParameters: {
                                  'username': widget.username ?? "",
                                },
                              ),
                              onFail: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(AppString.canNotReconPhone),
                                  ),
                                );
                              },
                            );
                          }
                        : null,
                  ),
                ),
                AuthenticationOption(
                  optionText: AppString.orSignUpWith,
                  text1: AppString.alreadyHaveAccount,
                  text2: AppString.signin,
                  onFacebookAction: () {
                    showNotifyDialog(context, AppString.signInWithFbFail);
                  },
                  onGoogleAction: () {
                    showNotifyDialog(context, AppString.signInWithGgFail);
                  },
                  onAppleAction: () {
                    showNotifyDialog(context, AppString.signInWithApFail);
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
        return AppString.doNotEmpty;
      case PasswordValidationError.tooShort:
        return AppString.passwordAtleast6;
      case PasswordValidationError.invalid:
        return AppString.passwordNotValid;
      default:
        return null;
    }
  }
}
