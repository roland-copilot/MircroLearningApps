import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadSelectionWidget extends StatelessWidget {
  final List<PlatformFile> selectedFiles;
  final VoidCallback onPickFiles;
  final void Function(PlatformFile) onRemoveFile;
  final VoidCallback onStartProcess;

  const UploadSelectionWidget({
    super.key,
    required this.selectedFiles,
    required this.onPickFiles,
    required this.onRemoveFile,
    required this.onStartProcess,
  });

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('selection'),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onPickFiles,
            child: Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF131320),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF29294A),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2B1C56).withAlpha(128),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.upload_file, color: Color(0xFF7B52FF), size: 28),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Drop more files here',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'PDF, DOCX up to 25MB',
                    style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SELECTED FILES (${selectedFiles.length})',
                style: GoogleFonts.poppins(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.0,
                ),
              ),
              GestureDetector(
                onTap: onPickFiles,
                child: Text(
                  '+ Add More',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF4C4DFF),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: selectedFiles.length,
              itemBuilder: (context, index) {
                final file = selectedFiles[index];
                bool isPdf = file.extension?.toLowerCase() == 'pdf';
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A27),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF2A2A3A)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isPdf ? const Color(0xFF3B1A28) : const Color(0xFF1A284D),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isPdf ? Icons.picture_as_pdf : Icons.description,
                          color: isPdf ? const Color(0xFFFF5252) : const Color(0xFF448AFF),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              file.name,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _formatBytes(file.size),
                              style: GoogleFonts.poppins(
                                color: Colors.white54,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF133221),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF21E070),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'READY',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF21E070),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => onRemoveFile(file),
                        child: const Icon(Icons.close, color: Colors.white54, size: 18),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (selectedFiles.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 24, top: 10),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onStartProcess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3823FF), // Bright purple/blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Process ${selectedFiles.length} Files',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
