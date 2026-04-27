import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_theme.dart';
import '../../../shared/api/api_client.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});
  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  List<Map<String, dynamic>> _notifications = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final res = await ref.read(apiClientProvider).get('/notifications');
      setState(() { _notifications = List<Map<String, dynamic>>.from(res.data['data']); _loading = false; });
    } catch (_) { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('Notifications'), actions: [
        if (_notifications.any((n) => n['read_at'] == null))
          TextButton(onPressed: () {}, child: const Text('Mark all read', style: TextStyle(color: AppColors.electric))),
      ]),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? const Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(Icons.notifications_none_rounded, size: 64, color: Color(0xFF2A2A4A)),
                    SizedBox(height: 16),
                    Text("You're all caught up!", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text('No new notifications', style: TextStyle(color: Color(0xFF6B7280))),
                  ]),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) {
                    final n = _notifications[i];
                    final unread = n['read_at'] == null;
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: unread ? AppColors.galaxy.withOpacity(0.1) : AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: unread ? AppColors.galaxy.withOpacity(0.3) : const Color(0xFF2A2A4A)),
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        if (unread) Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 4, right: 10), decoration: const BoxDecoration(color: AppColors.galaxy, shape: BoxShape.circle)),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(n['title'] ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text(n['body'] ?? '', style: TextStyle(color: AppColors.onSurface.withOpacity(0.6), fontSize: 13)),
                        ])),
                      ]),
                    );
                  },
                ),
    );
  }
}
