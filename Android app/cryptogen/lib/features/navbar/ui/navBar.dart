import 'package:cryptogen/features/selectCoin/ui/selectCoin.dart';
import 'package:flutter/material.dart';
import '../../buy/ui/buy.dart';
import '../../home/ui/home.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  List<Widget> pages = [
    const Home(),
    const Buy(),
    SelectCoin(),
    const Home(),
  ];

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: pages.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.orange.shade600,
          unselectedItemColor: Colors.orange.shade600,
          type: BottomNavigationBarType.fixed,
          onTap: (value){
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined,size: 30),
                label: '',
                activeIcon: Icon(Icons.home,size: 30)),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_bitcoin,size: 30),
                label: '',
                activeIcon: Icon(Icons.currency_bitcoin,size: 30)),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph,size: 30),
                label: '',
                activeIcon: Icon(Icons.auto_graph,size: 30)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,size: 30),
                label: '',
                activeIcon: Icon(Icons.person,size: 30)),
          ],
        ),
      ),
    );
  }
}
