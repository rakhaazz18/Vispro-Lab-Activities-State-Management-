/// Model untuk individual counter item
class CounterItem {
  final String id;
  final String name;
  int value;
  final DateTime createdAt;

  CounterItem({
    required this.id,
    required this.name,
    this.value = 0,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Copy constructor untuk immutability support
  CounterItem copyWith({
    String? id,
    String? name,
    int? value,
    DateTime? createdAt,
  }) {
    return CounterItem(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CounterItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CounterItem(id: $id, name: $name, value: $value)';
  }
}
