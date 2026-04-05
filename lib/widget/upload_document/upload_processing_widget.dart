import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadProcessingWidget extends StatelessWidget {
  final List<PlatformFile> selectedFiles;
  final double globalProgress;
  final bool notifyMeWhenFinished;
  final ValueChanged<bool> onNotifyChanged;
  final VoidCallback onContinue;

  const UploadProcessingWidget({
    super.key,
    required this.selectedFiles,
    required this.globalProgress,
    required this.notifyMeWhenFinished,
    required this.onNotifyChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('processing'),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            'Processing Queue',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Transforming ${selectedFiles.length} documents into study aids',
            style: GoogleFonts.poppins(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
              itemCount: selectedFiles.length,
              itemBuilder: (context, index) {
                final file = selectedFiles[index];
                bool isPdf = file.extension?.toLowerCase() == 'pdf';
                // Calculate individual file progress logically
                int totalFiles = selectedFiles.isNotEmpty ? selectedFiles.length : 1;
                double chunk = 1.0 / totalFiles;
                double startThreshold = index * chunk;
                double endThreshold = (index + 1) * chunk;

                double fileProgress = 0.0;
                if (globalProgress > endThreshold) {
                  fileProgress = 1.0;
                } else if (globalProgress < startThreshold) {
                  fileProgress = 0.0;
                } else {
                  fileProgress = (globalProgress - startThreshold) / chunk;
                }

                String statusText = 'Queued';
                Color statusColor = Colors.white54;
                Color progressColor = Colors.transparent;

                if (fileProgress >= 1.0) {
                  statusText = 'DONE';
                  statusColor = const Color(0xFF21E070);
                  progressColor = const Color(0xFF21E070);
                } else if (fileProgress > 0) {
                  if (fileProgress > 0.5) {
                    statusText = 'GENERATING VISUALS';
                    statusColor = const Color(0xFF4285F4);
                    progressColor = const Color(0xFF4285F4);
                  } else {
                    statusText = 'EXTRACTING TEXT';
                    statusColor = const Color(0xFF9C27B0);
                    progressColor = const Color(0xFF9C27B0);
                  }
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161622),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: fileProgress > 0 && fileProgress < 1.0
                          ? const Color(0xFF293256)
                          : const Color(0xFF212130),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: fileProgress >= 1.0 
                                ? const Color(0xFF163422) 
                                : const Color(0xFF212130),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isPdf ? Icons.picture_as_pdf : Icons.description,
                              color: fileProgress >= 1.0 
                                ? const Color(0xFF21E070)
                                : Colors.white54,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: statusColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      statusText,
                                      style: GoogleFonts.poppins(
                                        color: statusColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (fileProgress >= 1.0)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xFF21E070),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check, color: Colors.white, size: 14),
                            )
                          else if (fileProgress > 0.0)
                            Text(
                              '${(fileProgress * 100).toInt()}%',
                              style: GoogleFonts.poppins(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            )
                        ],
                      ),
                      if (fileProgress > 0 && fileProgress < 1.0) ...[
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: fileProgress,
                            backgroundColor: const Color(0xFF2A2A3A),
                            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                            minHeight: 4,
                          ),
                        ),
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notify me when finished',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Get a push notification',
                    style: GoogleFonts.poppins(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Switch(
                value: notifyMeWhenFinished,
                activeThumbColor: Colors.white,
                activeTrackColor: const Color(0xFF3823FF),
                inactiveThumbColor: Colors.white54,
                inactiveTrackColor: const Color(0xFF2A2A3A),
                onChanged: onNotifyChanged,
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A6BFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue to Dashboard',
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
