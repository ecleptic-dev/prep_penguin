import 'package:flutter/material.dart';

class DisasterSuppliesPage extends StatelessWidget {
  const DisasterSuppliesPage({super.key});

  @override
  Widget build(BuildContext context) {
    

    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('You have 0 disasters:'),
        ),
      ],
    );
  }
}