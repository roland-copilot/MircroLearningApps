import 'package:elearning/pages/register_page.dart';
import 'package:elearning/service/bloc/auth/auth_bloc.dart';
import 'package:elearning/util/contstant.dart';
import 'package:elearning/widget/textfield_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hasAcceptedTerms = false;

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email dan password wajib diisi.')),
      );
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email tidak valid.')),
      );
      return;
    }

    if (!hasAcceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Setujui ketentuan layanan terlebih dahulu.'),
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
      AuthEvent.login(email: email, password: password),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      height: height(context) * 0.075,
                      width: height(context) * 0.075,
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.menu_book_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'MicroRead',
                    style: GoogleFonts.domine(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: Text(
                      'Belajar lebih cerdas dengan microlearning & spaced repetition dari buku PDF Anda.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextfieldCustom(
                      title: 'Email',
                      obsecure: false,
                      hint: 'name@email.com',
                      controller: emailController,
                      icon: Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextfieldCustom(
                      title: 'Password',
                      obsecure: true,
                      hint: '***********',
                      controller: passwordController,
                      icon: Icons.lock_outline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          'Lupa Password ?',
                          style: GoogleFonts.poppins(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                hasAcceptedTerms = !hasAcceptedTerms;
                              });
                            },
                            child: Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green.shade700,
                                  width: 1.4,
                                ),
                                borderRadius: BorderRadius.circular(7),
                                color: hasAcceptedTerms
                                    ? Colors.green.shade700
                                    : Colors.transparent,
                              ),
                              child: hasAcceptedTerms
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  height: 1.7,
                                  color: const Color(0xFF6E7D87),
                                ),
                                children: [
                                  const TextSpan(text: 'Saya menyetujui '),
                                  TextSpan(
                                    text: 'Ketentuan Layanan',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      height: 1.7,
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: ' dan '),
                                  TextSpan(
                                    text: 'Kebijakan Privasi',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      height: 1.7,
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text:
                                        ' serta bersedia mematuhi aturan penggunaan aplikasi MicroRead.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: isLoading ? null : handleLogin,
                      child: Container(
                        height: 52,
                        width: width(context),
                        decoration: BoxDecoration(
                          color: isLoading
                              ? Colors.green.shade400
                              : Colors.green.shade700,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Masuk',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE5E1DB),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            'atau',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF7B8790),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE5E1DB),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 52,
                      width: width(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/500px-Google_%22G%22_logo.svg.png',
                            height: 20,
                          ),
                          const SizedBox(width: 14),
                          Text(
                            'Masuk dengan Google',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF232B31),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 52,
                      width: width(context),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232B31),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.apple,
                            color: Colors.white,
                            size: 22,
                          ),
                          const SizedBox(width: 14),
                          Text(
                            'Masuk dengan Apple',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Belum punya akun? ',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          letterSpacing: 0,
                          color: const Color(0xFF7B8790),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Daftar sekarang',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w700,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
