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
  
  final List<Inventory> _items = [];

  @override
  void initState() {
    super.initState();
    _refreshItems();
  }

// Get all items from the database
  Future<List<Inventory>> _refreshItems() async {
    LazyBox<Inventory> invBox = Hive.lazyBox('inventory');
    debugPrint('got Box');
    invBox.isEmpty ? debugPrint('box is empty') : debugPrint('box is not empty');
    if (invBox.isNotEmpty) {
      for(int i = 0; i < invBox.length; i++) {
        debugPrint(invBox.length.toString());
        invBox.isOpen ? debugPrint('box is open') : debugPrint('box is closed');
        var inventoryItem = await invBox.getAt(i);
        debugPrint(inventoryItem!.name);
        _items.add(inventoryItem);
        debugPrint('added item');
        debugPrint(_items.length.toString());
      }
    }
    return _items;
  }

@override
  Widget build(BuildContext context) {
    return 
    FutureBuilder<List<Inventory>>(
      future: _refreshItems(),
      builder: (context, snapshot) {
        if(snapshot.data == null || snapshot.data!.isEmpty) {
          debugPrint('empty');
          return const AddInventoryPage();
        }
        else if (snapshot.hasData) {
          return 
          Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddInventoryPage(),
                      )
                    );
                  }
                ),
              ]
            ),
            body: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].expiration),
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
            ),
          );          
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },
);  
}
}