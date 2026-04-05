import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiChatMessageList extends StatelessWidget {
  final List<Map<String, String>> messages;
  final bool isLoading;

  const AiChatMessageList({
    super.key,
    required this.messages,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      itemCount: messages.length + (isLoading ? 1 : 0) + 1, // +1 for the date header
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Center(
              child: Text(
                'TODAY, 2:41 PM',
                style: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        }

        final msgIndex = index - 1;
        if (isLoading && msgIndex == messages.length) {
          return _buildLoadingBubble();
        }

        final msg = messages[msgIndex];
        final isUser = msg['role'] == 'user';

        return _buildMessageBubble(msg['content'] ?? '', isUser);
      },
    );
  }

  Widget _buildMessageBubble(String content, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent.shade700 : const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isUser ? Radius.zero : const Radius.circular(16),
            bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
          ),
          border: isUser ? null : Border.all(color: Colors.white10),
        ),
        child: Text(
          content,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomLeft: Radius.zero,
          ),
          border: Border.all(color: Colors.white10),
        ),
        child: const SizedBox(
          width: 40,
          height: 20,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }
}
