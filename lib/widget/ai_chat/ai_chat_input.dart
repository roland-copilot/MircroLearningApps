import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiChatInput extends StatefulWidget {
  final Function(String) onSend;

  const AiChatInput({super.key, required this.onSend});

  @override
  State<AiChatInput> createState() => _AiChatInputState();
}

class _AiChatInputState extends State<AiChatInput> {
  final TextEditingController _controller = TextEditingController();

  void _submit(String text) {
    if (text.trim().isNotEmpty) {
      widget.onSend(text);
      _controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF13131F),
        border: Border(
          top: BorderSide(color: Colors.white10),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPromptChip('Explain Gap Junctions'),
                  const SizedBox(width: 8),
                  _buildPromptChip('Summarize Chapter 1'),
                  const SizedBox(width: 8),
                  _buildPromptChip('Quiz me'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, color: Colors.white54),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: _submit,
                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Ask a follow up...',
                        hintStyle: GoogleFonts.poppins(color: Colors.white38),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent.shade400,
                      radius: 18,
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white, size: 16),
                        onPressed: () => _submit(_controller.text),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptChip(String text) {
    return GestureDetector(
      onTap: () => _submit(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
