import 'package:elearning/service/bloc/auth/auth_bloc.dart';
import 'package:elearning/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStatsRow(),
            const SizedBox(height: 32),
            _buildMenuSection(
              title: 'UMUM',
              items: [
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: 'Informasi Akun',
                  subtitle: 'Kelola profil dan preferensi',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: 'Cara Menggunakan',
                  subtitle: 'Panduan penggunaan aplikasi',
                  isLast: true,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildMenuSection(
              title: 'TENTANG',
              items: [
                _buildMenuItem(
                  icon: Icons.info_outline,
                  title: 'Info Developer',
                  subtitle: 'Tim pengembang MicroRead',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.description_outlined,
                  title: 'Syarat & Ketentuan',
                  subtitle: 'Kebijakan penggunaan layanan',
                  isLast: true,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildMenuSection(
              title: 'BANTUAN',
              items: [
                _buildMenuItem(
                  icon: Icons.bug_report_outlined,
                  title: 'Laporkan Bug',
                  subtitle: 'Bantu kami meningkatkan aplikasi',
                  isLast: true,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 48),
            _buildLogoutButton(context),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF9F9F8),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.menu_book_sharp,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'MicroRead',
            style: GoogleFonts.domine(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF232B31),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              'JD',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Doe',
              style: GoogleFonts.domine(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'johndoe@email.com',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF7B8790),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard('5', 'Buku'),
        const SizedBox(width: 12),
        _buildStatCard('124', 'Flashcard'),
        const SizedBox(width: 12),
        _buildStatCard('7 hari', 'Streak'),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E1DB)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF7B8790),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF7B8790),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E1DB)),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isLast = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: Colors.green.shade700, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF232B31),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF7B8790),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFB5BBC0),
                  size: 20,
                ),
              ],
            ),
          ),
          if (!isLast)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: Color(0xFFE5E1DB), height: 1, thickness: 1),
            ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
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

        return Center(
          child: GestureDetector(
            onTap: isLoading
                ? null
                : () {
                    context.read<AuthBloc>().add(const AuthEvent.logout());
                  },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFD32F2F),
                      ),
                    ),
                  )
                else
                  const Icon(
                    Icons.logout_outlined,
                    color: Color(0xFFD32F2F),
                    size: 20,
                  ),
                const SizedBox(width: 8),
                Text(
                  isLoading ? 'Memproses...' : 'Keluar dari Akun',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFD32F2F),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
