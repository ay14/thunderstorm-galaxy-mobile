import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/theme/app_theme.dart';
import '../providers/company_provider.dart';

const _categories = [
  ('helmets', 'Helmets'),
  ('riding_gear', 'Riding Gear'),
  ('parts_accessories', 'Parts & Accessories'),
  ('electronics', 'Electronics'),
  ('bags_luggage', 'Bags & Luggage'),
  ('protective_gear', 'Protective Gear'),
  ('other', 'Other'),
];

class ManualSubmissionScreen extends ConsumerStatefulWidget {
  const ManualSubmissionScreen({super.key});

  @override
  ConsumerState<ManualSubmissionScreen> createState() => _ManualSubmissionScreenState();
}

class _ManualSubmissionScreenState extends ConsumerState<ManualSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _registration = TextEditingController();
  final _website = TextEditingController();
  String _category = 'other';
  bool _submitted = false;

  @override
  void dispose() {
    _name.dispose();
    _registration.dispose();
    _website.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref.read(companySuggestionProvider.notifier).submit(
          name: _name.text.trim(),
          category: _category,
          registrationNumber: _registration.text.trim(),
          website: _website.text.trim(),
        );
    if (!mounted) return;
    if (ok) setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    final suggestionState = ref.watch(companySuggestionProvider);

    if (_submitted) return _SuccessView(onContinue: () => context.go(AppRoutes.permissions));

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('Add Your Company')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tell us about your company', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text(
                "We'll review and add it within 24 hours.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface.withOpacity(0.6)),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Company Name *', prefixIcon: Icon(Icons.business_rounded)),
                validator: (v) => v == null || v.trim().isEmpty ? 'Company name is required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category *', prefixIcon: Icon(Icons.category_rounded)),
                dropdownColor: AppColors.surfaceVariant,
                items: _categories
                    .map((c) => DropdownMenuItem(value: c.$1, child: Text(c.$2)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v ?? 'other'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _registration,
                decoration: const InputDecoration(
                  labelText: 'GST / Registration Number',
                  prefixIcon: Icon(Icons.numbers_rounded),
                  hintText: '22AAAAA0000A1Z5',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _website,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Website',
                  prefixIcon: Icon(Icons.language_rounded),
                  hintText: 'https://example.com',
                ),
              ),
              const SizedBox(height: 32),
              if (suggestionState is AsyncError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    suggestionState.error.toString(),
                    style: const TextStyle(color: AppColors.error, fontSize: 13),
                  ),
                ),
              ElevatedButton(
                onPressed: suggestionState is AsyncLoading ? null : _submit,
                child: suggestionState is AsyncLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Submit for Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 52),
              ),
              const SizedBox(height: 24),
              Text('Submitted!', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 12),
              Text(
                "We'll review your company and add it within 24 hours. You'll be notified once it's approved.",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.onSurface.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: onContinue, child: const Text('Continue')),
            ],
          ),
        ),
      ),
    );
  }
}
