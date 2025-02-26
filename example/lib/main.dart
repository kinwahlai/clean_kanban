import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_kanban/injection_container.dart';
import 'package:clean_kanban/ui/providers/board_provider.dart';
import 'package:clean_kanban/ui/board_screen.dart';
import 'package:clean_kanban/domain/entities/board.dart';

void main() {
  // Initialize dependency injection.
  setupInjection();
  runApp(const MyExampleApp());
}

class MyExampleApp extends StatelessWidget {
  const MyExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BoardProvider()..loadBoard(config: _boardConfig),
      child: MaterialApp(
          title: 'Clean Kanban Example',
          theme: ThemeData.light(),
          home: const BoardScreen()),
    );
  }
}

const Map<String, dynamic> _boardConfig = {
  'columns': [
    {
      'id': 'todo',
      'header': 'To Do',
      'limit': 5,
      'tasks': [
        {'id': '1', 'title': 'Task 1', 'subtitle': 'Description 1'},
        {'id': '2', 'title': 'Task 2', 'subtitle': 'Description 2'},
      ]
    },
    {
      'id': 'doing',
      'header': 'In Progress',
      'limit': 3,
      'tasks': [
        {'id': '3', 'title': 'Task 3', 'subtitle': 'Description 3'},
      ]
    },
    {'id': 'review', 'header': 'Review', 'limit': 2, 'tasks': []},
    {
      'id': 'done',
      'header': 'Done',
      'limit': null,
      'tasks': [
        {'id': '4', 'title': 'Task 4', 'subtitle': 'Description 4'}
      ]
    }
  ]
};
