import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiMasterSummaryWidget extends StatelessWidget {
  const AiMasterSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF13131F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blueAccent.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.blueAccent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'AI Master Summary',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'This session bridges the structural concepts of Anatomy with the cellular mechanisms found in your Biology notes. Specifically, it correlates the skeletal framework discussed in Chapter 4 with the ATP production cycles detailed in your lab notes, highlighting how mitochondrial density varies by tissue type.',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Generated 2 mins ago',
                style: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 11,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'Read full analysis',
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.blueAccent,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
