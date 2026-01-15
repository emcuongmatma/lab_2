import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/utils/custom_elevated_button.dart';

class ProfileFinishScreen extends StatefulWidget {
  const ProfileFinishScreen({super.key});

  @override
  State<ProfileFinishScreen> createState() => _ProfileFinishScreenState();
}

class _ProfileFinishScreenState extends State<ProfileFinishScreen> {
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
                "Monkey đang cập nhật dữ liệu học tập của bé",
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: ColorLight.neutralEel,
                ),
              ),
              const SizedBox(height: 108),
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
                      style: GoogleFonts.nunito(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: ColorLight.blueLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 132),
              Row(
                spacing: 12,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: ColorLight.blueLight,
                  ),
                  Expanded(
                    child: Text(
                      "Cập nhật thông tin tài khoản sử dụng",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
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
                      "Cập nhật hồ sơ học tập",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
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
                      "Cập nhật thông tin gói học",
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: ColorLight.blueLight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
