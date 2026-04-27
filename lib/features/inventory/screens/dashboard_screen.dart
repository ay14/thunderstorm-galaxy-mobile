import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: AppColors.surface,
              title: Row(children: [
                Container(width: 32, height: 32, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.galaxy, AppColors.electric]), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 18)),
                const SizedBox(width: 10),
                const Text('MotoGenius', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ]),
              actions: [
                IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () {}),
                IconButton(icon: const Icon(Icons.account_circle_outlined, color: Colors.white), onPressed: () {}),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(delegate: SliverChildListDelegate([
                _SectionTitle('Overview'),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: _StatCard(icon: Icons.inventory_2_rounded, label: 'Products', value: '—', color: AppColors.galaxy)),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(icon: Icons.shopping_bag_rounded, label: 'Orders Today', value: '—', color: AppColors.storm)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: _StatCard(icon: Icons.warning_amber_rounded, label: 'Low Stock', value: '—', color: AppColors.warning)),
                  const SizedBox(width: 12),
                  Expanded(child: _StatCard(icon: Icons.currency_rupee_rounded, label: 'Revenue', value: '—', color: AppColors.electric)),
                ]),
                const SizedBox(height: 24),
                _SectionTitle('Quick Actions'),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  _QuickAction(icon: Icons.qr_code_scanner_rounded, label: 'Scan Barcode', onTap: () {}),
                  _QuickAction(icon: Icons.add_box_rounded, label: 'Add Product', onTap: () {}),
                  _QuickAction(icon: Icons.receipt_long_rounded, label: 'New Order', onTap: () {}),
                  _QuickAction(icon: Icons.warehouse_rounded, label: 'Storage', onTap: () {}),
                ]),
                const SizedBox(height: 24),
                _SectionTitle('Recent Orders'),
                const SizedBox(height: 12),
                _EmptyOrdersPlaceholder(),
              ])),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Text(text, style: Theme.of(context).textTheme.titleLarge);
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.icon, required this.label, required this.value, required this.color});
  final IconData icon; final String label, value; final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2A2A4A))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 22)),
        const SizedBox(height: 12),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: AppColors.onSurface.withOpacity(0.5), fontSize: 12)),
      ]),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.onTap});
  final IconData icon; final String label; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 56) / 2,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2A2A4A))),
        child: Row(children: [
          Icon(icon, color: AppColors.electric, size: 22),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13))),
        ]),
      ),
    );
  }
}

class _EmptyOrdersPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2A2A4A))),
      child: Column(children: [
        const Icon(Icons.receipt_long_rounded, size: 40, color: Color(0xFF2A2A4A)),
        const SizedBox(height: 8),
        const Text('No orders yet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text('Orders will appear here', style: TextStyle(color: AppColors.onSurface.withOpacity(0.4), fontSize: 13)),
      ]),
    );
  }
}
