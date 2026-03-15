import 'package:elearning/util/contstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldCustom extends StatelessWidget {
  final bool obsecure;
  final String hint;
  final TextEditingController controller;
  const TextfieldCustom({
    super.key,
    required this.obsecure,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context) * 0.07,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: TextField(
            obscureText: obsecure,
            controller: controller,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
