import 'package:flutter/material.dart';

class InjuryTreatmentPage extends StatelessWidget {
  const InjuryTreatmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    

    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('You have 0 injuries:'),
        ),
      ],
    );
  }
}