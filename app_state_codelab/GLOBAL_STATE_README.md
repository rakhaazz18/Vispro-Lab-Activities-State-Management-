# Global State Management - Flutter Counter App

Aplikasi Flutter yang mendemonstrasikan **Global State Management** menggunakan **Scoped Model** dengan multiple counters yang dapat dikelola secara individual.

## 📱 Features

### ✨ Core Functionality
- **Add New Counters**: Tambah counter baru dengan nama custom
- **Remove Counters**: Hapus counter individual dengan konfirmasi
- **Increment/Decrement**: Kontrol setiap counter secara terpisah
- **Reset Counter**: Reset individual counter ke 0
- **Rename Counter**: Ubah nama counter
- **Global Statistics**: Tampilan total counter dan total nilai

### 🎯 Advanced Features
- **Reset All**: Reset semua counter ke 0
- **Clear All**: Hapus semua counter sekaligus
- **Empty State**: UI yang informatif ketika belum ada counter
- **Responsive Design**: Layout yang adaptif
- **Confirmation Dialogs**: Dialog konfirmasi untuk aksi destruktif

## 🏗️ Architecture

### File Structure
```
lib/
├── main.dart                     # Entry point & app configuration
├── models/
│   └── counter_item.dart        # Data model untuk counter item
├── state/
│   └── global_state.dart        # Global state management class
├── pages/
│   └── counters_page.dart       # Main page dengan list counters
└── widgets/
    └── counter_item_widget.dart # Widget untuk individual counter
```

### State Management Pattern
- **Global State**: `GlobalState` class extends `Model` dari scoped_model
- **Reactive Updates**: Menggunakan `notifyListeners()` untuk trigger UI rebuild
- **Immutable Data**: Model menggunakan `copyWith` pattern
- **Centralized Logic**: Semua business logic terpusat di GlobalState

## 🎨 UI Components

### 1. Statistics Card
- Total jumlah counters
- Total nilai dari semua counters
- Icons dan visual indicators

### 2. Counter Item Widget
- Individual counter display
- Increment/Decrement buttons
- Context menu (Reset, Rename, Delete)
- Created timestamp
- Visual feedback

### 3. Empty State
- Placeholder ketika belum ada counter
- Call-to-action untuk menambah counter pertama

## 🔧 Technical Implementation

### Global State Class
```dart
class GlobalState extends Model {
  final List<CounterItem> _counters = [];
  
  // Getters
  List<CounterItem> get counters => List.unmodifiable(_counters);
  int get totalValue => _counters.fold(0, (sum, counter) => sum + counter.value);
  int get counterCount => _counters.length;
  
  // Methods
  void addCounter({String? name}) { /* ... */ }
  void removeCounter(String id) { /* ... */ }
  void incrementCounter(String id) { /* ... */ }
  void decrementCounter(String id) { /* ... */ }
  // ... other methods
}
```

### Counter Model
```dart
class CounterItem {
  final String id;
  final String name;
  int value;
  final DateTime createdAt;
  
  CounterItem copyWith({ /* ... */ }) { /* ... */ }
}
```

### State Consumer
```dart
ScopedModelDescendant<GlobalState>(
  builder: (context, child, globalState) {
    return ListView.builder(
      itemCount: globalState.counters.length,
      itemBuilder: (context, index) {
        return CounterItemWidget(counterItem: globalState.counters[index]);
      },
    );
  },
);
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.0+)
- Dart SDK
- IDE (VS Code/Android Studio)

### Installation
1. Clone repository
2. Navigate to project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

### Dependencies
- `scoped_model: ^2.0.0` - State management
- `cupertino_icons: ^1.0.8` - iOS style icons

## 📚 Learning Objectives

### State Management Concepts
1. **Centralized State**: Single source of truth untuk app state
2. **Reactive Programming**: UI otomatis update ketika state berubah
3. **Data Flow**: Unidirectional data flow pattern
4. **State Isolation**: Business logic terpisah dari UI

### Flutter Concepts
1. **Widget Composition**: Breaking down UI into reusable components
2. **ListView Management**: Dynamic list dengan add/remove items
3. **Dialog Management**: User interaction dengan confirmation dialogs
4. **Theme Integration**: Consistent styling throughout app

### Best Practices
1. **Immutable Models**: Using copyWith pattern
2. **Error Handling**: Safe operations dengan null checks
3. **User Experience**: Confirmation dialogs dan feedback
4. **Code Organization**: Clean architecture dengan separation of concerns

## 🎯 Key Takeaways

1. **Scoped Model** menyediakan cara mudah untuk global state management
2. **Model.notifyListeners()** trigger rebuild pada widget yang listening
3. **ScopedModelDescendant** adalah bridge antara state dan UI
4. **Centralized state** memudahkan debugging dan maintenance
5. **Reactive pattern** membuat UI selalu sinkron dengan data

## 💡 Potential Improvements

1. **State Persistence**: Save state ke local storage
2. **Animation**: Smooth transitions untuk add/remove operations
3. **Drag & Drop**: Reorder counters
4. **Export/Import**: Backup dan restore counter data
5. **Themes**: Multiple theme options
6. **Modern State Management**: Migrate ke Provider/Riverpod/Bloc

---

**Dibuat untuk pembelajaran Flutter State Management** 📚✨