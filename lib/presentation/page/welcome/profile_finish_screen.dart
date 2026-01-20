import 'package:flutter/material.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/domain/usecase/auth_usecase.dart';
import 'package:lab_2/injection.dart' as di;

class ProfileFinishScreen extends StatefulWidget {
  final Map<String, Object?>? userInfo;

  const ProfileFinishScreen({super.key, this.userInfo});

  @override
  State<ProfileFinishScreen> createState() => _ProfileFinishScreenState();
}

class _ProfileFinishScreenState extends State<ProfileFinishScreen> {
  final _authUseCase = di.locator<AuthUseCase>();

  Future<void> _updateUserData({
    required VoidCallback onSuccess,
    required VoidCallback onFail,
  }) async {
    if (widget.userInfo != null) {
      final result = await _authUseCase.updateProfile(
        userInfo: widget.userInfo ?? {},
      );
      result.match((failure) => onFail(), (_) => onSuccess());
    }
  }

  @override
  void initState() {
    super.initState();
    _updateUserData(onSuccess: () {}, onFail: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 47),
              Text(
                AppString.updatingData,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: ColorLight.neutralEel,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Align(
                alignment: AlignmentGeometry.center,
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    const SizedBox(
                      width: 231,
                      height: 231,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ColorLight.neutralSwain,
                        ),
                        strokeWidth: 1,
                        value: 1,
                      ),
                    ),

                    const SizedBox(
                      width: 216,
                      height: 216,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ColorLight.blueLight,
                        ),
                        strokeWidth: 16,
                        strokeCap: StrokeCap.round,
                        value: 0.6,
                      ),
                    ),
                    Text(
                      "55%",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 48,
                        color: ColorLight.blueLight,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                spacing: 12,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: ColorLight.blueLight,
                  ),
                  Expanded(
                    child: Text(
                      AppString.updateAccountInfo,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorLight.blueLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.5),
              Row(
                spacing: 12,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: ColorLight.blueLight,
                  ),
                  Expanded(
                    child: Text(
                      AppString.updateProfile,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorLight.blueLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.5),
              Row(
                spacing: 12,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: ColorLight.blueLight,
                  ),
                  Expanded(
                    child: Text(
                      AppString.updateSubscription,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorLight.blueLight,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
