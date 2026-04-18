import 'package:elearning/pages/home_page.dart';
import 'package:elearning/pages/library_page.dart';
import 'package:elearning/pages/profile_page.dart';
import 'package:elearning/pages/history_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static final Color _selectedColor = Colors.green.shade700;
  static const Color _unselectedColor = Color(0xFF7B8790);

  final List<Widget> _pages = [
    const HomePage(),
    const LibraryPage(),
    const HistoryPage(), // Using History as Jadwal equivalent for now
    const ProfilePage(),
  ];

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isSelected ? Colors.blue.shade600 : Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
          height: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? _selectedColor : _unselectedColor),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: isSelected ? _selectedColor : _unselectedColor,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F7),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE5E1DB), width: 1.0)),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.grid_view_rounded,
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.menu_book_rounded,
                label: 'Library',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.calendar_today_rounded,
                label: 'Jadwal',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.person_outline_rounded,
                label: 'Akun',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
