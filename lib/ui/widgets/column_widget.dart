import 'package:flutter/material.dart';
import 'package:clean_kanban/domain/entities/column.dart';
import 'task_card.dart';

class ColumnWidget extends StatelessWidget {
  final KanbanColumn column;
  final Color columnColor;
  final Color columnBorderColor;
  final Color columnHeaderColor;
  final Color columnHeaderTextColor;
  final Function(String title, String subtitle)? onAddItem;

  const ColumnWidget({
    Key? key,
    required this.column,
    this.columnColor = Colors.white,
    this.columnBorderColor = const Color(0xFFE0E0E0),
    this.columnHeaderColor = Colors.blue,
    this.columnHeaderTextColor = Colors.black87,
    this.onAddItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            itemCount: column.tasks.length,
            itemBuilder: (context, index) {
              final task = column.tasks[index];
              return TaskCard(task: task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 64.0,
      decoration: BoxDecoration(
        color: columnHeaderColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title and count grouped together
          Row(
            children: [
              Text(
                column.header,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: columnHeaderTextColor,
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 2.0,
                ),
                decoration: BoxDecoration(
                  color: columnColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  column.columnLimit != null
                      ? '${column.tasks.length}/${column.columnLimit}'
                      : '${column.tasks.length}',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: columnHeaderTextColor,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          if (onAddItem != null)
            Container(
              height: 32.0,
              width: 32.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                icon: const Icon(Icons.add_rounded, size: 20.0),
                padding: EdgeInsets.zero,
                color: Colors.grey.shade500,
                onPressed: onAddItem != null
                    ? () {
                        onAddItem!('New Task', 'Description');
                      }
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}
