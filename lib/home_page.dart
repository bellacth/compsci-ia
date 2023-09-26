import 'package:flutter/material.dart';
import 'package:incart_app/util/home_nav_grid.dart';
import 'package:intl/intl.dart';
import 'shop_page.dart';
import 'kitchen_page.dart';
import 'add_page.dart';
import 'notes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //date
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: const TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.grey),
              ),
              //title
              const Text(
                "welcome home",
                style: TextStyle(fontSize: 44, fontFamily: 'AbrilFatface'),
              ),

              //supporting text
              const Text(
                "what would you like to do?",
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
              
              // navigation buttons (large)
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      HomeGridButton(
                        buttonText: 'shopping list',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const ShopPage();
                            }),
                          );
                        },
                      ),
                      HomeGridButton(
                        buttonText: 'in the kitchen',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const KitchenPage();
                            }),
                          );
                        },
                      ),
                      HomeGridButton(
                        buttonText: 'add item',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const AddItemPage();
                            }),
                          );
                        },
                      ),
                      HomeGridButton(
                        buttonText: 'meal plans',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const NotesPage();
                            }),
                          );
                        },
                      )
                    ]),
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}
