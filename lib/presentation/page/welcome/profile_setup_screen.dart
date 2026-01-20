import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_2/common/routes.dart';
import 'package:lab_2/presentation/page/welcome/step/birth_step_widget.dart';
import 'package:lab_2/presentation/page/welcome/step/level_step_widget.dart';
import 'package:lab_2/presentation/page/welcome/step/name_step_widget.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String? username;

  const ProfileSetupScreen({super.key, this.username});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final PageController _pageController = PageController();
  String _name = "";
  int _birthYear = 2026;
  int? _englishLevel;

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 24),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: _previousPage,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    NameStep(
                      onNext: (name) {
                        setState(() {
                          _name = name;
                        });
                        _nextPage();
                      },
                      name: _name,
                    ),
                    BirthStep(
                      username: _name,
                      onNext: (year) {
                        _birthYear = year;
                        _nextPage();
                      },
                    ),
                    LevelStep(
                      onFinish: (level) {
                        _englishLevel = level;
                        final profile = {
                          "id": widget.username,
                          "nickName": _name,
                          "birthYear": _birthYear,
                          "level": _englishLevel,
                        };
                        context.goNamed(AppRouteName.PROFILE_FINISH_ROUTE_NAME,extra: profile);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
