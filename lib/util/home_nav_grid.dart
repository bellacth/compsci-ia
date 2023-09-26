import 'package:flutter/material.dart';

class HomeGridButton extends StatefulWidget {
  final String buttonText;
  final void Function() onPressed;

  const HomeGridButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeGridButton> createState() => _HomeGridButtonState();
}

class _HomeGridButtonState extends State<HomeGridButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color.fromARGB(255, 161, 188, 242),
        padding: EdgeInsets.zero,
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.buttonText,
                  style: const TextStyle(fontSize: 16, fontFamily: 'Poppins', color: Colors.black),
                ),
              ))
        ],
      ),
    );
  }
}
