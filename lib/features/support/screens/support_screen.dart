import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_theme.dart';
import '../../../shared/api/api_client.dart';

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen({super.key});
  @override
  ConsumerState<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends ConsumerState<SupportScreen> {
  final _messageCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  Map<String, dynamic>? _ticket;
  List<Map<String, dynamic>> _messages = [];
  bool _sending = false;
  bool _creating = false;
  String _topic = 'Order Issue';

  static const _topics = ['Order Issue', 'Return / Refund', 'Product Question', 'Payment Problem', 'Shipping Delay', 'Other'];

  @override
  void dispose() { _messageCtrl.dispose(); _subjectCtrl.dispose(); _scrollCtrl.dispose(); super.dispose(); }

  Future<void> _createTicket() async {
    if (_messageCtrl.text.trim().isEmpty) return;
    setState(() => _creating = true);
    try {
      final res = await ref.read(apiClientProvider).post('/support/tickets', data: {
        'subject': _subjectCtrl.text.isNotEmpty ? _subjectCtrl.text : _topic,
        'category': _topic.toLowerCase().replaceAll(' ', '_'),
        'message': _messageCtrl.text.trim(),
      });
      setState(() { _ticket = res.data['data']; _messages = List<Map<String, dynamic>>.from(res.data['data']['messages'] ?? []); _messageCtrl.clear(); });
    } catch (_) {} finally { setState(() => _creating = false); }
  }

  Future<void> _sendMessage() async {
    if (_messageCtrl.text.trim().isEmpty || _ticket == null) return;
    setState(() => _sending = true);
    try {
      final res = await ref.read(apiClientProvider).post('/support/tickets/${_ticket!['id']}/messages', data: {'message': _messageCtrl.text.trim()});
      setState(() { _messages.add(res.data['data']); _messageCtrl.clear(); });
      Future.delayed(const Duration(milliseconds: 100), () => _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut));
    } catch (_) {} finally { setState(() => _sending = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(title: const Text('Support'), subtitle: Text('We reply within 2 hours', style: TextStyle(color: AppColors.onSurface.withOpacity(0.5), fontSize: 12))),
      body: _ticket == null ? _buildNewTicket() : _buildChat(),
    );
  }

  Widget _buildNewTicket() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Start a Conversation', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Text('Topic', style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: _topics.map((t) => ChoiceChip(
          label: Text(t), selected: _topic == t, onSelected: (_) => setState(() => _topic = t),
          selectedColor: AppColors.electric, labelStyle: TextStyle(color: _topic == t ? Colors.black : AppColors.onSurface.withOpacity(0.6), fontWeight: FontWeight.w600, fontSize: 12),
          backgroundColor: AppColors.surfaceVariant, side: const BorderSide(color: Color(0xFF2A2A4A)),
        )).toList()),
        const SizedBox(height: 16),
        TextField(controller: _subjectCtrl, decoration: const InputDecoration(labelText: 'Subject (optional)')),
        const SizedBox(height: 12),
        TextField(controller: _messageCtrl, maxLines: 5, decoration: const InputDecoration(labelText: 'Describe your issue *', alignLabelWithHint: true)),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _creating ? null : _createTicket, child: _creating ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Send Message')),
      ]),
    );
  }

  Widget _buildChat() {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          controller: _scrollCtrl,
          padding: const EdgeInsets.all(16),
          itemCount: _messages.length,
          itemBuilder: (_, i) {
            final msg = _messages[i];
            final fromSupport = msg['is_from_support'] == true;
            return Align(
              alignment: fromSupport ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: fromSupport ? AppColors.surfaceVariant : AppColors.galaxy,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(fromSupport ? 4 : 16),
                    bottomRight: Radius.circular(fromSupport ? 16 : 4),
                  ),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  if (fromSupport) const Text('Support', style: TextStyle(color: AppColors.electric, fontSize: 11, fontWeight: FontWeight.bold)),
                  Text(msg['message'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 14)),
                ]),
              ),
            );
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: AppColors.surfaceVariant, border: Border(top: BorderSide(color: Color(0xFF2A2A4A)))),
        child: Row(children: [
          Expanded(child: TextField(controller: _messageCtrl, decoration: const InputDecoration(hintText: 'Type a message…', contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)))),
          const SizedBox(width: 8),
          IconButton(onPressed: _sending ? null : _sendMessage, icon: _sending ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.electric)) : const Icon(Icons.send_rounded, color: AppColors.electric)),
        ]),
      ),
    ]);
  }
}
