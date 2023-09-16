import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValuePageContent extends StatefulWidget {
  const ValuePageContent({super.key, required this.onSave});

  final Function onSave;

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
              decoration: InputDecoration(
                hintText: 'Podaj nazwę kontrahenta',
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 23, 23, 23),
                  ),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  contrahentsName = newValue;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Podaj nazwę materiału',
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 23, 23, 23),
                  ),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  materialName = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Podaj ilość opakowań:',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 23, 23, 23),
              ),
            ),
            Slider(
              min: 0.5,
              max: 400.0,
              divisions: ((400.0 - 0.5) ~/ 0.5).toInt(),
              value: value,
              label: value.toString(),
              onChanged: (newValue) {
                setState(() {
                  value = (newValue * 2).round() / 2;
                });
              },
              activeColor: Colors.black,
              inactiveColor: const Color.fromARGB(255, 189, 182, 182),
            ),
            ElevatedButton(
              onPressed: contrahentsName.isEmpty || materialName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('contrahents').add({
                        'name': contrahentsName,
                        'material': materialName,
                        'value': value,
                        "created_at": FieldValue.serverTimestamp(),
                      });
                      widget.onSave();
                    },
                    style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                    ),
              child: const Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}
