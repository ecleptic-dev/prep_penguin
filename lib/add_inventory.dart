import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prepping_penguin/inventory_model.dart';
import 'package:prepping_penguin/main.dart';
import 'package:provider/provider.dart';

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({super.key});

  @override
  AddInventoryState createState() {
    return AddInventoryState();
  }
}

class AddInventoryState extends State<AddInventoryPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String quantity = '';
  String description = '';
  String expiration = '';
  final controllerName = TextEditingController();
  final controllerQuantity = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerExpiration = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerName.dispose();
    controllerQuantity.dispose();
    controllerDescription.dispose();
    controllerExpiration.dispose();
    super.dispose();
  }

void createInventory(String name, String quantity, String description, String expiration) {
  debugPrint('createInventory');
  Inventory inventoryDto = Inventory(name, quantity, description, expiration);

  debugPrint('dto assigned : ${inventoryDto.name} ${inventoryDto.quantity} ${inventoryDto.description} ${inventoryDto.expiration}');
  final inventoryBox = Hive.lazyBox<Inventory>('inventory');
  debugPrint('got box');
  if(inventoryBox.isOpen == true)
  {
    debugPrint('box is open');
    debugPrint(inventoryDto.name);
    debugPrint(inventoryDto.runtimeType.toString());
    inventoryBox.add(inventoryDto).whenComplete(() => debugPrint('success'),).then((value) => debugPrint('val: $value'));
    debugPrint('after add');
  } else {
    debugPrint('box is closed');
  }  
}

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Form(
      key: _formKey,
      child: Consumer<AppModel>(builder: (context, value, child) =>  SafeArea(
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
              child: ElevatedButton(
                onPressed: () {
                  
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    createInventory(controllerName.text, controllerQuantity.text, controllerDescription.text,  controllerExpiration.text);
                    Navigator.popAndPushNamed(context, '/');
                  }
                },
                child: const Text('Add Inventory Item'),
              ),
            ),
          ],
        ),
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
