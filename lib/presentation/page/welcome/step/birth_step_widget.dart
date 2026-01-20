import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/app_string.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/generated/assets.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';

class BirthStep extends StatefulWidget {
  final Function(int) onNext;
  final String username;

  const BirthStep({super.key, required this.onNext, required this.username});

  @override
  State<BirthStep> createState() => _BirthStepState();
}

class _BirthStepState extends State<BirthStep> {
  int? _selectedYear;
  final List<int> _years = [
    2021,
    2020,
    2019,
    2018,
    2017,
    2016,
    2015,
    2014,
    2013,
    2012,
    2011,
    2010,
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
                AppString.birthYear(widget.username),
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
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: _years.map((year) {
            bool isSelected = _selectedYear == year;
            return GestureDetector(
              onTap: () => setState(() => _selectedYear = year),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorLight.blueLight.withOpacity(0.1)
                      : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? ColorLight.blueLight
                        : ColorLight.neutralSwain,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$year",
                  style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: isSelected
                        ? ColorLight.blueLight
                        : ColorLight.neutralWolf,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: () => setState(() => _selectedYear = 2009),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedYear == 2009
                    ? ColorLight.blueLight
                    : ColorLight.neutralSwain,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              AppString.bornBefore2010,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: _selectedYear == 2009
                    ? ColorLight.blueLight
                    : ColorLight.neutralWolf,
              ),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CustomElevatedButton(
            text: AppString.continu,
            onClick: _selectedYear != null
                ? () {
              FocusScope.of(context).unfocus();
              widget.onNext.call(_selectedYear ?? 2009);
            }
                : null,
          ),
        ),
      ],
    );
  }
}