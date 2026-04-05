import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SynthesizingSourcesWidget extends StatelessWidget {
  const SynthesizingSourcesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SYNTHESIZING SOURCES',
          style: GoogleFonts.poppins(
            color: Colors.blueAccent.shade400,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildSourceChip(
                icon: Icons.picture_as_pdf,
                iconColor: Colors.redAccent,
                label: 'Anatomy_101.pdf',
              ),
              const SizedBox(width: 12),
              _buildSourceChip(
                icon: Icons.description,
                iconColor: Colors.blueAccent,
                label: 'Cell_Bio_Notes.docx',
              ),
              const SizedBox(width: 12),
              _buildSourceChip(
                icon: Icons.science,
                iconColor: Colors.greenAccent,
                label: 'Lab_Report_1.txt',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSourceChip({
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C), // Darker generic background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
