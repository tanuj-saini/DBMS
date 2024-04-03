import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_complete/Comman/utils/colors.dart';
import 'package:whatsapp_complete/screens/CallScreen/callScreen.dart';
import 'package:whatsapp_complete/screens/ChatScreen/chatScreen.dart';
import 'package:whatsapp_complete/screens/Status/statusScreen.dart';

class bottomNav extends ConsumerStatefulWidget {
  bottomNav({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _bottomnav();
  }
}

class _bottomnav extends ConsumerState<bottomNav> {
  int _selectedIndex = 0;

  // Define your pages/screens here
  final List<Widget> _pages = [
    ChatScreen(),
    StatusScreen(),
    CallScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: tabColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
        ],
      ),
    );
  }
}
