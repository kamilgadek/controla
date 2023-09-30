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
  var valueName = '';
  
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
                    color: Color.fromARGB(255, 103, 101, 101),
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
                    color: Color.fromARGB(255, 103, 101, 101),
                  ),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  materialName = newValue;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Podaj ilość w m2',
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 103, 101, 101),
                  ),
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  valueName = newValue;
                });
              },
            ),
        
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: contrahentsName.isEmpty ||
                      materialName.isEmpty ||
                      valueName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('contrahents').add({
                        'name': contrahentsName,
                        'material': materialName,
                        'value': valueName,
                        
                      });
                      widget.onSave();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}