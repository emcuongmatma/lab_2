import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/domain/usecase/auth_usecase.dart';
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
  final _authUseCase = di.locator<AuthUseCase>();
  bool _isLoading = false;

  Future<void> checkPhoneNumber({
    required VoidCallback onSuccess,
    required VoidCallback showPhoneUsedDialog,
  }) async {
    setState(() {
      _isLoading = true;
    });
    final result = await _authUseCase.checkAvailable(
      phone: _usernameInput.value,
    );
    result.match(
      (failure) {
        debugPrint(failure.message);
      },
      (isAvailable) => isAvailable ? onSuccess() : showPhoneUsedDialog(),
    );
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
                        AppString.enterPhone,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: ColorLight.neutralEel,
                        ),
                      ),
                      CustomPhoneTextField(
                        hint: AppString.phone,
                        isValid: _usernameInput.isValid,
                        isPure: _usernameInput.isPure,
                        textInputAction: TextInputAction.done,
                        validText: AppString.phoneAvailable,
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
                      text: AppString.continu,
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
                                    message: AppString.phoneAlreadyRegisted,
                                    buttonText1: AppString.cancel,
                                    buttonText2: AppString.signin,
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
                    onAction: () {
                      if (_usernameInput.value.isNotEmpty) {
                        showNotifyRowOptionDialog(
                          context: context,
                          message: AppString.warningProfile(
                            _usernameInput.value,
                          ),
                          buttonText1: AppString.cancel,
                          buttonText2: AppString.signin,
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
