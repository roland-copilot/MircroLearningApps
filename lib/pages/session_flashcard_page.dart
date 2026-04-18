import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SessionFlashcardPage extends StatefulWidget {
  final String title;

  const SessionFlashcardPage({super.key, required this.title});

  @override
  State<SessionFlashcardPage> createState() => _SessionFlashcardPageState();
}

class _SessionFlashcardPageState extends State<SessionFlashcardPage> {
  bool _showAnswer = false;

  void _toggleCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sesi Belajar',
              style: GoogleFonts.domine(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${widget.title} · Kartu 1/4',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF7B8790),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.25, // 1/4
                minHeight: 6,
                backgroundColor: const Color(0xFFE5E1DB),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _toggleCard,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
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
                      _showAnswer ? 'JAWABAN' : 'PERTANYAAN',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF7B8790),
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      _showAnswer 
                        ? 'Teori yang menjelaskan bahwa kapasitas memori kerja manusia sangat terbatas sehingga materi pembelajaran perlu dirancang sedemikian rupa agar tidak memberikan beban kognitif yang berlebihan.' 
                        : 'Apa yang dimaksud dengan cognitive load theory dalam konteks pembelajaran?',
                      style: GoogleFonts.domine(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF232B31),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 64),
                    Row(
                      children: [
                        const Icon(Icons.loop, size: 16, color: Color(0xFF7B8790)),
                        const SizedBox(width: 8),
                        Text(
                          'Ketuk untuk balik',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF7B8790),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(Icons.chevron_left, size: 18, color: Color(0xFF7B8790)),
                      const SizedBox(width: 4),
                      Text(
                        'Sebelumnya',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7B8790),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Selanjutnya',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, size: 18, color: Colors.white),
                      ],
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9F9F8),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false, // Don't show default back button
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
