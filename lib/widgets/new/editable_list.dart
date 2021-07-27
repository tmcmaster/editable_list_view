import 'package:editable_list_view/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditableList extends ConsumerWidget {
  EditableList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final todos = watch(todoListProvider);
    final notifier = context.read(todoListProvider.notifier);
    print('Building list');
    return Container(
        child: ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        notifier.move(oldIndex, newIndex);
      },
      children: todos
          .map((item) => CheckboxListTile(
                key: ValueKey(item),
                shape: CircleBorder(),
                controlAffinity: ListTileControlAffinity.leading,
                secondary: Icon(Icons.menu),
                value: item.completed,
                title: Text(item.description),
                onChanged: (done) {
                  notifier.toggle(item.id);
                },
              ))
          .toList(),
    ));
  }
}
