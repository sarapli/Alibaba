import 'dart:ui';

import 'package:flutter/material.dart';

import '../../widgets/animated_tilt.dart';
import 'fake_google_signin_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const String routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _slide;

  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<double>(begin: 14, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          const _AnimatedBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(0, _slide.value),
                    child: FadeTransition(
                      opacity: _fade,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).maybePop(),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Welcome to',
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.black.withValues(alpha: 0.65),
                            ),
                          ),
                          Text(
                            'Alimama',
                            style: textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Sign in with email or Google.',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.black.withValues(alpha: 0.65),
                            ),
                          ),
                          const Spacer(),
                          AnimatedTilt(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.82),
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color:
                                          Colors.black.withValues(alpha: 0.06),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          hintText: 'Email',
                                          prefixIcon: Icon(Icons.email_outlined),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: double.infinity,
                                        child: FilledButton(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            Navigator.of(context).pushNamed(
                                              FakeGoogleSignInScreen.routeName,
                                              arguments:
                                                  FakeGoogleSignInMode.email,
                                            );
                                          },
                                          child: const Text('Continue with email'),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: double.infinity,
                                        child: OutlinedButton.icon(
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            Navigator.of(context).pushNamed(
                                              FakeGoogleSignInScreen.routeName,
                                              arguments:
                                                  FakeGoogleSignInMode.google,
                                            );
                                          },
                                          icon: const Icon(Icons.g_mobiledata),
                                          label:
                                              const Text('Continue with Google'),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'No Facebook login.',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: Colors.black
                                              .withValues(alpha: 0.55),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatefulWidget {
  const _AnimatedBackground();

  @override
  State<_AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<_AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.9 + t * 0.4, -1),
              end: Alignment(1, 0.8 - t * 0.4),
              colors: const [
                Color(0xFFF3F6FF),
                Color(0xFFEFFAF7),
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: -80 + 40 * t,
                top: 90 - 30 * t,
                child: _Blob(
                  color: const Color(0xFF2F6BFF).withValues(alpha: 0.18),
                  size: 220,
                ),
              ),
              Positioned(
                right: -90 + 30 * t,
                bottom: 120 - 20 * t,
                child: _Blob(
                  color: const Color(0xFF00D7A1).withValues(alpha: 0.14),
                  size: 260,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 26, sigmaY: 26),
        child: Container(
          width: size,
          height: size,
          color: color,
        ),
      ),
    );
  }
}
