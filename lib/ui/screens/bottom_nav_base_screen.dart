import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/tasks/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/tasks/completed_task_screen.dart';
import 'package:task_manager/ui/screens/tasks/in_progress_task_screen.dart';
import 'package:task_manager/ui/screens/tasks/new_task_screen.dart';
class BottomNavBaseScreen extends StatefulWidget {
  const BottomNavBaseScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBaseScreen> createState() => _BottomNavBaseScreenState();
}

class _BottomNavBaseScreenState extends State<BottomNavBaseScreen> {
  int _selectedScreenIndex = 0;
  bool isActive = true;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    InProgressTaskScreen(),
    CanceledTaskScreen(),
    CompletedTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: FlashyTabBar(
        animationDuration: const Duration(milliseconds: 400),
        selectedIndex: _selectedScreenIndex,
        onItemSelected: (int index) {
              _selectedScreenIndex = index;
              setState(() {});
        },
        showElevation: true,
        items: [
          FlashyTabBarItem(icon: const Icon(Icons.menu), title: const Text('New'),activeColor: Colors.green,inactiveColor: Colors.blueGrey),
          FlashyTabBarItem(icon: const Icon(Icons.trending_up), title: const Text('In Progress'),activeColor: Colors.green,inactiveColor: Colors.blueGrey),
          FlashyTabBarItem(icon: const Icon(Icons.cancel_outlined), title: const Text('Cancelled'),activeColor: Colors.green,inactiveColor: Colors.blueGrey),
          FlashyTabBarItem(icon: const Icon(Icons.done_all), title: const Text('Completed'),activeColor: Colors.green,inactiveColor: Colors.blueGrey),

        ], 
      ),

    );
  }
}