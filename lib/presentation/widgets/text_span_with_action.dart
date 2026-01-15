import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSpanWithAction extends StatelessWidget {
  final String text1;
  final String text2;
  final Function? onAction;

  const TextSpanWithAction({
    super.key,
    required this.text1,
    required this.text2,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w800,
          color: const Color(0xFF777777),
          fontSize: 14,
        ),
        children: <TextSpan>[
          TextSpan(text: text1),
          TextSpan(
            text: text2,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF3393FF),
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onAction?.call();
              },
          ),
        ],
      ),
    );
  }
}
