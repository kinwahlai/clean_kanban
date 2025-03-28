import 'package:flutter/material.dart';
import 'package:clean_kanban/domain/entities/board.dart';
import 'package:clean_kanban/domain/entities/task.dart';
import 'package:clean_kanban/domain/usecases/board_use_cases.dart';
import 'package:clean_kanban/domain/usecases/task_use_cases.dart';
import 'package:clean_kanban/injection_container.dart';

class BoardProvider extends ChangeNotifier {
  Board? board;

  final GetBoardUseCase _getBoardUseCase = getIt<GetBoardUseCase>();
  final SaveBoardUseCase _saveBoardUseCase = getIt<SaveBoardUseCase>();
  final UpdateBoardUseCase _updateBoardUseCase = getIt<UpdateBoardUseCase>();
  final AddTaskUseCase _addTaskUseCase = getIt<AddTaskUseCase>();
  final DeleteTaskUseCase _deleteTaskUseCase = getIt<DeleteTaskUseCase>();
  final MoveTaskUseCase _moveTaskUseCase = getIt<MoveTaskUseCase>();
  final ReorderTaskUseCase _reorderTaskUseCase = getIt<ReorderTaskUseCase>();

  Future<void> loadBoard({Map<String, dynamic>? config}) async {
    try {
      final fetchedBoard = await _getBoardUseCase.execute();
      board = fetchedBoard;
      debugPrint('Previous saved board found');
    } catch (e) {
      board = config != null ? Board.fromConfig(config) : Board.simple();
      await _saveBoardUseCase.execute(board!);
      debugPrint(
          'Error: $e, No previous saved board found, created a new one.');
    }
    notifyListeners();
  }

  void addTask(String columnId, Task task) {
    final col = board?.columns.firstWhere((c) => c.id == columnId);
    if (col != null) {
      _addTaskUseCase.execute(col, task);
      notifyListeners();
    }
  }

  void removeTask(String columnId, int index) {
    final col = board?.columns.firstWhere((c) => c.id == columnId);
    if (col != null) {
      _deleteTaskUseCase.execute(col, index);
      notifyListeners();
    }
  }

  void moveTask(String sourceColId, int sourceIndex, String destColId) {
    final source = board?.columns.firstWhere((c) => c.id == sourceColId);
    final destination = board?.columns.firstWhere((c) => c.id == destColId);
    if (source != null && destination != null) {
      _moveTaskUseCase.execute(source, sourceIndex, destination);
      notifyListeners();
    }
  }

  void reorderTask(String columnId, int oldIndex, int newIndex) {
    final col = board?.columns.firstWhere((c) => c.id == columnId);
    if (col != null) {
      _reorderTaskUseCase.execute(col, oldIndex, newIndex);
      notifyListeners();
    }
  }

  // Add this method to save the current board state
  Future<void> saveBoard() async {
    if (board != null) {
      await _saveBoardUseCase.execute(board!);
    }
  }
}
