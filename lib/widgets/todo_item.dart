import 'package:editable_list_view/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TodoItem extends HookWidget {
  final int index;

  TodoItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building item $index');
    final todo = useProvider(currentTodo(index));
    final itemFocusNode = useFocusNode();
    // listen to focus chances
    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Container(
      height: double.infinity,
      //color: (index % 2 == 0 ? Colors.white60 : Colors.grey.shade300),
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            // Commit changes only when the textfield is unfocused, for performance
            context.read(todoListProvider.notifier).edit(
                  id: todo.id,
                  description: textEditingController.text,
                );
          }
        },
        child: SizedBox(
          child: ListTile(
            //tileColor: Colors.yellow,
            onTap: () {
              itemFocusNode.requestFocus();
              textFieldFocusNode.requestFocus();
            },
            leading: Container(
              padding: EdgeInsets.only(top: 6),
              //color: Colors.purple,
              child: Checkbox(
                fillColor: MaterialStateProperty.all(Colors.grey.shade400),
                value: todo.completed,
                onChanged: (value) => context.read(todoListProvider.notifier).toggle(todo.id),
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.fromLTRB(10, 18, 0, 0),
              child: Icon(Icons.menu),
            ),
            title: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 0),
              decoration: BoxDecoration(
                //color: Colors.yellow,
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              child: isFocused && !todo.completed
                  ? Container(
                      padding: EdgeInsets.only(top: 16),
                      child: TextField(
                        enabled: !todo.completed,
                        autofocus: true,
                        focusNode: textFieldFocusNode,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          fillColor: Colors.red,
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          todo.description,
                          //style: TextStyle(backgroundColor: Colors.red),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
