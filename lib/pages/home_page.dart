import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'session_flashcard_page.dart';
import 'session_quiz_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8), // Match the off-white background
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeSection(),
            const SizedBox(height: 24),
            _buildSectionTitle('Jadwal Hari Ini'),
            const SizedBox(height: 16),
            _buildJadwalList(),
            const SizedBox(height: 20),
            Center(
              child: Text(
                'Tap sesi untuk memulai belajar',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF7B8790),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildStatsGrid(),
            const SizedBox(height: 32),
            _buildAktivitasSection(),
            const SizedBox(height: 32),
            _buildFlashcardSection(),
            const SizedBox(height: 32),
            _buildBukuTerakhirSection(),
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
            child: const Icon(Icons.menu_book_sharp, color: Colors.white, size: 18),
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

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Datang 👋',
          style: GoogleFonts.domine(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF232B31),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Lanjutkan sesi belajar Anda hari ini.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF7B8790),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.domine(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF232B31),
      ),
    );
  }

  Widget _buildJadwalList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E1DB)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          _buildJadwalItem(
            title: 'Psikologi Kognitif — Bab 3',
            type: 'Baca',
            time: '08:00',
            duration: '15 mnt',
            isCompleted: true,
          ),
          _buildJadwalItem(
            title: 'Flashcard: Metode Penelitian',
            type: 'Review',
            time: '12:00',
            duration: '10 mnt',
            isCompleted: true,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E1DB)),
              ),
              child: _buildJadwalItem(
                title: 'Statistik Terapan — Bab 5',
                type: 'Baca',
                time: '18:00',
                duration: '15 mnt',
                isCompleted: false,
                isActive: true,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),
          _buildJadwalItem(
            title: 'Flashcard: Psikologi Kognitif',
            type: 'Quiz', // Example changing one to Quiz for variation
            time: '21:00',
            duration: '10 mnt',
            isCompleted: false,
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalItem({
    required String title,
    required String type,
    required String time,
    required String duration,
    bool isCompleted = false,
    bool isActive = false,
    EdgeInsetsGeometry? padding,
  }) {
    return GestureDetector(
      onTap: () {
        if (type == 'Quiz') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionQuizPage(title: title),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionFlashcardPage(title: title),
            ),
          );
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              isCompleted ? Icons.check_circle_outline : Icons.circle_outlined,
              color: isCompleted ? Colors.green.shade700 : (isActive ? Colors.green.shade700 : const Color(0xFFB5BBC0)),
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isCompleted ? const Color(0xFFB5BBC0) : const Color(0xFF232B31),
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: type == 'Baca' ? Colors.green.shade700 : (type == 'Quiz' ? Colors.white : const Color(0xFFF0F1F2)),
                          borderRadius: BorderRadius.circular(12),
                          border: type == 'Quiz' ? Border.all(color: Colors.green.shade700, width: 1) : null,
                        ),
                        child: Text(
                          type,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: type == 'Baca' ? Colors.white : (type == 'Quiz' ? Colors.green.shade700 : const Color(0xFF6E7D87)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$time  ·  ',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFFA0AAB0),
                        ),
                      ),
                      const Icon(Icons.access_time, size: 12, color: Color(0xFFA0AAB0)),
                      const SizedBox(width: 4),
                      Text(
                        duration,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFFA0AAB0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (isActive || (!isCompleted && !isActive))
              Icon(Icons.chevron_right, color: const Color(0xFFB5BBC0), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      children: [
        _buildStatCard(
          icon: Icons.menu_book_rounded,
          value: '3',
          label: 'Buku Aktif',
          subLabel: '2 dalam progres',
        ),
        _buildStatCard(
          icon: Icons.psychology_outlined,
          value: '24',
          label: 'Flashcard',
          subLabel: '12 jatuh tempo',
        ),
        _buildStatCard(
          icon: Icons.local_fire_department_outlined,
          value: '7 hari',
          label: 'Streak',
          subLabel: 'Pertahankan!',
        ),
        _buildStatCard(
          icon: Icons.track_changes_outlined,
          value: '82%',
          label: 'Retensi',
          subLabel: '+3% minggu ini',
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required String subLabel,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E1DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green.shade700, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.domine(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF232B31),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6E7D87),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subLabel,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: const Color(0xFFA0AAB0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAktivitasSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E1DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aktivitas Minggu Ini',
                style: GoogleFonts.domine(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF232B31),
                ),
              ),
              Text(
                'Total: 193 menit',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF7B8790),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBarChartItem('Sen', 0.6),
                _buildBarChartItem('Sel', 0.4),
                _buildBarChartItem('Rab', 0.9),
                _buildBarChartItem('Kam', 0.5),
                _buildBarChartItem('Jum', 0.8),
                _buildBarChartItem('Sab', 0.7),
                _buildBarChartItem('Min', 0.3),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xFFE5E1DB), height: 1),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tren Retensi',
                style: GoogleFonts.domine(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF232B31),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.green.shade700, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '+3%',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 80,
            child: CustomPaint(
              size: const Size(double.infinity, 80),
              painter: _LineChartPainter(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 20),
              Text('Mg 2', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFA0AAB0))),
              Text('Mg 3', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFA0AAB0))),
              Text('Mg 4', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFA0AAB0))),
              Text('Mg 5', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFA0AAB0))),
              Text('Mg 6', style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFFA0AAB0))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChartItem(String label, double heightFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 16,
          height: 90 * heightFactor,
          decoration: BoxDecoration(
            color: Colors.green.shade700,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF7B8790),
          ),
        ),
      ],
    );
  }

  Widget _buildFlashcardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Flashcard Cepat'),
        const SizedBox(height: 16),
        Container(
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
                'PERTANYAAN',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: const Color(0xFF7B8790),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Apa yang dimaksud dengan cognitive load theory dalam konteks pembelajaran?',
                style: GoogleFonts.domine(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF232B31),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  const Icon(Icons.refresh, size: 14, color: Color(0xFF7B8790)),
                  const SizedBox(width: 6),
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
      ],
    );
  }

  Widget _buildBukuTerakhirSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Buku Terakhir Dibaca'),
        const SizedBox(height: 16),
        _buildBookItem(
          title: 'Psikologi Kognitif',
          author: 'Robert L. Solso',
          progressLabel: '28/42 bagian',
          progressPercent: '68%',
          progressValue: 0.68,
          timeAgo: '2 jam lalu',
        ),
        const SizedBox(height: 12),
        _buildBookItem(
          title: 'Metode Penelitian Kuantitatif',
          author: 'Sugiyono',
          progressLabel: '13/38 bagian',
          progressPercent: '34%',
          progressValue: 0.34,
          timeAgo: 'Kemarin',
        ),
        const SizedBox(height: 12),
        _buildBookItem(
          title: 'Statistik Terapan',
          author: 'Riduwan',
          progressLabel: '4/30 bagian',
          progressPercent: '12%',
          progressValue: 0.12,
          timeAgo: '3 hari lalu',
        ),
      ],
    );
  }

  Widget _buildBookItem({
    required String title,
    required String author,
    required String progressLabel,
    required String progressPercent,
    required double progressValue,
    required String timeAgo,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E1DB)),
      ),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.description_outlined, color: Colors.green.shade700),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.domine(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF232B31),
                  ),
                ),
                Text(
                  author,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF7B8790),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      progressLabel,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF7B8790),
                      ),
                    ),
                    Text(
                      progressPercent,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF7B8790),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressValue,
                    minHeight: 4,
                    backgroundColor: const Color(0xFFE5E1DB),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 11, color: Color(0xFFA0AAB0)),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFFA0AAB0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = Colors.green.shade700
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    
    // Create a smooth curve matching the screenshot
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.6, size.width * 0.4, size.height * 0.65);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.7, size.width * 0.7, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.2, size.width, size.height * 0.15);

    // Draw grid lightly if needed, but screenshot doesn't have it.

    canvas.drawPath(path, paintLine);

    // Add a light gradient below the line
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.green.shade700.withAlpha(40),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
      
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
