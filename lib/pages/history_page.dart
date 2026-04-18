import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'session_flashcard_page.dart';
import 'session_quiz_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<String> _allDays = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  
  // Track selected active days and their time sessions
  final Map<String, List<String>> _schedule = {
    'Sen': [],
    'Sel': ['08.00'],
    'Rab': ['08.00'],
    'Kam': [],
    'Jum': ['08.00', '14.00'],
  };

  void _toggleDay(String day) {
    setState(() {
      if (_schedule.containsKey(day)) {
        _schedule.remove(day);
      } else {
        _schedule[day] = [];
      }
    });
  }

  Future<void> _addTime(String day) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade700,
              onSurface: const Color(0xFF232B31),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final String formattedTime = 
          '${picked.hour.toString().padLeft(2, '0')}.${picked.minute.toString().padLeft(2, '0')}';
      setState(() {
        _schedule[day]!.add(formattedTime);
        // Sort times chronologically
        _schedule[day]!.sort();
      });
    }
  }

  void _removeTime(String day, int timeIndex) {
    setState(() {
      _schedule[day]!.removeAt(timeIndex);
    });
  }

  Future<void> _editTime(String day, int timeIndex) async {
    final String currentTimeStr = _schedule[day]![timeIndex];
    final parts = currentTimeStr.split('.');
    final int hour = int.parse(parts[0]);
    final int min = int.parse(parts[1]);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: min),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade700,
              onSurface: const Color(0xFF232B31),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final String formattedTime = 
          '${picked.hour.toString().padLeft(2, '0')}.${picked.minute.toString().padLeft(2, '0')}';
      setState(() {
        _schedule[day]![timeIndex] = formattedTime;
        _schedule[day]!.sort();
      });
    }
  }

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
            Text(
              'Rencana Belajar',
              style: GoogleFonts.domine(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Atur target dan jadwal belajar harian Anda.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF7B8790),
              ),
            ),
            const SizedBox(height: 24),
            _buildTargetBelajarCard(),
            const SizedBox(height: 32),
            Text(
              'Jadwal Minggu Ini',
              style: GoogleFonts.domine(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(height: 16),
            _buildJadwalList(),
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

  Widget _buildTargetBelajarCard() {
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
            children: [
              Icon(Icons.track_changes_outlined, color: Colors.green.shade700, size: 22),
              const SizedBox(width: 12),
              Text(
                'Target Belajar',
                style: GoogleFonts.domine(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF232B31),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF232B31)),
              const SizedBox(width: 8),
              Text(
                'Hari belajar',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF232B31),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _allDays.map((day) {
                final isSelected = _schedule.containsKey(day);
                return _buildDayChip(day, isSelected);
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.access_time_outlined, size: 14, color: Color(0xFF232B31)),
              const SizedBox(width: 8),
              Text(
                'Jam sesi per hari',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF232B31),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Dynamically build active days for 'Jam sesi per hari'
          ..._allDays.where((day) => _schedule.containsKey(day)).map((day) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildSesiHariItem(day, _schedule[day]!),
            );
          }),
          if (_schedule.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Pilih hari belajar terlebih dahulu.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF7B8790),
                ),
              ),
            ),
          const SizedBox(height: 8),
          Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Susun Jadwal Otomatis',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () => _toggleDay(label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade700 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green.shade700 : const Color(0xFFE5E1DB),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.white : const Color(0xFF7B8790),
          ),
        ),
      ),
    );
  }

  Widget _buildSesiHariItem(String day, List<String> times) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF232B31),
              ),
            ),
            GestureDetector(
              onTap: () => _addTime(day),
              child: Row(
                children: [
                  Icon(Icons.add, size: 14, color: Colors.green.shade700),
                  const SizedBox(width: 4),
                  Text(
                    'Tambah jam',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (times.isEmpty)
          Text(
            'Belum ada jam',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: const Color(0xFF7B8790),
            ),
          )
        else
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: times.asMap().entries.map((entry) {
              final int index = entry.key;
              final String time = entry.value;
              return _buildTimeChip(day, index, time);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildTimeChip(String day, int index, String time) {
    return GestureDetector(
      onTap: () => _editTime(day, index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F1F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.access_time, size: 14, color: Color(0xFF232B31)),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => _removeTime(day, index),
              child: const Icon(Icons.close, size: 14, color: Color(0xFF7B8790)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJadwalList() {
    return Column(
      children: [
        _buildDayGroup('Senin', [
          _buildTaskItem('Psikologi Kognitif — Bab 3', 'Baca', '08:00', '15 mnt'),
          _buildTaskItem('Quiz: Psikologi Bab 1-2', 'Quiz', '14:00', '10 mnt'),
          _buildTaskItem('Flashcard: Bab 1-2', 'Review', '20:00', '10 mnt', isActive: true),
        ]),
        const SizedBox(height: 20),
        _buildDayGroup('Selasa', [
          _buildTaskItem('Metode Penelitian — Bab 5', 'Baca', '08:00', '15 mnt'),
          _buildTaskItem('Flashcard: Psikologi', 'Review', '20:00', '10 mnt'),
        ]),
        const SizedBox(height: 20),
        _buildDayGroup('Rabu', [
          _buildTaskItem('Statistik Terapan — Bab 2', 'Baca', '08:00', '15 mnt'),
          _buildTaskItem('Quiz: Metode Penelitian Bab 5', 'Quiz', '14:00', '10 mnt', isActive: true),
          _buildTaskItem('Flashcard: Metode Penelitian', 'Review', '20:00', '10 mnt'),
        ]),
        const SizedBox(height: 20),
        _buildDayGroup('Kamis', [
          _buildTaskItem('Psikologi Kognitif — Bab 4', 'Baca', '08:00', '15 mnt'),
          _buildTaskItem('Flashcard: Statistik', 'Review', '20:00', '10 mnt'),
        ]),
        const SizedBox(height: 20),
        _buildDayGroup('Jumat', [
          _buildTaskItem('Metode Penelitian — Bab 6', 'Baca', '08:00', '15 mnt'),
          _buildTaskItem('Quiz: Semua Materi Minggu Ini', 'Quiz', '14:00', '15 mnt'),
          _buildTaskItem('Flashcard: Semua Buku', 'Review', '20:00', '10 mnt'),
        ]),
      ],
    );
  }

  Widget _buildDayGroup(String day, List<Widget> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: GoogleFonts.domine(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF232B31),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E1DB)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: tasks,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(String title, String type, String time, String duration, {bool isActive = false}) {
    // Determine badge style
    Color badgeBgColor;
    Color badgeTextColor;
    Border? badgeBorder;

    if (type == 'Baca') {
      badgeBgColor = Colors.green.shade700;
      badgeTextColor = Colors.white;
    } else if (type == 'Quiz') {
      badgeBgColor = Colors.white;
      badgeTextColor = Colors.green.shade700;
      badgeBorder = Border.all(color: Colors.green.shade700, width: 1);
    } else { // Review
      badgeBgColor = const Color(0xFFF0F1F2);
      badgeTextColor = const Color(0xFF6E7D87);
    }

    Widget content = GestureDetector(
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.radio_button_unchecked, color: Color(0xFFB5BBC0), size: 22),
            const SizedBox(width: 14),
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
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: badgeBgColor,
                          borderRadius: BorderRadius.circular(12),
                          border: badgeBorder,
                        ),
                        child: Text(
                          type,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: badgeTextColor,
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
            const Icon(Icons.chevron_right, color: Color(0xFFB5BBC0), size: 20),
          ],
        ),
      ),
    );

    if (isActive) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9FA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: content,
        ),
      );
    }

    return content;
  }
}
