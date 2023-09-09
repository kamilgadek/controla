import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ValuePageContent extends StatefulWidget {
  const ValuePageContent({
    super.key,
  });

  @override
  State<ValuePageContent> createState() => _ValuePageContentState();
}

class _ValuePageContentState extends State<ValuePageContent> {
  var contrahentsName = '';
  var materialName = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Podaj nazwę kontrahenta',
            ),
            onChanged: (newValue) {
              setState(() {
                contrahentsName = newValue;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Podaj nazwę materiału',
            ),
            onChanged: (newValue) {
              setState(() {
                materialName = newValue;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('contrahents').add({
                'name' : contrahentsName,
                'material' : materialName,
                'value' : 4.0,
              });
            },
            child: const Text('Dodaj'),
          ),
        ],
      ),
    );
  }
}
