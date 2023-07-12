import 'package:flutter/material.dart';
import 'package:flutterprueba/screens/drawer.dart';
import 'package:flutterprueba/screens/favorite_tasks_screen.dart';
import 'package:flutterprueba/screens/pending.screen.dart';

import 'addTask.screen.dart';
import 'completed_task_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = 'tabs_screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const PendingTasksScreen(), 'title': 'Tareas pendientes'},
    {'pageName': const CompletedTasksScreen(), 'title': 'Tareas completadas'},
    {'pageName': const FavoriteTasksScreen(), 'title': 'Favoritas'},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const AddTaskScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]['title']),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MyDrawer(),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () => _addTask(context),
              tooltip: 'Agregar tarea',
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle_sharp),
              label: 'Tareas pendientes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: 'Tareas completadas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritas')
        ],
      ),
    );
  }
}
