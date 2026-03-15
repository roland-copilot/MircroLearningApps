import 'package:elearning/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              service.logout();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.075,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app_outlined, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Sign Out',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
