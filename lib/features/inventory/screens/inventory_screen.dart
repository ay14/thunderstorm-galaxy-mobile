import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_theme.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});
  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  final _search = TextEditingController();
  String _filter = 'all';

  @override
  void dispose() { _search.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('Inventory'), actions: [
        IconButton(icon: const Icon(Icons.qr_code_scanner_rounded), onPressed: () {}),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.electric,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Update Stock', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(controller: _search, decoration: const InputDecoration(hintText: 'Search products or SKU…', prefixIcon: Icon(Icons.search_rounded))),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            for (final f in [('all', 'All'), ('low', 'Running Low'), ('out', 'Out of Stock'), ('ok', 'In Stock')])
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(f.$2),
                  selected: _filter == f.$1,
                  onSelected: (_) => setState(() => _filter = f.$1),
                  selectedColor: AppColors.electric,
                  labelStyle: TextStyle(color: _filter == f.$1 ? Colors.black : AppColors.onSurface.withOpacity(0.6), fontWeight: FontWeight.w600),
                  backgroundColor: AppColors.surfaceVariant,
                  side: const BorderSide(color: Color(0xFF2A2A4A)),
                ),
              ),
          ]),
        ),
        const SizedBox(height: 8),
        const Expanded(child: Center(child: Text('Connect to API to load inventory', style: TextStyle(color: Color(0xFF6B7280))))),
      ]),
    );
  }
}
