import 'package:flutter/material.dart';

import '../onboarding/onboarding_screen.dart';

enum FakeGoogleSignInMode { google, email }

class FakeGoogleSignInScreen extends StatefulWidget {
  const FakeGoogleSignInScreen({super.key});

  static const String routeName = '/auth/signing';

  @override
  State<FakeGoogleSignInScreen> createState() => _FakeGoogleSignInScreenState();
}

class _FakeGoogleSignInScreenState extends State<FakeGoogleSignInScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _check;

  @override
  void initState() {
    super.initState();

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _check = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    Future<void>.delayed(const Duration(milliseconds: 1400), () async {
      if (!mounted) return;
      await _check.forward();
      if (!mounted) return;
      await Future<void>.delayed(const Duration(milliseconds: 550));
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _check.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mode = (ModalRoute.of(context)?.settings.arguments
            as FakeGoogleSignInMode?) ??
        FakeGoogleSignInMode.google;

    final label = mode == FakeGoogleSignInMode.google
        ? 'Signing in with Google...'
        : 'Signing in with email...';

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([_pulse, _check]),
                builder: (context, _) {
                  final p = _pulse.value;
                  final c = _check.value;

                  final ring = 90.0 + 16.0 * p;
                  final core = 44.0;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: ring,
                        height: ring,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF2F6BFF)
                              .withValues(alpha: 0.10 + 0.10 * (1 - p)),
                        ),
                      ),
                      Container(
                        width: ring - 18,
                        height: ring - 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF00D7A1)
                              .withValues(alpha: 0.08 + 0.08 * p),
                        ),
                      ),
                      Container(
                        width: core,
                        height: core,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2F6BFF),
                        ),
                      ),
                      if (c > 0)
                        Transform.scale(
                          scale: 0.8 + 0.2 * c,
                          child: Opacity(
                            opacity: c,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color:
                                    Colors.black.withValues(alpha: 0.04 + 0.06 * c),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 36,
                                color: Color(0xFF2F6BFF),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black.withValues(alpha: 0.60)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
