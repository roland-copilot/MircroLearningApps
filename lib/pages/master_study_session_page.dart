import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/study_session/synthesizing_sources_widget.dart';
import '../widget/study_session/ai_master_summary_widget.dart';
import '../widget/study_session/curated_study_path_widget.dart';
import '../widget/study_session/key_terms_widget.dart';
import 'ai_chat_page.dart';

class MasterStudySessionPage extends StatelessWidget {
  const MasterStudySessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F16),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Master Study Session',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SynthesizingSourcesWidget(),
              SizedBox(height: 24),
              AiMasterSummaryWidget(),
              SizedBox(height: 32),
              CuratedStudyPathWidget(),
              SizedBox(height: 32),
              KeyTermsWidget(),
              SizedBox(height: 100), // Padding for the floating "Ask AI" button
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AiChatPage()),
          );
        },
        backgroundColor: Colors.blueAccent.shade400,
        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
        label: Text(
          'Ask AI',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
