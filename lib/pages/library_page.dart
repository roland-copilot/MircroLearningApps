import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Library',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(Icons.sort),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: Colors.white70),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
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
