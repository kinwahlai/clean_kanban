import 'package:flutter_test/flutter_test.dart';
import 'package:clean_kanban/domain/entities/column.dart';
import 'package:clean_kanban/domain/entities/board.dart';

void main() {
  group('Board Entity', () {
    test('should create a simple board with 3 default columns: "To Do", "Doing", "Done"', () {
      // Arrange
      final board = Board.simple();
      
      // Assert
      expect(board.columns.length, equals(3));
      expect(board.columns[0].header, equals('To Do'));
      expect(board.columns[1].header, equals('Doing'));
      expect(board.columns[2].header, equals('Done'));
    });

    test('should create an enhanced board with at least 3 columns', () {
      // Arrange
      final columns = [
        KanbanColumn(id: '1', header: 'Backlog', columnLimit: null),
        KanbanColumn(id: '2', header: 'In Progress', columnLimit: null),
        KanbanColumn(id: '3', header: 'Review', columnLimit: null),
        KanbanColumn(id: '4', header: 'Done', columnLimit: null),
      ];
      
      // Act
      final board = Board(columns: columns);
      
      // Assert
      expect(board.columns.length, equals(4));
    });

    test('should throw error when creating board with less than 3 columns', () {
      // Arrange
      final columns = [
        KanbanColumn(id: '1', header: 'Only', columnLimit: null),
        KanbanColumn(id: '2', header: 'Two', columnLimit: null),
      ];
      
      // Act & Assert
      expect(() => Board(columns: columns), throwsA(isA<Exception>()));
    });
  });
}
