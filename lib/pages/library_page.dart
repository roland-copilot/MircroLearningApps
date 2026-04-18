import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

import 'session_flashcard_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  bool _isUploadMode = false;
  final List<PlatformFile> _selectedFiles = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      if (!mounted) return;
      setState(() {
        _selectedFiles.addAll(result.files);
      });
    }
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      _selectedFiles.remove(file);
    });
  }

  void _processDocuments() {
    // In a real app, you would handle processing/uploading here
    setState(() {
      _selectedFiles.clear();
      _isUploadMode = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Dokumen berhasil diproses')));
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
              'Perpustakaan',
              style: GoogleFonts.domine(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF232B31),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Koleksi buku dan dokumen Anda.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF7B8790),
              ),
            ),
            const SizedBox(height: 24),
            _buildSearchRow(),
            if (_isUploadMode) ...[
              const SizedBox(height: 16),
              _buildUploadSection(),
              _buildSelectedFilesSection(),
            ],
            const SizedBox(height: 24),
            _buildBookList(),
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

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E1DB)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                const Icon(Icons.search, color: Color(0xFF7B8790), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF232B31),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari buku...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF7B8790),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            setState(() {
              _isUploadMode = !_isUploadMode;
              if (!_isUploadMode) {
                _selectedFiles.clear();
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: _isUploadMode ? Colors.green.shade700 : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade700, width: 1.5),
            ),
            child: Icon(
              Icons.add,
              color: _isUploadMode ? Colors.white : Colors.green.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    final bool hasFiles = _selectedFiles.isNotEmpty;
    return GestureDetector(
      onTap: _pickFiles,
      child: CustomPaint(
        painter: _DashedRectPainter(
          color: hasFiles ? const Color(0xFFE5E1DB) : Colors.green.shade400,
          strokeWidth: 1.5,
          borderRadius: 16.0,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            color: hasFiles
                ? Colors.transparent
                : Colors.green.shade50.withAlpha(128),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.upload_outlined,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Ketuk untuk memilih file PDF',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF232B31),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Maks 20MB per file',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF7B8790),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedFilesSection() {
    if (_selectedFiles.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          '${_selectedFiles.length} file siap diproses',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF7B8790),
          ),
        ),
        const SizedBox(height: 8),
        ..._selectedFiles.map((file) => _buildSelectedFileItem(file)).toList(),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _processDocuments,
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.upload_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Proses Dokumen',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedFileItem(PlatformFile file) {
    String fileSizeStr = '${(file.size / (1024 * 1024)).toStringAsFixed(1)} MB';
    if (file.size < 1024 * 1024) {
      fileSizeStr = '${(file.size / 1024).toStringAsFixed(1)} KB';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E1DB)),
      ),
      child: Row(
        children: [
          Icon(Icons.description_outlined, color: Colors.green.shade700),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF232B31),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  fileSizeStr,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF7B8790),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _removeFile(file),
            child: const Icon(Icons.close, color: Color(0xFF7B8790), size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList() {
    return Column(
      children: [
        _buildLibraryItem(
          title: 'Psikologi Kognitif',
          author: 'Robert L. Solso',
          progressLabel: '28/42 bagian',
          progressPercent: '68%',
          progressValue: 0.68,
          timeAgo: '2 jam lalu',
        ),
        const SizedBox(height: 12),
        _buildLibraryItem(
          title: 'Metode Penelitian Kuantitatif',
          author: 'Sugiyono',
          progressLabel: '13/38 bagian',
          progressPercent: '34%',
          progressValue: 0.34,
          timeAgo: 'Kemarin',
        ),
        const SizedBox(height: 12),
        _buildLibraryItem(
          title: 'Statistik Terapan',
          author: 'Riduwan',
          progressLabel: '4/30 bagian',
          progressPercent: '12%',
          progressValue: 0.12,
          timeAgo: '3 hari lalu',
        ),
        const SizedBox(height: 12),
        _buildLibraryItem(
          title: 'Filsafat Ilmu',
          author: 'Jujun S. Suriasumantri',
          progressLabel: '25/25 bagian',
          progressPercent: '100%',
          progressValue: 1.0,
          timeAgo: '1 minggu lalu',
        ),
      ],
    );
  }

  Widget _buildLibraryItem({
    required String title,
    required String author,
    required String progressLabel,
    required String progressPercent,
    required double progressValue,
    required String timeAgo,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SessionFlashcardPage(title: title),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E1DB)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 64,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.description_outlined,
                color: Colors.green.shade700,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.domine(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF232B31),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.delete_outline,
                        color: const Color(0xFF7B8790),
                        size: 20,
                      ),
                    ],
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.green.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 11,
                        color: Color(0xFFA0AAB0),
                      ),
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
      ),
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double borderRadius;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.borderRadius = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    Path dashPath = Path();
    final double dashWidth = 5.0;
    final double dashSpace = 5.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
