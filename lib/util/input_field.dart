import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const TextInput({
    required this.label,
    required this.hint,
    this.controller,
    this.widget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.bold),
          ),
          Container(
            height: 30,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    controller: controller,
                    style: const TextStyle(fontSize: 11, fontFamily: "Poppins", color: Colors.black),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(fontSize: 11, fontFamily: "Poppins", color: Colors.black),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0,
                        )
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0,
                        )
                      ),
                    ),
                  ),
                ),
                widget==null?Container():Container(child:widget)
              ],
            ),
          )
        ],
      )
    );
  }
}