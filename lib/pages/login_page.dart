import 'package:elearning/pages/register_page.dart';
import 'package:elearning/service/firebase_service.dart';
import 'package:elearning/util/contstant.dart';
import 'package:elearning/widget/auth_button.dart';
import 'package:elearning/widget/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseService service = FirebaseService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: height(context) * 0.02),
            Text(
              textAlign: TextAlign.center,
              'Sign in to continue your learning journey',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white60),
            ),
            SizedBox(height: height(context) * 0.1),
            TextfieldCustom(
              obsecure: false,
              hint: 'name@example.com',
              controller: emailController,
            ),
            SizedBox(height: height(context) * 0.02),
            TextfieldCustom(
              obsecure: true,
              hint: 'Enter your password',
              controller: passwordController,
            ),
            SizedBox(height: height(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot Password ?',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
            SizedBox(height: height(context) * 0.02),
            AuthButton(
              buttonName: 'Log In',
              onTap: () {
                service.signIn(emailController.text, passwordController.text);
              },
            ),
            SizedBox(height: height(context) * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 1, width: 100, color: Colors.white24),
                Text(
                  "Or Continue With",
                  style: GoogleFonts.poppins(color: Colors.white30),
                ),
                Container(height: 1, width: 100, color: Colors.white24),
              ],
            ),
            SizedBox(height: height(context) * 0.04),
            Container(
              height: height(context) * 0.07,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10.withAlpha(20),
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/500px-Google_%22G%22_logo.svg.png",
                      height: 20,
                    ),
                    SizedBox(width: width(context) * 0.02),
                    Text(
                      "Sign in with Google",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height(context) * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New Here?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white54,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "Create an Account",
                    style: GoogleFonts.poppins(
                      color: Colors.blue.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
