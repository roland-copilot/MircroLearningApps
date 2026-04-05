import 'package:elearning/util/contstant.dart';
import 'package:elearning/widget/auth_button.dart';
import 'package:elearning/widget/textfield_custom.dart';
import 'package:elearning/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  void _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _firebaseService.signUp(name, email, password);
      if (mounted) {
        Navigator.pop(context); // Go back to login on success
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registration successful!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
                    controller: _nameController,
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
                    controller: _emailController,
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
                    controller: _passwordController,
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
                    controller: _confirmPasswordController,
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
              child: _isLoading 
                ? const CircularProgressIndicator()
                : GestureDetector(
                    onTap: _register,
                    child: AuthButton(buttonName: 'Create an account'),
                  ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
