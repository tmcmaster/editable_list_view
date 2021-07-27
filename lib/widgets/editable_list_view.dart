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

        // body: CustomScrollView(
        //   slivers: [
        //     SliverToBoxAdapter(
        //       child: Expanded(
        //         child: ReorderableListView(
        //           onReorder: (oldIndex, newIndex) {},
        //           children: todos
        //               .asMap()
        //               .entries
        //               .map((e) => Dismissible(
        //                     background: Container(color: Colors.red),
        //                     key: ValueKey(e.value.id),
        //                     onDismissed: (_) {
        //                       context.read(todoListProvider.notifier).remove(e.value);
        //                     },
        //                     child: TodoItem(index: e.key),
        //                   ))
        //               .toList(),
        //         ),
        //       ),
        //     )
        //   ],
        // ),

        // body: ReorderableListView(
        //   onReorder: (oldIndex, newIndex) {},
        //   children: todos
        //       .asMap()
        //       .entries
        //       .map((e) => Dismissible(
        //             background: Container(color: Colors.red),
        //             key: ValueKey(e.value.id),
        //             onDismissed: (_) {
        //               context.read(todoListProvider.notifier).remove(e.value);
        //             },
        //             child: TodoItem(index: e.key),
        //           ))
        //       .toList(),
        // ),

        // body: CustomScrollView(
        //   // 3
        //   slivers: <Widget>[
        //     // SliverAppBar(
        //     //   pinned: true,
        //     //   snap: true,
        //     //   floating: true,
        //     //   expandedHeight: 160.0,
        //     //   flexibleSpace: const FlexibleSpaceBar(
        //     //     title: Text('SliverAppBar'),
        //     //     background: FlutterLogo(),
        //     //   ),
        //     // ),
        //     SliverFixedExtentList(
        //       // 5
        //       itemExtent: 80,
        //       // 6
        //       delegate: SliverChildBuilderDelegate(
        //         (context, i) => Dismissible(
        //           background: Container(color: Colors.red),
        //           key: ValueKey(todos[i].id),
        //           onDismissed: (_) {
        //             context.read(todoListProvider.notifier).remove(todos[i]);
        //           },
        //           child: TodoItem(index: i),
        //         ),
        //         childCount: todos.length,
        //       ),
        //     ),
        //     // SliverToBoxAdapter(
        //     //   child: Expandable(
        //     //     collapsed: Text('Completed Items'),
        //     //     expanded: Text('Items'),
        //     //   ),
        //     // )
        //   ],
        // ),
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
        ));

    // Container(
    //   child: Column(
    //     children: [
    //       Container(
    //         padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
    //         child: Visibility(
    //           visible: addMode,
    //           child: Column(
    //             children: [
    //               //EditableListViewTitle(),
    //               EditableListViewInput(),
    //             ],
    //           ),
    //         ),
    //       ),
    //       // Container(
    //       //   padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
    //       //   child: EditableListViewToolbar(),
    //       // ),
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: todos.length,
    //           itemBuilder: (context, i) => Dismissible(
    //             key: ValueKey(todos[i].id),
    //             onDismissed: (_) {
    //               context.read(todoListProvider.notifier).remove(todos[i]);
    //             },
    //             child: TodoItem(index: i),
    //           ),
    //         ),
    //       ),
    //
    //       ,
    //       Container(
    //         decoration: BoxDecoration(
    //           border: Border(
    //             top: BorderSide(width: 2.0, color: Colors.grey.shade400),
    //           ),
    //         ),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Container(
    //               margin: EdgeInsets.symmetric(vertical: 15),
    //               decoration: BoxDecoration(
    //                 color: theme.colorScheme.primary,
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(20),
    //                 ),
    //               ),
    //               width: 200,
    //               child: TextButton(
    //                 onPressed: () {
    //                   context.read(_addMode).state = !context.read(_addMode).state;
    //                   print('Read Mode: ${context.read(_addMode).state}');
    //                 },
    //                 child: Text(
    //                   (context.read(_addMode).state == false ? '+ Add Item' : 'Done'),
    //                   style: TextStyle(color: theme.colorScheme.onPrimary),
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // );
  }

  // Widget buildHold(BuildContext context) {
  //   final todos = useProvider(filteredTodos);
  //
  //   return GestureDetector(
  //     onTap: () => FocusScope.of(context).unfocus(),
  //     child: Scaffold(
  //       body: ListView(
  //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
  //         children: [
  //           EditableListViewTitle(),
  //           EditableListViewInput(),
  //           SizedBox(height: 42),
  //           EditableListViewToolbar(),
  //           for (var i = 0; i < todos.length; i++) ...[
  //             Dismissible(
  //               key: ValueKey(todos[i].id),
  //               onDismissed: (_) {
  //                 context.read(todoListProvider.notifier).remove(todos[i]);
  //               },
  //               child: TodoItem(index: i),
  //             )
  //           ],
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
