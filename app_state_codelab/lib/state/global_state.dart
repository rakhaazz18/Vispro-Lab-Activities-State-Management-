import 'package:scoped_model/scoped_model.dart';
import '../models/counter_item.dart';

/// Global State class untuk mengelola semua counter items
/// Menggunakan Scoped Model untuk reactive state management
class GlobalState extends Model {
  // Private list untuk menyimpan semua counter items
  final List<CounterItem> _counters = [];

  // Getter untuk mengakses list counters (immutable copy)
  List<CounterItem> get counters => List.unmodifiable(_counters);

  // Getter untuk menghitung total semua counter values
  int get totalValue =>
      _counters.fold(0, (sum, counter) => sum + counter.value);

  // Getter untuk menghitung jumlah counters
  int get counterCount => _counters.length;

  /// Menambah counter baru
  void addCounter({String? name}) {
    final counterName = name ?? 'Counter ${_counters.length + 1}';
    final newCounter = CounterItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: counterName,
    );

    _counters.add(newCounter);
    notifyListeners();
  }

  /// Menghapus counter berdasarkan ID
  void removeCounter(String id) {
    _counters.removeWhere((counter) => counter.id == id);
    notifyListeners();
  }

  /// Increment counter tertentu berdasarkan ID
  void incrementCounter(String id) {
    final index = _counters.indexWhere((counter) => counter.id == id);
    if (index != -1) {
      _counters[index] = _counters[index].copyWith(
        value: _counters[index].value + 1,
      );
      notifyListeners();
    }
  }

  /// Decrement counter tertentu berdasarkan ID
  void decrementCounter(String id) {
    final index = _counters.indexWhere((counter) => counter.id == id);
    if (index != -1) {
      _counters[index] = _counters[index].copyWith(
        value: _counters[index].value - 1,
      );
      notifyListeners();
    }
  }

  /// Reset counter tertentu ke 0
  void resetCounter(String id) {
    final index = _counters.indexWhere((counter) => counter.id == id);
    if (index != -1) {
      _counters[index] = _counters[index].copyWith(value: 0);
      notifyListeners();
    }
  }

  /// Reset semua counters ke 0
  void resetAllCounters() {
    for (int i = 0; i < _counters.length; i++) {
      _counters[i] = _counters[i].copyWith(value: 0);
    }
    notifyListeners();
  }

  /// Hapus semua counters
  void clearAllCounters() {
    _counters.clear();
    notifyListeners();
  }

  /// Update nama counter
  void updateCounterName(String id, String newName) {
    final index = _counters.indexWhere((counter) => counter.id == id);
    if (index != -1) {
      _counters[index] = _counters[index].copyWith(name: newName);
      notifyListeners();
    }
  }

  /// Get counter by ID
  CounterItem? getCounterById(String id) {
    try {
      return _counters.firstWhere((counter) => counter.id == id);
    } catch (e) {
      return null;
    }
  }
}
