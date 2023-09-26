import 'package:flutter/material.dart';
import 'package:incart_app/util/add_button.dart';
import 'package:incart_app/util/filter_button.dart';
import 'package:incart_app/util/db_item_display.dart';
import 'shopping_database.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _filteredShop = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 188, 242),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          //rounded white border
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "shopping list",
                              style: TextStyle(fontSize: 44, fontFamily: 'AbrilFatface')
                            ),
                            //add item button
                            Center(child: AddButton()),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //filter buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListFilterButton(
                              filterName: "all",
                              isSelected: _filteredShop.isEmpty,
                              onPressed:() {
                                setState(() {
                                  _filteredShop = "";
                                });
                              }
                              ),
                            ListFilterButton(
                              filterName: "PX",
                              isSelected: _filteredShop == "px mart",
                              onPressed: () {
                                setState(() {
                                  _filteredShop = "px mart";
                                });
                              }),
                            ListFilterButton(
                              filterName: "costco",
                              isSelected: _filteredShop == "costco",
                              onPressed :() {
                                setState(() {
                                  _filteredShop = "costco";
                                });
                              }),
                            ListFilterButton(
                              filterName: "market",
                              isSelected: _filteredShop == "market",
                              onPressed :() {
                                setState(() {
                                  _filteredShop = "market";
                                });
                              })
                          ],
                        ),
                        //items in the database
                        FutureBuilder<List<Item>>(
                          future: getItems(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text("Empty");
                            } else {
                              //filter items (unbought and shop category)
                              List<Item> filteredItems = snapshot.data!.where((item) => !item.bought).toList();
                              if (_filteredShop.isNotEmpty) {
                                filteredItems = filteredItems.where((item) => item.shop == _filteredShop).toList();
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredItems.length,
                                itemBuilder: (context, index) {
                                  final item = filteredItems[index];
                                  return Dismissible(
                                    key: ValueKey(item.id),
                                    background: Container(
                                      color: const Color.fromARGB(255, 161, 188, 242),
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: const Icon(Icons.edit, color: Colors.white),
                                    ),
                                    secondaryBackground: Container(
                                      color: const Color.fromARGB(255, 255, 122, 87),
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      child: const Icon(Icons.delete, color: Colors.white),
                                    ),
                                    confirmDismiss: (direction) async {
                                      if (direction == DismissDirection.endToStart) {
                                        return await showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text("Delete Comfirmation", style: TextStyle(fontSize: 16, fontFamily: "Poppins", fontWeight: FontWeight.bold)),
                                            content: const Text("Are you sure you want to delete this item?", style: TextStyle(fontSize: 14, fontFamily: "Poppins")),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(true);
                                                },
                                                child: const Text("Yes", style: TextStyle(color: Color.fromARGB(255, 255, 122, 87), fontSize: 14, fontFamily: "Poppins")),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(ctx).pop(false);
                                                },
                                                child: const Text("No", style: TextStyle(color: Color.fromARGB(255, 255, 122, 87), fontSize: 14, fontFamily: "Poppins")),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return false; //for edit action
                                    },
                                    onDismissed: (direction) {
                                      if (direction == DismissDirection.endToStart) {
                                        deleteItem(item.id!).then((_) {
                                          setState(() {
                                            filteredItems.removeAt(index);
                                          });
                                        });
                                      } else if (direction == DismissDirection.startToEnd) {
                                      }
                                    },
                                    child: DatabaseItemDisplay(item: item),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
