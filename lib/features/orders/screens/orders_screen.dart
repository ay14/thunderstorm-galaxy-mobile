import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_theme.dart';

const _statusColors = {
  'pending': AppColors.warning,
  'confirmed': AppColors.storm,
  'processing': AppColors.galaxy,
  'shipped': AppColors.electric,
  'delivered': AppColors.success,
  'cancelled': AppColors.error,
};

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('Orders'), actions: [
        IconButton(icon: const Icon(Icons.filter_list_rounded), onPressed: () {}),
      ]),
      body: const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.shopping_bag_outlined, size: 64, color: Color(0xFF2A2A4A)),
          SizedBox(height: 16),
          Text('No orders yet', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          Text('Orders from customers will appear here', style: TextStyle(color: Color(0xFF6B7280))),
        ]),
      ),
    );
  }
}
