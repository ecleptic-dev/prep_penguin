import 'package:flutter/material.dart';
import 'package:prepping_penguin/inventory_model.dart';

class InventoryDetail extends StatelessWidget {
  const InventoryDetail({super.key, required this.inventory});

  // Declare a field that holds the Todo.
  final Inventory inventory;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(inventory.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            children: [
              Text(inventory.quantity,
                style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: inventory.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}