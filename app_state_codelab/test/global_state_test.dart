import 'package:flutter_test/flutter_test.dart';
import 'package:app_state_codelab/models/counter_item.dart';
import 'package:app_state_codelab/state/global_state.dart';

void main() {
  group('CounterItem Tests', () {
    test('should create counter item with default values', () {
      final counter = CounterItem(id: '1', name: 'Test Counter');

      expect(counter.id, '1');
      expect(counter.name, 'Test Counter');
      expect(counter.value, 0);
      expect(counter.createdAt, isA<DateTime>());
    });

    test('should create copy with new values', () {
      final original = CounterItem(id: '1', name: 'Original', value: 5);
      final copy = original.copyWith(name: 'Updated', value: 10);

      expect(copy.id, '1');
      expect(copy.name, 'Updated');
      expect(copy.value, 10);
      expect(original.value, 5); // Original should be unchanged
    });
  });

  group('GlobalState Tests', () {
    late GlobalState globalState;

    setUp(() {
      globalState = GlobalState();
    });

    test('should start with empty counters list', () {
      expect(globalState.counters, isEmpty);
      expect(globalState.counterCount, 0);
      expect(globalState.totalValue, 0);
    });

    test('should add counter correctly', () {
      globalState.addCounter(name: 'Test Counter');

      expect(globalState.counterCount, 1);
      expect(globalState.counters.first.name, 'Test Counter');
      expect(globalState.counters.first.value, 0);
    });

    test('should add counter with default name when name is null', () {
      globalState.addCounter();

      expect(globalState.counterCount, 1);
      expect(globalState.counters.first.name, 'Counter 1');
    });

    test('should increment counter correctly', () {
      globalState.addCounter(name: 'Test');
      final counterId = globalState.counters.first.id;

      globalState.incrementCounter(counterId);

      expect(globalState.counters.first.value, 1);
      expect(globalState.totalValue, 1);
    });

    test('should decrement counter correctly', () {
      globalState.addCounter(name: 'Test');
      final counterId = globalState.counters.first.id;

      globalState.incrementCounter(counterId);
      globalState.incrementCounter(counterId);
      globalState.decrementCounter(counterId);

      expect(globalState.counters.first.value, 1);
      expect(globalState.totalValue, 1);
    });

    test('should remove counter correctly', () {
      globalState.addCounter(name: 'Test1');
      globalState.addCounter(name: 'Test2');
      final firstCounterId = globalState.counters.first.id;

      expect(globalState.counterCount, 2);

      globalState.removeCounter(firstCounterId);

      expect(globalState.counterCount, 1);
      expect(globalState.counters.first.name, 'Test2');
    });

    test('should reset counter to zero', () {
      globalState.addCounter(name: 'Test');
      final counterId = globalState.counters.first.id;

      globalState.incrementCounter(counterId);
      globalState.incrementCounter(counterId);
      expect(globalState.counters.first.value, 2);

      globalState.resetCounter(counterId);
      expect(globalState.counters.first.value, 0);
    });

    test('should reset all counters to zero', () {
      globalState.addCounter(name: 'Test1');
      globalState.addCounter(name: 'Test2');

      globalState.incrementCounter(globalState.counters[0].id);
      globalState.incrementCounter(globalState.counters[1].id);
      globalState.incrementCounter(globalState.counters[1].id);

      expect(globalState.totalValue, 3);

      globalState.resetAllCounters();

      expect(globalState.totalValue, 0);
      expect(globalState.counters[0].value, 0);
      expect(globalState.counters[1].value, 0);
    });

    test('should clear all counters', () {
      globalState.addCounter(name: 'Test1');
      globalState.addCounter(name: 'Test2');

      expect(globalState.counterCount, 2);

      globalState.clearAllCounters();

      expect(globalState.counterCount, 0);
      expect(globalState.counters, isEmpty);
    });

    test('should update counter name', () {
      globalState.addCounter(name: 'Original Name');
      final counterId = globalState.counters.first.id;

      globalState.updateCounterName(counterId, 'New Name');

      expect(globalState.counters.first.name, 'New Name');
    });

    test('should calculate total value correctly', () {
      globalState.addCounter(name: 'Counter1');
      globalState.addCounter(name: 'Counter2');
      globalState.addCounter(name: 'Counter3');

      globalState.incrementCounter(globalState.counters[0].id);
      globalState.incrementCounter(globalState.counters[1].id);
      globalState.incrementCounter(globalState.counters[1].id);
      globalState.incrementCounter(globalState.counters[2].id);
      globalState.incrementCounter(globalState.counters[2].id);
      globalState.incrementCounter(globalState.counters[2].id);

      expect(globalState.totalValue, 6); // 1 + 2 + 3 = 6
    });

    test('should get counter by id', () {
      globalState.addCounter(name: 'Test Counter');
      final counterId = globalState.counters.first.id;

      final foundCounter = globalState.getCounterById(counterId);

      expect(foundCounter, isNotNull);
      expect(foundCounter!.name, 'Test Counter');
    });

    test('should return null when counter not found', () {
      final foundCounter = globalState.getCounterById('non-existent-id');

      expect(foundCounter, isNull);
    });
  });
}
