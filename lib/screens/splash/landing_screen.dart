import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../widgets/animated_tilt.dart';
import '../auth/auth_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  static const String routeName = '/';

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _bgParallax;
  late final Animation<double> _heroIn;
  late final Animation<double> _heroTilt;
  late final AnimationController _loop;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _fade = CurvedAnimation(parent: _controller, curve: const Interval(0.15, 1));
    _scale = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _bgParallax = Tween<double>(begin: 18, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _heroIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic)),
    );
    _heroTilt = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.75, curve: Curves.easeOutBack)),
    );

    _loop = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _loop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_controller, _loop]),
            builder: (context, _) {
              final t = _loop.value;
              final x = math.sin(t * math.pi * 2) * 10;
              final y = math.cos(t * math.pi * 2) * 8;

              return Transform.translate(
                offset: Offset(x, y + _bgParallax.value),
                child: Transform.scale(
                  scale: 1.04,
                  child: SizedBox.expand(
                    child: Image.asset(
                      'Page accueil.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.6, sigmaY: 1.6),
              child: const SizedBox.shrink(),
            ),
          ),
          SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.10),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _StarfieldPainter(animation: _loop),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 16 + media.padding.bottom),
              child: Column(
                children: [
                  const Spacer(),
                  FadeTransition(
                    opacity: _fade,
                    child: ScaleTransition(
                      scale: _scale,
                      child: AnimatedTilt(
                        child: AnimatedBuilder(
                          animation: Listenable.merge([_controller, _loop]),
                          builder: (context, _) {
                            final t = _loop.value;
                            final floatY = math.sin(t * math.pi * 2) * 6;
                            final floatX = math.cos(t * math.pi * 2) * 4;
                            final inT = _heroIn.value;
                            final tiltT = _heroTilt.value;

                            final heroW = math.min(420.0, size.width);
                            final heroH = heroW * 0.58;

                            final m = Matrix4.identity()
                              ..setEntry(3, 2, 0.0016)
                              ..rotateX(tiltT * 0.22)
                              ..rotateY(-tiltT * 0.18);

                            return Transform.translate(
                              offset: Offset(floatX, floatY),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: m,
                                child: Opacity(
                                  opacity: inT,
                                  child: _HeroCard(
                                    width: heroW,
                                    height: heroH,
                                    sweep: t,
                                    onContinue: () {
                                      Navigator.of(context)
                                          .pushNamed(AuthScreen.routeName);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.width,
    required this.height,
    required this.sweep,
    required this.onContinue,
  });

  final double width;
  final double height;
  final double sweep;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final glow1 = const Color(0xFF2F6BFF).withValues(alpha: 0.45);
    final glow2 = const Color(0xFF00D7A1).withValues(alpha: 0.30);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: glow1,
                    blurRadius: 42,
                    spreadRadius: 8,
                    offset: const Offset(0, 18),
                  ),
                  BoxShadow(
                    color: glow2,
                    blurRadius: 56,
                    spreadRadius: 2,
                    offset: const Offset(0, 26),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.55),
                    blurRadius: 28,
                    offset: const Offset(0, 18),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                children: [
                  SizedBox(
                    width: width,
                    height: height,
                    child: Image.asset(
                      'Page accueil.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.10),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.12),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: _LightSweep(
                      progress: sweep,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.20),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Welcome to Alimama',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.2,
              ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'A spectacular entry experience',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.90),
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    FilledButton(
                      onPressed: onContinue,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LightSweep extends StatelessWidget {
  const _LightSweep({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final p = (progress * 1.15) % 1.0;
    final x = lerpDouble(-1.4, 1.4, p) ?? 0;

    return IgnorePointer(
      child: Transform.translate(
        offset: Offset(x * 220, 0),
        child: Transform.rotate(
          angle: -0.35,
          child: Container(
            width: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.20),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  _StarfieldPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final rnd = _DeterministicRandom(1337);

    final paint = Paint()..style = PaintingStyle.fill;

    for (var i = 0; i < 46; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final phase = rnd.nextDouble();
      final twinkle = 0.45 + 0.55 * math.sin((t + phase) * math.pi * 2);
      final r = 0.6 + rnd.nextDouble() * 1.6;
      final a = (0.06 + rnd.nextDouble() * 0.10) * twinkle;
      paint.color = Colors.white.withValues(alpha: a);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter oldDelegate) => false;
}

class _DeterministicRandom {
  _DeterministicRandom(this._seed);

  int _seed;

  double nextDouble() {
    _seed = 1664525 * _seed + 1013904223;
    final v = (_seed & 0x00FFFFFF) / 0x01000000;
    return v;
  }
}
