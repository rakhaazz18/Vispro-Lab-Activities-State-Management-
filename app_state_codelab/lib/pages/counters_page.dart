import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../state/global_state.dart';
import '../widgets/counter_item_widget.dart';

/// Main page yang menampilkan list counters dan kontrol global
class CountersPage extends StatelessWidget {
  const CountersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GlobalState>(
      builder: (context, child, globalState) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Global State Counters'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            elevation: 2,
            actions: [
              // Reset all button
              if (globalState.counterCount > 0)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    switch (value) {
                      case 'reset_all':
                        _showResetAllDialog(context, globalState);
                        break;
                      case 'clear_all':
                        _showClearAllDialog(context, globalState);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'reset_all',
                      child: Row(
                        children: [
                          Icon(Icons.refresh, size: 20),
                          SizedBox(width: 8),
                          Text('Reset All'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'clear_all',
                      child: Row(
                        children: [
                          Icon(Icons.clear_all, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Clear All',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),

          body: Column(
            children: [
              // Global Statistics Card
              _buildStatisticsCard(globalState),

              // Counters List
              Expanded(
                child: globalState.counterCount == 0
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: globalState.counters.length,
                        itemBuilder: (context, index) {
                          final counter = globalState.counters[index];
                          return CounterItemWidget(counterItem: counter);
                        },
                      ),
              ),
            ],
          ),

          // Floating Action Button untuk menambah counter
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _showAddCounterDialog(context, globalState),
            icon: const Icon(Icons.add),
            label: const Text('Add Counter'),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
        );
      },
    );
  }

  /// Build statistics card di bagian atas
  Widget _buildStatisticsCard(GlobalState globalState) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                'Total Counters',
                '${globalState.counterCount}',
                Icons.apps,
                Colors.blue,
              ),
              Container(height: 40, width: 1, color: Colors.grey.shade300),
              _buildStatItem(
                'Total Value',
                '${globalState.totalValue}',
                Icons.calculate,
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build individual statistic item
  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  /// Build empty state ketika belum ada counter
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.apps, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No Counters Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the button below to add your first counter',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Show dialog untuk menambah counter baru
  void _showAddCounterDialog(BuildContext context, GlobalState globalState) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Counter'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Counter Name',
            hintText: 'Enter counter name (optional)',
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
              final name = controller.text.trim();
              globalState.addCounter(name: name.isEmpty ? null : name);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  /// Show dialog konfirmasi reset all
  void _showResetAllDialog(BuildContext context, GlobalState globalState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Counters'),
        content: const Text(
          'Are you sure you want to reset all counters to 0?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              globalState.resetAllCounters();
              Navigator.pop(context);
            },
            child: const Text('Reset All'),
          ),
        ],
      ),
    );
  }

  /// Show dialog konfirmasi clear all
  void _showClearAllDialog(BuildContext context, GlobalState globalState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Counters'),
        content: const Text(
          'Are you sure you want to delete all counters? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              globalState.clearAllCounters();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }
}
