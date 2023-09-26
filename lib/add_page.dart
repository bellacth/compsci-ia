import 'package:flutter/material.dart';
import 'package:incart_app/util/input_field.dart';
import 'package:intl/intl.dart';
import 'shopping_database.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  //shops selected
  String _selectedShop = "select";
  List<String> shopList = [
    "px mart",
    "costco",
    "market",
  ];
  //storage selected
  String _selectedStorage = "select";
  List<String> storageList = [
    "fridge",
    "freezer",
    "pantry",
  ];

  Future<void> _selectDate(BuildContext context) async {
    //method for date selection in text input
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2075),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  _addItemToDatabase() async {
    final itemName = _itemNameController.text;
    final quantity = int.parse(_quantityController.text);
    const bought = false;
    final date = DateFormat.yMd().format(_selectedDate);
    final shop = _selectedShop;
    final storage = _selectedStorage;
    final newItem = Item(
      id: null,
      name: itemName,
      quantity: quantity,
      bought: bought,
      date: date,
      shop: shop,
      storage: storage,
    );
    await insertItem(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 234, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                const Text(
                  "new item",
                  style: TextStyle(fontSize: 44, fontFamily: 'AbrilFatface'),
                ),
                const SizedBox(
                  height: 30,
                ),
                //white container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  child: Column(
                    children: [
                      //item name input
                      TextInput(
                        label: "item name",
                        hint: "insert text",
                        controller: _itemNameController,
                      ),
                      Row(
                        children: [
                          //quantity input
                          Expanded(
                            child: TextInput(
                              label: "quantity",
                              hint: "insert number",
                              controller: _quantityController,
                            ),
                          ),
                          const SizedBox(width: 15),
                          //date input
                          Expanded(
                            child: TextInput(
                                label: "date",
                                hint: DateFormat.yMd().format(_selectedDate),
                                widget: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    iconSize: 20,
                                    onPressed: () {
                                      _selectDate(context);
                                    })),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          //shop input
                          Expanded(
                            child: TextInput(
                              label: "at shop",
                              hint: _selectedShop,
                              widget: DropdownButton(
                                icon: const Icon(Icons.expand_more,
                                    color: Colors.black),
                                iconSize: 20,
                                underline: Container(
                                  height: 0,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedShop = newValue!;
                                  });
                                },
                                items: shopList.map<DropdownMenuItem<String>>(
                                  (String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value!,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          //storage input
                          Expanded(
                            child: TextInput(
                              label: "storage",
                              hint: _selectedStorage,
                              widget: DropdownButton(
                                icon: const Icon(Icons.expand_more,
                                    color: Colors.black),
                                iconSize: 20,
                                underline: Container(
                                  height: 0,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedStorage = newValue!;
                                  });
                                },
                                items:
                                    storageList.map<DropdownMenuItem<String>>(
                                  (String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value!,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //additional notes input
                      const TextInput(
                        label: "additional notes",
                        hint: "insert text",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //buttons (cancel and done)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //cancel button
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 161, 188, 242),
                            side: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                          child: const Text("cancel",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))),
                    ),
                    const SizedBox(width: 20),
                    //done button
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            _validateData();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 122, 87),
                            side: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                          child: const Text("done",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_itemNameController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      _addItemToDatabase();
      Navigator.pop(context);
    } else if (_itemNameController.text.isEmpty ||
        _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.white,
          duration: Duration(seconds: 2),
          content: Text("Whoops! Please fill in all required fields.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: "Poppins",
                color: Color.fromARGB(255, 255, 122, 87),
              )),
        ),
      );
    }
  }
}
