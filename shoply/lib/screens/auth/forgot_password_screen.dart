import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    final err = await context.read<AuthService>().sendReset(_email.text);
    if (!mounted) return;
    setState(() => _loading = false);
    showMsg(context, err ?? 'Reset link sent. Check your email.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _form,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                      color: AppColors.soft, shape: BoxShape.circle),
                  child: const Icon(Icons.lock,
                      size: 38, color: AppColors.primary),
                ),
                const SizedBox(height: 24),
                const Text('Forgot Password?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                const Text("Enter your email and we'll send\nyou a reset link.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 28),
                AppTextField(
                    controller: _email,
                    hint: 'Email',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email),
                const SizedBox(height: 8),
                PrimaryButton(
                    label: 'Send Reset Link', onPressed: _send, loading: _loading),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back to Login',
                      style: TextStyle(color: AppColors.text, fontSize: 13)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
