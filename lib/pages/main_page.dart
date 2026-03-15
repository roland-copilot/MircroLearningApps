import 'package:elearning/pages/home_page.dart';
import 'package:elearning/pages/library_page.dart';
import 'package:elearning/pages/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const Color _selectedColor = Colors.blue;
  static const Color _unselectedColor = Colors.grey;

  final List<Widget> _pages = [
    const HomePage(),
    const LibraryPage(),
    const _CenterTextPage(title: 'Create'),
    const _CenterTextPage(title: 'History'),
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
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: SizedBox(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? _selectedColor : _unselectedColor),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? _selectedColor : _unselectedColor,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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
      body: _pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        backgroundColor: _selectedColor,
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Home'),
              _buildNavItem(
                index: 1,
                icon: Icons.menu_book_outlined,
                label: 'Library',
              ),
              const SizedBox(width: 56),
              _buildNavItem(index: 3, icon: Icons.history, label: 'History'),
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterTextPage extends StatelessWidget {
  const _CenterTextPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
