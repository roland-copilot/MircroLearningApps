import 'package:elearning/util/contstant.dart';
import 'package:elearning/widget/auth_button.dart';
import 'package:elearning/widget/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                'Start Learning Smarter',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: MediaQuery.sizeOf(context).width * 0.9,
              child: Text(
                maxLines: 3,
                textAlign: TextAlign.center,
                'Turn your docs into visuals instantly with AI. Create your account today.',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(
              height: height(context) * 0.14,
              width: width(context) * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextfieldCustom(
                    obsecure: false,
                    hint: 'John Doe',
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.14,
              width: width(context) * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextfieldCustom(
                    obsecure: false,
                    hint: 'johndoe@example.com',
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.14,
              width: width(context) * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Password',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextfieldCustom(
                    obsecure: true,
                    hint: '************',
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.12,
              width: width(context) * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Password',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextfieldCustom(
                    obsecure: true,
                    hint: '************',
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.5,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'I agree to the Terms of service and Privacy Policy',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: AuthButton(buttonName: 'Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
