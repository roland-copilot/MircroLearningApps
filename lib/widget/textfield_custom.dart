import 'package:elearning/util/contstant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextfieldCustom extends StatefulWidget {
  final bool obsecure;
  final String hint;
  final TextEditingController controller;
  final IconData? icon;
  final String? title;

  const TextfieldCustom({
    super.key,
    required this.obsecure,
    required this.hint,
    required this.controller,
    this.icon,
    this.title,
  });

  @override
  State<TextfieldCustom> createState() => _TextfieldCustomState();
}

class _TextfieldCustomState extends State<TextfieldCustom> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Text(widget.title!, style: GoogleFonts.poppins(fontSize: 13)),
          const SizedBox(height: 8),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: height(context) * 0.05,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: _isFocused ? Colors.green : Colors.black12,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: _isFocused ? Colors.green : Colors.black54,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      obscureText: widget.obsecure,
                      controller: widget.controller,
                      cursorColor: Colors.green,
                      style: GoogleFonts.poppins(),
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle: GoogleFonts.poppins(color: Colors.black38),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                    ),
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
