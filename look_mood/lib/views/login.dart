import 'package:look_mood/views/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}


class _LoginViewState extends State<LoginView> {
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;

  bool _senhaOculta = true;

  void _login() async {
    try {
      await _authController.signInWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF241536),
          content: Text("Falha ao fazer login: $e"),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final Color roxoPrincipal = const Color(0xFF6137DE);
    final Color roxoClaro = Colors.deepPurpleAccent;


    return Scaffold(
      backgroundColor: const Color(0xFF241536),
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: roxoPrincipal,
        elevation: 4,
      ),


      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),


                TextField(
                  controller: _emailField,
                  cursorColor: roxoPrincipal,
                  style: TextStyle(
                    color: roxoPrincipal,
                    fontWeight: FontWeight.w600,
                  ),


                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF241536).withOpacity(0.6),
                    labelText: "Email",
                    labelStyle: TextStyle(color: roxoClaro),
                    floatingLabelStyle: TextStyle(color: roxoPrincipal),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: roxoPrincipal,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: roxoPrincipal, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: roxoClaro, width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),


                const SizedBox(height: 20),


                TextField(
                  controller: _senhaField,
                  obscureText: _senhaOculta,
                  cursorColor: roxoPrincipal,
                  style: TextStyle(
                    color: roxoPrincipal,
                    fontWeight: FontWeight.w600,
                  ),


                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF241536).withOpacity(0.6),
                    labelText: "Senha",
                    labelStyle: TextStyle(color: roxoClaro),
                    floatingLabelStyle: TextStyle(color: roxoPrincipal),
                    prefixIcon: Icon(Icons.lock_outline, color: roxoPrincipal),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _senhaOculta = !_senhaOculta;
                        });
                      },
                      icon: Icon(
                        _senhaOculta
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: roxoPrincipal,
                      ),
                    ),


                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: roxoPrincipal, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: roxoClaro, width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),


                const SizedBox(height: 30),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: roxoPrincipal,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                    ),
                    onPressed: _login,
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 10),


                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterView(),
                    ),
                  ),
                  child: Text(
                    "Não tem uma conta? Registre-se!",
                    style: TextStyle(
                      color: roxoPrincipal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}