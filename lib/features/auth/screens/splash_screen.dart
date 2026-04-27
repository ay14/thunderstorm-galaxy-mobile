import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/config/splash_config.dart';
import '../../../app/routes/app_router.dart';
import '../providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: SplashConfig.animationDuration,
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward().then((_) {
      // Remove native splash after Flutter animation starts
      FlutterNativeSplash.remove();
    });

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(
      SplashConfig.animationDuration + SplashConfig.holdDuration,
    );
    if (!mounted) return;
    final auth = ref.read(authStateProvider);
    if (auth.token == null) {
      context.go(AppRoutes.onboarding);
    } else if (auth.user?.onboardingCompleted == false) {
      context.go(AppRoutes.profileSetup);
    } else {
      context.go(AppRoutes.dashboard);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SplashConfig.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: SplashConfig.gradientColors,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: ScaleTransition(
              scale: _scale,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Logo(),
                  const SizedBox(height: 28),
                  _AppName(),
                  const SizedBox(height: 8),
                  _Tagline(),
                  const SizedBox(height: 32),
                  _ProgressBar(progress: _progress),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SplashConfig.logoSize,
      height: SplashConfig.logoSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: SplashConfig.logoGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(SplashConfig.logoBorderRadius),
        boxShadow: [
          BoxShadow(
            color: SplashConfig.logoShadowColor.withOpacity(0.5),
            blurRadius: SplashConfig.logoShadowBlur,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SplashConfig.logoAsset != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(SplashConfig.logoBorderRadius),
              child: Image.asset(SplashConfig.logoAsset!, fit: BoxFit.contain),
            )
          : Icon(
              Icons.bolt_rounded,
              color: Colors.white,
              size: SplashConfig.logoIconSize,
            ),
    );
  }
}

class _AppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      SplashConfig.appName,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
            letterSpacing: 1.5,
            foreground: Paint()
              ..shader = LinearGradient(
                colors: [Colors.white, SplashConfig.taglineColor],
              ).createShader(const Rect.fromLTWH(0, 0, 200, 50)),
          ),
    );
  }
}

class _Tagline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      SplashConfig.tagline,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: SplashConfig.taglineColor.withOpacity(0.8),
            letterSpacing: 2,
          ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              width: SplashConfig.progressBarWidth,
              height: SplashConfig.progressBarHeight,
              decoration: BoxDecoration(
                color: SplashConfig.progressBarBackgroundColor,
                borderRadius: BorderRadius.circular(SplashConfig.progressBarHeight / 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SplashConfig.progressBarHeight / 2),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: SplashConfig.progressBarWidth * progress.value,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: SplashConfig.progressBarGradient,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(SplashConfig.progressBarHeight / 2),
                          boxShadow: [
                            BoxShadow(
                              color: SplashConfig.progressBarGradient.first.withOpacity(0.6),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress.value * 100).toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: SplashConfig.taglineColor.withOpacity(0.6),
                    letterSpacing: 1,
                  ),
            ),
          ],
        );
      },
    );
  }
}
