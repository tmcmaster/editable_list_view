part of 'examples.dart';

final itemsProvider = Provider<List<String>>((ref) => ['A', 'B', 'C', 'D', 'E', 'F']);

class EditableListViewExamplesBuilder extends ExamplesBuilder {
  EditableListViewExamplesBuilder()
      : super(
          name: 'Editable List View',
          columns: 1,
          build: () => [
            //EditableList(),
            EditableListView(),
          ],
        );
}

// class EditableListViewExamplesBuilder extends ExamplesBuilder {
//   EditableListViewExamplesBuilder()
//       : super(
//           name: 'Editable List View',
//           columns: 1,
//           build: () => [
//             EditableListView<String>(
//               itemsProvider: itemsProvider,
//               tileBuilder: (item, index) => ListTile(
//                 tileColor: (index % 2 == 0 ? Colors.white : Colors.grey.shade200),
//                 key: ValueKey('item $index'),
//                 title: Text(
//                   '$item',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 trailing: Icon(Icons.drag_handle_rounded),
//               ),
//               onChanged: (items) => print('onChanged: $items'),
//               onAdded: (item, index) => print('onAdded: $item at $index'),
//               onRemoved: (item, index) => print('onRemoved: $item at $index'),
//               onMoved: (item, from, to) => print('onMoved: $item from $from to $to'),
//             ),
//           ],
//         );
// }
