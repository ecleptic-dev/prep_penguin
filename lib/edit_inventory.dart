import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prepping_penguin/inventory_model.dart';

class EditInventoryPage extends StatelessWidget {
  EditInventoryPage({super.key, required this.inventoryItem})
  {
    controllerName.text = inventoryItem.name;
    controllerQuantity.text = inventoryItem.quantity;
    controllerDescription.text = inventoryItem.description;
    controllerExpiration.text = inventoryItem.expiration;
  }

  final _formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerQuantity = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerExpiration = TextEditingController();
  
  final Inventory inventoryItem;

  void saveInventory(String name, String quantity, String description, String expiration) {
    debugPrint('saveInventory');
    Inventory inventoryDto = Inventory(name, quantity, description, expiration);

    debugPrint('dto assigned : ${inventoryDto.name} ${inventoryDto.quantity} ${inventoryDto.description} ${inventoryDto.expiration}');
    final inventoryBox = Hive.lazyBox<Inventory>('inventory');
    debugPrint('got box');
    if(inventoryBox.isOpen == true)
    {
      debugPrint('box is open');
      debugPrint(inventoryDto.name);
      debugPrint(inventoryDto.runtimeType.toString());
      inventoryBox.put(name, inventoryDto).whenComplete(() => debugPrint('success'),);
      debugPrint('after put');
    } else {
      debugPrint('box is closed');
    }  
  }

  Future<bool> deleteInventory() async {
    final inventoryBox = Hive.lazyBox<Inventory>('inventory');
    await inventoryBox.delete(inventoryItem);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controllerName,
                        decoration: const InputDecoration(labelText: 'Name'),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name';
                          }
                          return null;
                        },
                      ),  
                      TextFormField(
                        controller: controllerQuantity,
                        decoration: const InputDecoration(labelText: 'Quantity'),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantity';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controllerDescription,
                        decoration: const InputDecoration(labelText: 'Description'),
                        keyboardType: TextInputType.multiline,
                        maxLines: 500,
                        minLines: 1,
                        maxLength: 35000,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description';
                          }
                          return null;
                        }
                      ),
                      TextFormField(
                        controller: controllerExpiration,
                        decoration: const InputDecoration(labelText: 'Expiration'),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Expiration';
                          }
                          return null;
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {                
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                saveInventory(controllerName.text, controllerQuantity.text, controllerDescription.text,  controllerExpiration.text);
                                Navigator.pop(context);
                                }
                              },
                              child: const Text('Save'),
                            ),
                            ElevatedButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Confirm'),
                                  content: const Text('Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteInventory();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete'),
                                    )
                                ],
                                ),
                              ), child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}