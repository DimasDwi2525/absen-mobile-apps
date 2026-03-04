import 'package:flutter/material.dart';

class NavbarBottom extends StatefulWidget {
  const NavbarBottom({super.key});

  @override
  State<NavbarBottom> createState() => _NavbarBottomState();
}

class _NavbarBottomState extends State<NavbarBottom> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.history, 'label': 'History'},
    {'icon': Icons.beach_access, 'label': 'Leave'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Placeholder navigation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to ${navItems[index]['label']}...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: navItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon'], size: 28),
            label: item['label'],
          );
        }).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        onTap: _onItemTapped,
      ),
    );
  }
}
