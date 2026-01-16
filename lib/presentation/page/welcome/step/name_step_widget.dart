import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_2/common/colors.dart';
import 'package:lab_2/presentation/widgets/custom_elevated_button.dart';
import 'package:lab_2/presentation/widgets/custom_normal_textfield.dart';
import 'package:lab_2/utils/validators.dart';


class NameStep extends StatefulWidget {
  final Function(String) onNext;
  final String? name;

  const NameStep({super.key, required this.onNext, this.name});

  @override
  State<NameStep> createState() => _NameStepState();
}

class _NameStepState extends State<NameStep> {
  final TextEditingController _controller = TextEditingController();
  bool _isValidated = false;
  final FocusNode _nameFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    _controller.text = widget.name ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _nameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        Row(
          spacing: 10,
          children: [
            SizedBox(
              width: 148,
              height: 168,
              child: Image.asset("assets/images/monkey_fill_info_image.png"),
            ),
            Text(
              "Tên của bé là?",
              style: GoogleFonts.nunito(
                color: ColorLight.neutralEel,
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ],
        ),
        CustomNormalTextField(
          hint: "Tên",
          controller: _controller,
          onValidate: (isValidated) {
            setState(() {
              _isValidated = isValidated;
            });
          },
          validator: validatorName,
          textInputAction: TextInputAction.done,
          autoValid: true,
          focusNode: _nameFocus,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CustomElevatedButton(
            text: "Tiếp tục",
            onClick: _isValidated
                ? () {
              if (_nameFocus.hasFocus) {
                FocusScope.of(context).unfocus();
              } else {
                widget.onNext.call(_controller.text);
              }
            }
                : null,
          ),
        ),
      ],
    );
  }
}