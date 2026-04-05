import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyStateDashboard extends StatelessWidget {
  const EmptyStateDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 144,
                width: 163,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade900,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              Container(
                height: 144,
                width: 163,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade800,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent.shade700,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload & Analyze',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Transform documents into study aids instantly.',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
