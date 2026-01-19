import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';


class LevelStep extends StatefulWidget {
  final Function(int) onFinish;

  const LevelStep({super.key, required this.onFinish});

  @override
  State<LevelStep> createState() => _LevelStepState();
}

class _LevelStepState extends State<LevelStep> {

  int? _selectedLevel;
  final _levelList = [
    "Bé chưa biết gì về tiếng Anh",
    "Bé nhận biết được vài từ đơn giản",
    "Bé hiểu được câu ngắn, đơn giản",
    "Bé đọc hiểu đoạn văn ngắn",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            SizedBox(width: 148, height: 168, child: Image.asset(Assets.imagesMonkeyFillInfoImage)),
            Flexible(
              child: Text(
                "Khả năng tiếng Anh hiện tại của bé?",
                style: GoogleFonts.nunito(
                  color: ColorLight.neutralEel,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ListView.builder(
          itemCount: _levelList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            bool isSelected = _selectedLevel == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedLevel = index),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorLight.blueLight.withOpacity(0.05)
                      : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? ColorLight.blueLight
                        : ColorLight.neutralSwain,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  spacing: 24,
                  children: [
                    SvgPicture.asset("assets/icons/ic_level_$index.svg"),
                    Expanded(
                      flex: 1,
                      child: Text(
                        _levelList[index],
                        maxLines: 2,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: _selectedLevel == index
                              ? ColorLight.blueLight
                              : ColorLight.neutralEel,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CustomElevatedButton(
            text: "Tiếp tục",
            onClick: _selectedLevel != null
                ? () {
              widget.onFinish(_selectedLevel ?? -1);
            }
                : null,
          ),
        ),
      ],
    );
  }
}