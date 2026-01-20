import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lab_2/common/app_string.dart';
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
    AppString.level0Des,
    AppString.level1Des,
    AppString.level2Des,
    AppString.level3Des,
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
                AppString.presentLevel,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: ColorLight.neutralEel,
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
                    SvgPicture.asset(AppString.getImageLevel(index)),
                    Expanded(
                      flex: 1,
                      child: Text(
                        _levelList[index],
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
            text: AppString.continu,
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