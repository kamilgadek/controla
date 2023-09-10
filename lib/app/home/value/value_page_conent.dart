import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ValuePageContent extends StatefulWidget {
  const ValuePageContent({
    super.key,
    required this.onSave
  });

  final Function onSave ;

  @override
  State<ValuePageContent> createState() => _ValuePageContentState();
}

class _ValuePageContentState extends State<ValuePageContent> {
  var contrahentsName = '';
  var materialName = '';
  var value = 1.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
            Slider(
              min: 0.5,
              max: 400.0,
              divisions: (400.0 - 0.5) ~/ 0.5,
              value: value,
              label: value.toString(),
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: contrahentsName.isEmpty || materialName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('contrahents').add({
                        'name': contrahentsName,
                        'material': materialName,
                        'value': 4.0,
                      });
                      widget.onSave();
                    },
              child: const Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}
