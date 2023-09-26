import 'package:flutter/material.dart';
import '../add_page.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: CircleBorder(),
        color: Color.fromARGB(255, 255, 122, 87),
      ),
      height: 40,
      width: 40,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return const AddItemPage(); // Navigate to AddItemPage
            }),
          );
        },
        icon: const Icon(
          Icons.add, 
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
