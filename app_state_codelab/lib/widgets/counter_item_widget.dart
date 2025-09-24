import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/counter_item.dart';
import '../state/global_state.dart';

/// Widget untuk menampilkan individual counter item
class CounterItemWidget extends StatelessWidget {
  final CounterItem counterItem;

  const CounterItemWidget({super.key, required this.counterItem});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GlobalState>(
      builder: (context, child, globalState) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Counter Header dengan nama dan delete button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        counterItem.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        switch (value) {
                          case 'reset':
                            globalState.resetCounter(counterItem.id);
                            break;
                          case 'delete':
                            _showDeleteDialog(context, globalState);
                            break;
                          case 'rename':
                            _showRenameDialog(context, globalState);
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'reset',
                          child: Row(
                            children: [
                              Icon(Icons.refresh, size: 20),
                              SizedBox(width: 8),
                              Text('Reset'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'rename',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 20),
                              SizedBox(width: 8),
                              Text('Rename'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Counter Value Display
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${counterItem.value}',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Decrement Button
                    ElevatedButton.icon(
                      onPressed: () =>
                          globalState.decrementCounter(counterItem.id),
                      icon: const Icon(Icons.remove),
                      label: const Text('Dec'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    // Increment Button
                    ElevatedButton.icon(
                      onPressed: () =>
                          globalState.incrementCounter(counterItem.id),
                      icon: const Icon(Icons.add),
                      label: const Text('Inc'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),

                // Counter Info
                const SizedBox(height: 8),
                Text(
                  'Created: ${_formatDateTime(counterItem.createdAt)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Format datetime untuk display
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  /// Show dialog untuk konfirmasi delete
  void _showDeleteDialog(BuildContext context, GlobalState globalState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Counter'),
        content: Text('Are you sure you want to delete "${counterItem.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              globalState.removeCounter(counterItem.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  /// Show dialog untuk rename counter
  void _showRenameDialog(BuildContext context, GlobalState globalState) {
    final controller = TextEditingController(text: counterItem.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Counter'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Counter Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                globalState.updateCounterName(
                  counterItem.id,
                  controller.text.trim(),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
