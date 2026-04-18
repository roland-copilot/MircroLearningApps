import 'package:elearning/service/firebase_service.dart';
import 'package:elearning/util/contstant.dart';
import 'package:elearning/widget/textfield_custom.dart';
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;
  bool _hasAcceptedTerms = false;

  void _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field wajib diisi.')));
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email tidak valid.')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password minimal 6 karakter.')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konfirmasi password tidak sama.')),
      );
      return;
    }

    if (!_hasAcceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Setujui ketentuan layanan terlebih dahulu.'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _firebaseService.signUp(name, email, password);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pendaftaran berhasil. Silakan masuk.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mendaftar: ${e.toString()}')),
        );
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
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
                'Buat Akun Baru',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 310,
                child: Text(
                  'Mulai belajar lebih terarah. Daftarkan akun Anda untuk menyimpan progres, dokumen, dan sesi belajar di MicroRead.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black45,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextfieldCustom(
                  title: 'Nama Lengkap',
                  obsecure: false,
                  hint: 'Masukkan nama lengkap',
                  controller: _nameController,
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextfieldCustom(
                  title: 'Email',
                  obsecure: false,
                  hint: 'name@email.com',
                  controller: _emailController,
                  icon: Icons.email_outlined,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextfieldCustom(
                  title: 'Password',
                  obsecure: true,
                  hint: 'Minimal 6 karakter',
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextfieldCustom(
                  title: 'Konfirmasi Password',
                  obsecure: true,
                  hint: 'Ulangi password',
                  controller: _confirmPasswordController,
                  icon: Icons.lock_clock_outlined,
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
                            _hasAcceptedTerms = !_hasAcceptedTerms;
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
                            color: _hasAcceptedTerms
                                ? Colors.green.shade700
                                : Colors.transparent,
                          ),
                          child: _hasAcceptedTerms
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
                child: _isLoading
                    ? SizedBox(
                        height: 52,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.green.shade700,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: _register,
                        child: Container(
                          height: 52,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Text(
                              'Buat Akun',
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
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun? ',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      letterSpacing: 0,
                      color: const Color(0xFF7B8790),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Masuk sekarang',
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
  }
}
