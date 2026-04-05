import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/ai_chat/ai_chat_document_selector.dart';
import '../widget/ai_chat/ai_chat_message_list.dart';
import '../widget/ai_chat/ai_chat_input.dart';
import '../service/chat_service.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final ChatService _chatService = ChatService();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "content": text});
      _isLoading = true;
    });

    final aiResponse = await _chatService.sendMessage(
      text,
      previousMessages: _messages.where((m) => m['role'] != 'error').toList(),
    );

    setState(() {
      _messages.add({"role": "assistant", "content": aiResponse});
      _isLoading = false;
    });
  }

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
        title: Column(
          children: [
            Text(
              'Research Assistant',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Chatting with 3 documents',
                  style: GoogleFonts.poppins(
                    color: Colors.blueAccent,
                    fontSize: 10,
                  ),
                ),
              ],
            )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const AiChatDocumentSelector(),
          Expanded(
            child: AiChatMessageList(
              messages: _messages,
              isLoading: _isLoading,
            ),
          ),
          AiChatInput(onSend: _sendMessage),
        ],
      ),
    );
  }
}
