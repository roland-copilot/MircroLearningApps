

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/upload_document/upload_processing_widget.dart';
import '../widget/upload_document/upload_selection_widget.dart';
import '../widget/upload_document/upload_success_widget.dart';
import 'master_study_session_page.dart';
import 'main_page.dart';

enum UploadProcessState { selection, processing, success }

class UploadDocumentPage extends StatefulWidget {
  const UploadDocumentPage({super.key});

  @override
  State<UploadDocumentPage> createState() => _UploadDocumentPageState();
}

class _UploadDocumentPageState extends State<UploadDocumentPage> {
  UploadProcessState _currentState = UploadProcessState.selection;
  final List<PlatformFile> _selectedFiles = [];
  bool _notifyMeWhenFinished = true;
  double _globalProgress = 0.0;

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result.files);
      });
    }
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      _selectedFiles.remove(file);
    });
  }

  void _startProcess() async {
    if (_selectedFiles.isEmpty) return;
    setState(() {
      _currentState = UploadProcessState.processing;
      _globalProgress = 0.0;
    });

    for (int i = 0; i <= 100; i++) {
        await Future.delayed(const Duration(milliseconds: 60)); // Simulate processing 6 sec total
        if (!mounted) return;
        setState(() {
            _globalProgress = i / 100.0;
        });
    }

    setState(() {
      _currentState = UploadProcessState.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F16), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (_currentState == UploadProcessState.selection) {
                Navigator.pop(context);
            } else {
                setState(() {
                    _currentState = UploadProcessState.selection;
                });
            }
          },
        ),
        title: _currentState == UploadProcessState.selection
            ? Text('Batch Upload', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16))
            : null,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildCurrentState(),
        ),
      ),
    );
  }

  Widget _buildCurrentState() {
    switch (_currentState) {
      case UploadProcessState.selection:
        return UploadSelectionWidget(
          selectedFiles: _selectedFiles,
          onPickFiles: _pickFiles,
          onRemoveFile: _removeFile,
          onStartProcess: _startProcess,
        );
      case UploadProcessState.processing:
        return UploadProcessingWidget(
          selectedFiles: _selectedFiles,
          globalProgress: _globalProgress,
          notifyMeWhenFinished: _notifyMeWhenFinished,
          onNotifyChanged: (val) {
            setState(() {
              _notifyMeWhenFinished = val;
            });
          },
          onContinue: () {
            Navigator.pop(context);
          },
        );
      case UploadProcessState.success:
        return UploadSuccessWidget(
          selectedFiles: _selectedFiles,
          onBackToHome: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
              (route) => false,
            );
          },
          onShare: () {},
          onStartStudying: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MasterStudySessionPage(),
              ),
            );
          },
        );
    }
  }
}

