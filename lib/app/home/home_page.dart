import 'package:controla/app/home/contrahents/contrahents_page_content.dart';
import 'package:controla/app/home/my_account/my_accout_page_content.dart';
import 'package:controla/app/home/value/value_page_conent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Controla')),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const ContrahentsPageContent();
        }
        if (currentIndex == 1) {
          return ValuePageContent(onSave : (){
            setState(() {
              currentIndex = 0;
            });
          });
        }
        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Zamówienia',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Dodaj zamówienie'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Moje konto'),
        ],
      ),
    );
  }
}


