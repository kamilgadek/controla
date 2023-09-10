import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Witaj !',
                style: GoogleFonts.poppins(
                    fontSize: 28, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Text(
                isCreatingAccount == true
                    ? 'Zarejestruj się'
                    : 'Proszę wprowadź swoje dane',
                style: GoogleFonts.poppins(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: widget.emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 23, 23, 23),
                  ),
                ),
              ),
              TextField(
                controller: widget.passwordController,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  hintText: 'Hasło',
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 23, 23, 23),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromARGB(255, 23, 23, 23),
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(errorMessage),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    //rejestracja
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  } else {
                    //logowanie
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  ),
                  minimumSize: const Size (
                    double.infinity,
                    0,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30, ),
                  child: Text(isCreatingAccount == true
                      ? 'Zarejestruj się'
                      : 'Zaloguj się'),
                ),
              ),
              const SizedBox(height: 20),
              if (isCreatingAccount == false) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Nie masz konta?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isCreatingAccount = true;
                        });
                      },
                      
                      child: Text('Zarejestruj się',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 23, 23, 23),
                      ),
                      ),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 120),
              if (isCreatingAccount == true) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text ('Masz juz konto?'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isCreatingAccount = false;
                        });
                      },
                      child: Text('Zaloguj się',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 23, 23, 23),
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
