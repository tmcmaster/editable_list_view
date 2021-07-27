import 'package:editable_list_view/models/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class TodoList extends StateNotifier<List<Todo>> {
  static final _uuid = Uuid();

  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  void move(int oldIndex, newIndex) {
    final list = [...state];
    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    state = list;
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}
