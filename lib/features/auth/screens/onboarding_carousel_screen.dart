import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/theme/app_theme.dart';

class _OnboardingSlide {
  const _OnboardingSlide({required this.icon, required this.title, required this.subtitle, required this.color});

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
}

const _slides = [
  _OnboardingSlide(
    icon: Icons.inventory_2_rounded,
    title: 'Smart Inventory',
    subtitle: 'Track stock levels, scan barcodes, and get low-stock alerts — all in real time.',
    color: AppColors.galaxy,
  ),
  _OnboardingSlide(
    icon: Icons.receipt_long_rounded,
    title: 'Easy Orders',
    subtitle: 'Process orders, manage deliveries, and keep customers updated effortlessly.',
    color: AppColors.storm,
  ),
  _OnboardingSlide(
    icon: Icons.handshake_rounded,
    title: 'Grow Together',
    subtitle: 'Connect with brand partners, manage distribution, and scale your business.',
    color: AppColors.electric,
  ),
];

class OnboardingCarouselScreen extends StatefulWidget {
  const OnboardingCarouselScreen({super.key});

  @override
  State<OnboardingCarouselScreen> createState() => _OnboardingCarouselScreenState();
}

class _OnboardingCarouselScreenState extends State<OnboardingCarouselScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  void _next() {
    if (_currentPage < _slides.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      context.go(AppRoutes.auth);
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
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.auth),
                  child: Text('Skip', style: TextStyle(color: AppColors.onSurface.withOpacity(0.6))),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => _SlidePage(slide: _slides[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == _currentPage ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _currentPage ? AppColors.electric : AppColors.onSurface.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _next,
                    child: Text(_currentPage == _slides.length - 1 ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  const _SlidePage({required this.slide});

  final _OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [slide.color, slide.color.withOpacity(0.6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [BoxShadow(color: slide.color.withOpacity(0.4), blurRadius: 40, offset: const Offset(0, 12))],
            ),
            child: Icon(slide.icon, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 40),
          Text(slide.title, style: Theme.of(context).textTheme.displayMedium, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text(
            slide.subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.onSurface.withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
