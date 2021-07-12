part of 'examples.dart';

class EditableListViewExamplesBuilder extends ExamplesBuilder {
  EditableListViewExamplesBuilder()
      : super(
          name: 'Editable List View',
          columns: 1,
          build: () => [
            EditableListView<String>(
              items: ['A', 'B', 'C'],
              tileBuilder: (item, index) => ListTile(
                key: ValueKey('item $index'),
                title: Text(
                  'Item $index',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.drag_handle_rounded),
                onTap: () {},
              ),
              onChanged: (items) => print('onChanged: $items'),
              onAdded: (item, index) => print('onAdded: $item at $index'),
              onRemoved: (item, index) => print('onRemoved: $item at $index'),
              onMoved: (item, from, to) => print('onMoved: $item from $from to $to'),
            ),
          ],
        );
}
