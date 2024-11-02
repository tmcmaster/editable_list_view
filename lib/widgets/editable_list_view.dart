import 'package:editable_list_view/providers/providers.dart';
import 'package:editable_list_view/widgets/editable_list_view_input.dart';
import 'package:editable_list_view/widgets/todo_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditableListView extends ConsumerWidget {
  final _addMode = StateProvider((ref) => false);

  EditableListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todos = watch(todoListProvider);
    final notifier = context.read(todoListProvider.notifier);
    final addMode = watch(_addMode).state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Foodjitsu',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            notifier.move(oldIndex, newIndex);
          },
          children: todos
              .asMap()
              .entries
              .map((e) => Dismissible(
                    background: Container(color: Colors.red),
                    key: ValueKey(e.value.id),
                    onDismissed: (_) {
                      context.read(todoListProvider.notifier).remove(e.value);
                    },
                    child: SizedBox(height: 80, child: TodoItem(index: e.key)),
                  ))
              .toList(),
        ),
      ),
      bottomNavigationBar: Container(
        height: (addMode ? 160 : 110),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 2.0, color: Colors.grey.shade400),
          ),
        ),
        child: Column(
          children: [
            if (addMode)
              SizedBox(
                height: 50,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: EditableListViewInput(),
                ),
              ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          context.read(_addMode).state = !context.read(_addMode).state;
                          print('Read Mode: ${context.read(_addMode).state}');
                        },
                        child: Text(
                          (context.read(_addMode).state == false ? '+ Add Item' : 'Done'),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
