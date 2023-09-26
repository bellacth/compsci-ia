import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 234, 255),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
          child: Text(
            "notes",
            style: TextStyle(fontSize: 44, fontFamily: 'AbrilFatface'),
          ),
        ),
      ),
    );
  }
}