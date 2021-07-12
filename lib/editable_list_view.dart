import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnMovedCallback<T> = void Function(T item, int oldIndex, int newIndex);
typedef OnAddedCallback<T> = void Function(T item, int index);
typedef OnRemovedCallback<T> = void Function(T item, int index);
typedef OnChangedCallback<T> = void Function(List<T> items);
typedef TileBuilder<T> = Widget Function(T item, int index);

class EditableListView<T> extends StatelessWidget {
  late final List<T> _items;
  final TileBuilder<T> tileBuilder;
  final OnMovedCallback<T>? onMoved;
  final OnAddedCallback<T>? onAdded;
  final OnRemovedCallback<T>? onRemoved;
  final OnChangedCallback<T>? onChanged;

  EditableListView({
    Key? key,
    required items,
    required this.tileBuilder,
    this.onMoved,
    this.onAdded,
    this.onRemoved,
    this.onChanged,
  }) : super(key: key) {
    _items = items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: ReorderableListView(
        onReorder: onReorder,
        children: _getListItems(),
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = _items[oldIndex];
    _items.removeAt(oldIndex);
    _items.insert(newIndex, item);

    if (onMoved != null) onMoved!(item, oldIndex, newIndex);
    if (onChanged != null) onChanged!([..._items]);
  }

  List<Widget> _getListItems() =>
      _items.asMap().map((i, item) => MapEntry(i, _buildTenableListTile(item, i))).values.toList();

  Widget _buildTenableListTile(T item, int index) {
    return Dismissible(
      key: Key('item $index'),
      onDismissed: (direction) {
        _items.removeAt(index);
        if (onRemoved != null) onRemoved!(item, index);
        if (onChanged != null) onChanged!([..._items]);
      },
      background: Container(color: Colors.red),
      child: tileBuilder(item, index),
    );
  }
}
