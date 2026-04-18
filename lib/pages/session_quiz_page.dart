import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionQuizPage extends StatefulWidget {
  final String title;

  const SessionQuizPage({super.key, required this.title});

  @override
  State<SessionQuizPage> createState() => _SessionQuizPageState();
}

class _SessionQuizPageState extends State<SessionQuizPage> {
  int? _selectedOptionIndex;

  final List<String> _options = [
    'Teori tentang kapasitas memori kerja yang terbatas',
    'Teori tentang kecerdasan emosional',
    'Teori tentang motivasi belajar',
    'Teori tentang perkembangan otak',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quiz',
              style: GoogleFonts.domine(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${widget.title} · Soal 1/5',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF7B8790),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.2, // 1/5
                minHeight: 6,
                backgroundColor: const Color(0xFFE5E1DB),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E1DB)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apa yang dimaksud dengan cognitive load theory?',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF232B31),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ..._options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final text = entry.value;
                    return _buildOptionItem(index, text);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                if (_selectedOptionIndex != null) {
                  // Process answer
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Jawaban disimpan')),
                  );
                }
              },
              child: Container(
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: _selectedOptionIndex != null 
                      ? Colors.green.shade700 
                      : const Color(0xFF81B29A).withOpacity(0.8), // Faded green
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Jawab',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(int index, String text) {
    bool isSelected = _selectedOptionIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOptionIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green.shade700 : const Color(0xFFE5E1DB),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: Colors.green.shade700,
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: const Color(0xFF232B31),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9F9F8),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false, // Custom back via icon
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.menu_book_sharp, color: Colors.white, size: 18),
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
}
