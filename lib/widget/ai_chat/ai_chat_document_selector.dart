import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiChatDocumentSelector extends StatelessWidget {
  const AiChatDocumentSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: [
          _buildDocChip(
            icon: Icons.description,
            iconColor: Colors.blueAccent,
            title: 'Anatomy 101',
            subtitle: 'PDF • 2.4MB',
            isActive: true,
          ),
          const SizedBox(width: 12),
          _buildDocChip(
            icon: Icons.science,
            iconColor: Colors.greenAccent,
            title: 'Cell Biology',
            subtitle: 'DOCX • 1.1MB',
            isActive: false,
          ),
          const SizedBox(width: 12),
          _buildDocChip(
            icon: Icons.text_snippet,
            iconColor: Colors.purpleAccent,
            title: 'Lab Report',
            subtitle: 'TXT • 420KB',
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDocChip({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isActive,
  }) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.blueAccent.withOpacity(0.1) : const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? Colors.blueAccent : Colors.white10,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
