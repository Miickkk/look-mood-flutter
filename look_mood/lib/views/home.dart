import 'dart:math';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController? _controller; // ✅ controller opcional

  final Color roxoPrincipal = const Color(0xFF6137DE);
  final Color roxoEscuro = const Color(0xFF241536);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller?.dispose(); // ✅ seguro
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: roxoEscuro,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  padding: const EdgeInsets.all(8),
                  children: [
                    _buildCard(Icons.home, 'Home', 0),
                    _buildCard(Icons.search, 'Buscar', 1),
                    _buildCard(Icons.library_music, 'Playlist', 2),
                    _buildCard(Icons.explore, 'Explorar', 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: roxoPrincipal.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 2,
              ),
          ],
          gradient: LinearGradient(
            colors: isSelected
                ? [roxoPrincipal.withOpacity(0.9), roxoEscuro.withOpacity(0.8)]
                : [roxoEscuro, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected && _controller != null)
              AnimatedBuilder(
                animation: _controller!,
                builder: (context, _) {
                  final shift = sin(_controller!.value * pi);

                  // Aurora boreal estilosa 💜💙
                  return CustomPaint(
                    size: const Size(double.infinity, double.infinity),
                    painter: AuroraPainter(shift: shift),
                  );
                },
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 🌌 Painter do efeito aurora
class AuroraPainter extends CustomPainter {
  final double shift;

  AuroraPainter({required this.shift});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.purpleAccent.withOpacity(0.3 + shift * 0.2),
          Colors.blueAccent.withOpacity(0.2 + shift * 0.2),
          Colors.tealAccent.withOpacity(0.15),
        ],
        begin: Alignment(-1 + shift, -1),
        end: Alignment(1 - shift, 1),
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant AuroraPainter oldDelegate) =>
      oldDelegate.shift != shift;
}
