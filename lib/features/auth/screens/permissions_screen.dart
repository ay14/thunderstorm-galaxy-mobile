import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/theme/app_theme.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _cameraGranted = false;
  bool _notificationsGranted = false;

  Future<void> _requestCamera() async {
    final status = await Permission.camera.request();
    setState(() => _cameraGranted = status.isGranted);
  }

  Future<void> _requestNotifications() async {
    final status = await Permission.notification.request();
    setState(() => _notificationsGranted = status.isGranted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _StepIndicator(current: 2),
              const SizedBox(height: 32),
              Text('Enable Permissions', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text(
                'For the best experience with MotoGenius',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface.withOpacity(0.6)),
              ),
              const SizedBox(height: 40),
              _PermissionTile(
                icon: Icons.qr_code_scanner_rounded,
                title: 'Camera',
                subtitle: 'Scan barcodes to update stock instantly',
                granted: _cameraGranted,
                onAllow: _requestCamera,
              ),
              const SizedBox(height: 16),
              _PermissionTile(
                icon: Icons.notifications_rounded,
                title: 'Notifications',
                subtitle: 'Get low-stock alerts before you run out',
                granted: _notificationsGranted,
                onAllow: _requestNotifications,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.dashboard),
                child: const Text('Continue to Dashboard'),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.dashboard),
                  child: Text(
                    'Skip for now',
                    style: TextStyle(color: AppColors.onSurface.withOpacity(0.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.granted,
    required this.onAllow,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool granted;
  final VoidCallback onAllow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: granted ? AppColors.success : const Color(0xFF2A2A4A),
          width: granted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: granted ? AppColors.success.withOpacity(0.15) : AppColors.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: granted ? AppColors.success : AppColors.electric, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface.withOpacity(0.6), fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          granted
              ? const Icon(Icons.check_circle_rounded, color: AppColors.success)
              : OutlinedButton(
                  onPressed: onAllow,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(72, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Allow'),
                ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    const total = 3;
    return Row(
      children: List.generate(total, (i) {
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: i < total - 1 ? 4 : 0),
            decoration: BoxDecoration(
              color: i <= current ? AppColors.electric : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
