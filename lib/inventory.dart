import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prepping_penguin/add_inventory.dart';
import 'package:prepping_penguin/inventory_detail.dart';
import 'package:prepping_penguin/inventory_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  
  List<Inventory> _items = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

// Get all items from the database
  Future<void> _refreshItems() async {
    LazyBox<Inventory> invBox = Hive.lazyBox('inventory');
    debugPrint('got Box');
    invBox.isEmpty ? debugPrint('box is empty') : debugPrint('box is not empty');
    if (invBox.isNotEmpty) {
      for(int i = 0; i < invBox.length; i++) {
        debugPrint(invBox.length.toString());
        invBox.isOpen ? debugPrint('box is open') : debugPrint('box is closed');
        var inventoryItem = await invBox.getAt(i);
        debugPrint(inventoryItem!.name);
        inventoryItem == null ? debugPrint('inv item is null') : debugPrint('inv item is not null');
        inventoryItem == null ? null : _items.add(inventoryItem);
        debugPrint('added item');
        debugPrint(_items.length.toString());
        debugPrint(_items.first.name);
      }
      debugPrint('first element name: ');
      debugPrint(_items.first.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    
      if(_items.isNotEmpty) {
        return ListView.builder(
        //shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index].name),
            subtitle: Text("${_items[index].quantity} ${_items[index].expiration}"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InventoryDetail(inventory: _items[index]),
            ),
          );
        }
        );
      },
    );
    } else {
      return 
        const AddInventoryPage();
    }
  }
}