import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes/app_router.dart';
import '../../../app/theme/app_theme.dart';
import '../../../features/auth/providers/auth_provider.dart';
import '../models/company_model.dart';
import '../providers/company_provider.dart';

class CompanySelectionScreen extends ConsumerStatefulWidget {
  const CompanySelectionScreen({super.key});

  @override
  ConsumerState<CompanySelectionScreen> createState() => _CompanySelectionScreenState();
}

class _CompanySelectionScreenState extends ConsumerState<CompanySelectionScreen> {
  final _search = TextEditingController();
  String _query = '';
  CompanyModel? _selected;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_selected == null) return;
    await ref.read(authStateProvider.notifier).completeOnboarding(companyId: _selected!.id);
    if (!mounted) return;
    context.go(AppRoutes.permissions);
  }

  @override
  Widget build(BuildContext context) {
    final companies = ref.watch(companiesProvider(_query));

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _StepIndicator(current: 1),
              const SizedBox(height: 32),
              Text('Select Your Company', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 8),
              Text(
                'Search for your brand or company',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface.withOpacity(0.6)),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: 'Search company name...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _search.clear();
                            setState(() => _query = '');
                          },
                        )
                      : null,
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: companies.when(
                  data: (list) {
                    if (list.isEmpty) {
                      return _EmptyState(onAddManually: () => context.go(AppRoutes.manualCompanySubmission));
                    }
                    return ListView.separated(
                      itemCount: list.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) {
                        if (i == list.length) {
                          return _AddManuallyTile(onTap: () => context.go(AppRoutes.manualCompanySubmission));
                        }
                        final company = list[i];
                        return _CompanyTile(
                          company: company,
                          selected: _selected?.id == company.id,
                          onTap: () => setState(() => _selected = company),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Failed to load companies: $e')),
                ),
              ),
              const SizedBox(height: 16),
              if (_selected != null)
                ElevatedButton(
                  onPressed: _confirm,
                  child: Text('Select ${_selected!.name}'),
                )
              else
                OutlinedButton(
                  onPressed: () => context.go(AppRoutes.permissions),
                  child: const Text('Skip for now'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompanyTile extends StatelessWidget {
  const _CompanyTile({required this.company, required this.selected, required this.onTap});

  final CompanyModel company;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.galaxy.withOpacity(0.2) : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.electric : const Color(0xFF2A2A4A), width: selected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: company.logoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(company.logoUrl!, fit: BoxFit.cover),
                    )
                  : Center(
                      child: Text(
                        company.name[0].toUpperCase(),
                        style: const TextStyle(color: AppColors.electric, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(company.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15)),
                  Text(
                    company.category.replaceAll('_', ' '),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.onSurface.withOpacity(0.5), fontSize: 12),
                  ),
                ],
              ),
            ),
            if (company.isVerified)
              const Icon(Icons.verified_rounded, color: AppColors.electric, size: 18),
            if (selected) ...[
              const SizedBox(width: 8),
              const Icon(Icons.check_circle_rounded, color: AppColors.electric),
            ],
          ],
        ),
      ),
    );
  }
}

class _AddManuallyTile extends StatelessWidget {
  const _AddManuallyTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.galaxy, width: 1, style: BorderStyle.solid),
        ),
        child: Row(
          children: [
            const Icon(Icons.add_circle_outline_rounded, color: AppColors.galaxy),
            const SizedBox(width: 12),
            Text("Can't find your company? Add it manually", style: TextStyle(color: AppColors.galaxy, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAddManually});

  final VoidCallback onAddManually;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.search_off_rounded, size: 64, color: AppColors.galaxyWaters),
        const SizedBox(height: 16),
        const Text('No companies found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('Try a different search or add your company manually', textAlign: TextAlign.center),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onAddManually,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Manually'),
        ),
      ],
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
