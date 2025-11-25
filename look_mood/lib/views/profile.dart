import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PerfilView extends StatefulWidget {
  final String nome;
  final String email;
  final int quantidadeAmigos;

  const PerfilView({
    super.key,
    required this.nome,
    required this.email,
    required this.quantidadeAmigos,
  });

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Color roxoPrincipal = const Color(0xFF6137DE);
  final Color roxoEscuro = const Color(0xFF241536);

  String abaSelecionada = "Email";

  // EDITÁVEIS
  String nome = "";
  String email = "";
  File? fotoPerfil;

  List<String> musicas = ["Pop", "Trap"];
  List<String> looks = ["Street", "Casual"];

  @override
  void initState() {
    super.initState();
    nome = widget.nome;
    email = widget.email;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  Future<void> _trocarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() => fotoPerfil = File(imagem.path));
    }
  }

  void _editarPerfil() {
    final nomeController = TextEditingController(text: nome);
    final emailController = TextEditingController(text: email);

    showModalBottomSheet(
      context: context,
      backgroundColor: roxoEscuro.withOpacity(0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Editar Perfil",
                style: GoogleFonts.lora(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Nome
              TextField(
                controller: nomeController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Nome",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: roxoPrincipal),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Email
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: roxoPrincipal),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: roxoPrincipal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    nome = nomeController.text;
                    email = emailController.text;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAba(String nomeAba) {
    final ativo = abaSelecionada == nomeAba;

    return GestureDetector(
      onTap: () => setState(() => abaSelecionada = nomeAba),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: ativo ? roxoPrincipal : Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ativo ? Colors.white : Colors.white24,
            width: 1.3,
          ),
        ),
        child: Text(
          nomeAba,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _conteudoDaAba() {
    switch (abaSelecionada) {
      case "Email":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nome:",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              nome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              "Email:",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            Text(
              email,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );

      case "Música":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Suas músicas",
              style: GoogleFonts.lora(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Column(
              children: musicas.map((m) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      m,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () => setState(() => musicas.remove(m)),
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );

      case "Look":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Seus looks",
              style: GoogleFonts.lora(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Column(
              children: looks.map((l) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () => setState(() => looks.remove(l)),
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // FUNDO ANIMADO
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return CustomPaint(
                painter: SmoothMovingBackgroundPainter(
                  animationValue: _controller.value,
                  roxoEscuro: roxoEscuro,
                  roxoPrincipal: roxoPrincipal,
                ),
                child: Container(),
              );
            },
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // 🔙 BOTÃO VOLTAR
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Título
                  Text(
                    "Look & Mood",
                    style: GoogleFonts.cinzelDecorative(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                    ),
                  ),

                  Text(
                    "Perfil",
                    style: GoogleFonts.lora(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // FOTO DE PERFIL (CLICÁVEL)
                  GestureDetector(
                    onTap: _trocarFoto,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: roxoPrincipal,
                      backgroundImage: fotoPerfil != null
                          ? FileImage(fotoPerfil!)
                          : null,
                      child: fotoPerfil == null
                          ? const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 45,
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ✏️ EDITAR PERFIL
                  TextButton(
                    onPressed: _editarPerfil,
                    child: Text(
                      "Editar Perfil",
                      style: GoogleFonts.lora(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Abas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAba("Email"),
                      _buildAba("Música"),
                      _buildAba("Look"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Conteúdo
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withOpacity(0.12),
                      border: Border.all(color: Colors.white24, width: 1.2),
                    ),
                    child: _conteudoDaAba(),
                  ),

                  const SizedBox(height: 25),

                  // Amigos
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Amigos",
                      style: GoogleFonts.lora(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Container(
                    width: 100,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: roxoPrincipal.withOpacity(0.85),
                    ),
                    child: Center(
                      child: Text(
                        widget.quantidadeAmigos.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmoothMovingBackgroundPainter extends CustomPainter {
  final double animationValue;
  final Color roxoPrincipal;
  final Color roxoEscuro;

  SmoothMovingBackgroundPainter({
    required this.animationValue,
    required this.roxoPrincipal,
    required this.roxoEscuro,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double shift = sin(animationValue * 5 * pi) * 0.5 + 0.5;

    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color.lerp(roxoEscuro, roxoPrincipal, shift * 0.6)!,
          Color.lerp(roxoPrincipal, Colors.deepPurpleAccent, shift * 0.4)!,
        ],
        begin: Alignment(-0.5 + shift, -0.8 + shift * 0.4),
        end: Alignment(1.0 - shift * 0.7, 1.0 - shift * 0.5),
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
