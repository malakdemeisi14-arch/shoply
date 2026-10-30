import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';
import '../../services/order_service.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  static const _subjects = [
    'General question',
    'Order issue',
    'Payment',
    'Feedback',
  ];

  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _email;
  final _message = TextEditingController();
  String? _subject;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final p = context.read<AuthService>().profile;
    _name = TextEditingController(text: p?.fullName ?? '');
    _email = TextEditingController(text: p?.email ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_form.currentState!.validate()) return;
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    setState(() => _loading = true);
    final err = await OrderService.sendMessage(
      uid: uid,
      name: _name.text.trim(),
      email: _email.text.trim(),
      subject: _subject ?? '',
      message: _message.text.trim(),
    );
    if (!mounted) return;
    setState(() => _loading = false);
    showMsg(context, err ?? 'Message sent. Thank you!');
    if (err == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 84,
                    height: 84,
                    decoration: const BoxDecoration(
                        color: AppColors.soft, shape: BoxShape.circle),
                    child: const Icon(Icons.headset_mic_outlined,
                        size: 40, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text('How can we help?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                const Center(
                  child: Text("Send us a message. We're here for you.",
                      style: TextStyle(fontSize: 12, color: AppColors.grey)),
                ),
                const SizedBox(height: 20),
                AppTextField(
                    label: 'Full Name',
                    controller: _name,
                    hint: 'Enter your name',
                    icon: Icons.person_outline,
                    validator: (v) => Validators.notEmpty(v, 'Name')),
                AppTextField(
                    label: 'Email',
                    controller: _email,
                    hint: 'Enter your email',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Subject',
                      style: TextStyle(fontSize: 12, color: AppColors.grey)),
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Choose a subject',
                      style: TextStyle(fontSize: 14, color: AppColors.grey)),
                  items: _subjects
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => _subject = v,
                  validator: (v) => v == null ? 'Choose a subject' : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.field,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('Message',
                      style: TextStyle(fontSize: 12, color: AppColors.grey)),
                ),
                TextFormField(
                  controller: _message,
                  maxLines: 4,
                  validator: (v) => Validators.notEmpty(v, 'Message'),
                  decoration: InputDecoration(
                    hintText: 'Write your message...',
                    hintStyle:
                        const TextStyle(color: AppColors.grey, fontSize: 14),
                    filled: true,
                    fillColor: AppColors.field,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                    label: 'Send Message', onPressed: _send, loading: _loading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
