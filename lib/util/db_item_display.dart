import 'package:flutter/material.dart';
import 'package:incart_app/shopping_database.dart';

class DatabaseItemDisplay extends StatefulWidget {
  final Item item;
  
  const DatabaseItemDisplay({super.key, required this.item});

  @override
  State<DatabaseItemDisplay> createState() => _DatabaseItemDisplayState();
}

class _DatabaseItemDisplayState extends State<DatabaseItemDisplay> {
  bool _isBought = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isBought = !_isBought;
                final updatedItem = widget.item.copyWith(bought: _isBought);
                updateItem(updatedItem);
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _isBought ? Colors.white : Colors.black),
                color: _isBought ? Colors.black : Colors.transparent,
              ),
            ),
          ),
          Text(
            widget.item.name,
            style: const TextStyle(fontSize: 12, fontFamily: "Poppins",)
          ),
          Text(
            widget.item.quantity.toString(),
            style: const TextStyle(fontSize: 12, fontFamily: "Poppins",)
          )
        ]
      )
    );
  }
}