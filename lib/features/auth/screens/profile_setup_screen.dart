import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/theme/app_theme.dart';
import '../providers/auth_provider.dart';

enum _UserRole { storeOwner, partner }

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  _UserRole _role = _UserRole.storeOwner;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authStateProvider.notifier).completeOnboarding(
          phone: _phone.text.trim(),
          role: _role == _UserRole.storeOwner ? 'store_owner' : 'partner',
        );
    if (!mounted) return;
    context.go(AppRoutes.companySelection);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _StepIndicator(current: 0),
              const SizedBox(height: 32),
              Text('Set Up Your Profile', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text(
                'Tell us about yourself so we can personalise your experience.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface.withOpacity(0.6)),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined),
                        hintText: '+91 98765 43210',
                      ),
                      validator: (v) => v == null || v.trim().length < 8 ? 'Enter a valid phone number' : null,
                    ),
                    const SizedBox(height: 24),
                    Text('Your Role', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    _RoleTile(
                      icon: Icons.storefront_rounded,
                      title: 'Store Owner',
                      subtitle: 'I run a motorcycle gear shop',
                      selected: _role == _UserRole.storeOwner,
                      onTap: () => setState(() => _role = _UserRole.storeOwner),
                    ),
                    const SizedBox(height: 12),
                    _RoleTile(
                      icon: Icons.local_shipping_rounded,
                      title: 'Partner / Distributor',
                      subtitle: 'I supply products to stores',
                      selected: _role == _UserRole.partner,
                      onTap: () => setState(() => _role = _UserRole.partner),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: state.isLoading ? null : _continue,
                child: state.isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleTile extends StatelessWidget {
  const _RoleTile({required this.icon, required this.title, required this.subtitle, required this.selected, required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? AppColors.galaxy.withOpacity(0.2) : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.electric : const Color(0xFF2A2A4A),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selected ? AppColors.electric.withOpacity(0.2) : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: selected ? AppColors.electric : AppColors.onSurface.withOpacity(0.5)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16)),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface.withOpacity(0.6))),
                ],
              ),
            ),
            if (selected) const Icon(Icons.check_circle_rounded, color: AppColors.electric),
          ],
        ),
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
        final active = i <= current;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: i < total - 1 ? 4 : 0),
            decoration: BoxDecoration(
              color: active ? AppColors.electric : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
