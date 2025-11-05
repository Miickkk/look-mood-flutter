import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}


class _RegisterViewState extends State<RegisterView> {
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confSenhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;


  bool _senhaOculta = true;
  bool _confSenhaOculta = true;


  void _registrar() async {
    if (_senhaField.text != _confSenhaField.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF241536),
          content: const Text("As senhas não coincidem"),
        ),
      );
      return;
    }


    try {
      await _authController.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF241536),
          content: Text("Falha ao registrar: $e"),
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
          "Registrar",
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
                    prefixIcon: Icon(Icons.email_outlined, color: roxoPrincipal),
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


                const SizedBox(height: 20),


                TextField(
                  controller: _confSenhaField,
                  obscureText: _confSenhaOculta,
                  cursorColor: roxoPrincipal,
                  style: TextStyle(
                    color: roxoPrincipal,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF241536).withOpacity(0.6),
                    labelText: "Confirmar Senha",
                    labelStyle: TextStyle(color: roxoClaro),
                    floatingLabelStyle: TextStyle(color: roxoPrincipal),
                    prefixIcon: Icon(Icons.lock_outline, color: roxoPrincipal),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _confSenhaOculta = !_confSenhaOculta;
                        });
                      },
                      icon: Icon(
                        _confSenhaOculta
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
                    onPressed: _registrar,
                    child: const Text(
                      "Registrar",
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
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Já tem uma conta? Faça login!",
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
