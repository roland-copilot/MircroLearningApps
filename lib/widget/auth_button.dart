import 'package:elearning/util/contstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  final String buttonName;
  final void Function()? onTap;
  const AuthButton({super.key, required this.buttonName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height(context) * 0.07,
        width: double.infinity,

        decoration: BoxDecoration(
          color: Colors.blue.shade800,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
