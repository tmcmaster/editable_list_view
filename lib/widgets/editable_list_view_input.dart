import 'package:editable_list_view/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditableListViewInput extends HookWidget {
  final _addTodoKey = UniqueKey();

  EditableListViewInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _newTodoController = useTextEditingController();
    final listNotifier = useContext().read(todoListProvider.notifier);
    final inputFocusNode = useFocusNode();
    inputFocusNode.requestFocus();
    return TextField(
      key: _addTodoKey,
      focusNode: inputFocusNode,
      controller: _newTodoController,
      decoration: const InputDecoration(
        labelText: 'Add new item',
      ),
      onSubmitted: (value) {
        listNotifier.add(value);
        _newTodoController.clear();
        inputFocusNode.requestFocus();
      },
    );
  }
}
