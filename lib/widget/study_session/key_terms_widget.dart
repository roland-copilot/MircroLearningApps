import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyTermsWidget extends StatelessWidget {
  const KeyTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final terms = [
      {'label': 'Mitochondria', 'color': Colors.transparent, 'borderColor': Colors.white24},
      {'label': 'Osteology', 'color': Colors.transparent, 'borderColor': Colors.white24},
      {'label': 'Histology', 'color': Colors.blueAccent.withOpacity(0.2), 'borderColor': Colors.blueAccent},
      {'label': 'ATP Synthesis', 'color': Colors.transparent, 'borderColor': Colors.white24},
      {'label': 'Plasma Membrane', 'color': Colors.transparent, 'borderColor': Colors.white24},
      {'label': 'Cytoskeleton', 'color': Colors.transparent, 'borderColor': Colors.white24},
      {'label': 'Lipid Bilayer', 'color': Colors.transparent, 'borderColor': Colors.white24},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KEY TERMS ACROSS ALL FILES',
          style: GoogleFonts.poppins(
            color: Colors.white54,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: terms.map((term) {
            final color = term['color'] as Color;
            final borderColor = term['borderColor'] as Color;
            final isHighlighted = color != Colors.transparent;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: borderColor),
              ),
              child: Text(
                term['label'] as String,
                style: GoogleFonts.poppins(
                  color: isHighlighted ? Colors.blueAccent : Colors.white70,
                  fontSize: 12,
                  fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
