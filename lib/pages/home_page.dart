
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'upload_document_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundColor: Colors.white),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, Alex',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              Text(
                                'Ready to learn?',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.notifications),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 142,
                width: 380,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade900),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Study Streak',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '0 Days',
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '0% goal',
                            style: GoogleFonts.poppins(
                              color: Colors.deepPurple.shade400,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Start your first lesson to build a streak!',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 558,
                width: 380,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 192,
                      width: 192,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900.withAlpha(40),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.menu_book_rounded,
                          color: Colors.blue.shade800,
                          size: 88,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      'Your library is quiet for\nnow.',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: 311,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Upload your first document to unlock AI - powered mind maps, flashcards, and summaries.',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white30,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UploadDocumentPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 56,
                        width: 253,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.shade700,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Upload & Analyze',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
