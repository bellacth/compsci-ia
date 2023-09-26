import 'package:flutter/material.dart';

class ListFilterButton extends StatefulWidget {
  final String filterName;
  final bool isSelected;
  final void Function() onPressed;

  const ListFilterButton({
    required this.filterName,
    required this.isSelected,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<ListFilterButton> createState() => _ListFilterButtonState();
}

class _ListFilterButtonState extends State<ListFilterButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isSelected ? const Color.fromARGB(255, 255, 122, 87) : const Color.fromARGB(255, 230, 230, 232),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Text(
        widget.filterName,
        style: TextStyle(
          fontSize: 13,
          fontFamily: "Poppins",
          color: widget.isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}