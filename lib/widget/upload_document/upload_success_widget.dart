import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadSuccessWidget extends StatelessWidget {
  final List<PlatformFile> selectedFiles;
  final VoidCallback onBackToHome;
  final VoidCallback onShare;
  final VoidCallback onStartStudying;

  const UploadSuccessWidget({
    super.key,
    required this.selectedFiles,
    required this.onBackToHome,
    required this.onShare,
    required this.onStartStudying,
  });

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('success'),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.auto_awesome, color: Color(0xFF4C4DFF), size: 60),
          const SizedBox(height: 24),
          Text(
            'All Set!',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your study materials are ready for\nreview.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF161622),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF212130)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${selectedFiles.length} Documents\nProcessed',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF133221),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '100%\nComplete',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF21E070),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (selectedFiles.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2C),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2A2A3A)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B1A28),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.picture_as_pdf, color: Color(0xFFFF5252), size: 16),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedFiles.first.name,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${_formatBytes(selectedFiles.first.size)} • Just now',
                                style: GoogleFonts.poppins(
                                  color: Colors.white54,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF21E070),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check, color: Colors.white, size: 12),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onStartStudying,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A6BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Start Studying',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: onShare,
            icon: const Icon(Icons.ios_share, color: Colors.white54, size: 18),
            label: Text(
              'Share Study Set',
              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 14),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onBackToHome,
            child: Text(
              'Back to Home',
              style: GoogleFonts.poppins(color: Colors.white54, fontSize: 13),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
