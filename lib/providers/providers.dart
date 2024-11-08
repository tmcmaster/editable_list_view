import 'package:editable_list_view/models/todo.dart';
import 'package:editable_list_view/models/todo_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  final generatedList = Iterable.generate(5).map((i) => Todo(id: 'todo=$i', description: 'item $i')).toList();
  return TodoList(generatedList);
});

final todoListFilter = StateProvider((_) => TodoListFilter.all);

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  return todos.where(TodoList.FILTERS[filter]!).toList();

  switch (filter.state) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
    default:
      return todos;
  }
});

// final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());
final currentTodo = Provider.family<Todo, int>((ref, index) => ref.watch(filteredTodos)[index]);
