import 'package:flutter/material.dart';
import 'home_page.dart';
import 'shop_page.dart';
import 'kitchen_page.dart';
import 'notes_page.dart';

class NavBar extends StatefulWidget {
  final int initialIndex;

  const NavBar({required this.initialIndex, Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomePage(),
          ShopPage(),
          KitchenPage(),
          NotesPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          iconSize: 30,
          selectedItemColor: const Color.fromARGB(255, 255, 122, 87),
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_outlined),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.kitchen_outlined),
              label: "",
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_outlined),
              label: "",
              backgroundColor: Colors.white,
            ),
          ]),
    );
  }
}
