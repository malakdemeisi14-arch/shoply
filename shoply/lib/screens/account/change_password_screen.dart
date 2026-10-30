import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _form = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _update() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    final err =
        await context.read<AuthService>().changePassword(_current.text, _new.text);
    if (!mounted) return;
    setState(() => _loading = false);
    showMsg(context, err ?? 'Password updated');
    if (err == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
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
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                        color: AppColors.soft, shape: BoxShape.circle),
                    child: const Icon(Icons.lock,
                        size: 44, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text('Keep your account secure',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 4),
                const Center(
                  child: Text('Update your password regularly\nto keep your account safe.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: AppColors.grey)),
                ),
                const SizedBox(height: 24),
                AppTextField(
                    label: 'Current Password',
                    controller: _current,
                    hint: 'Current password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validator: (v) => Validators.notEmpty(v, 'Current password')),
                AppTextField(
                    label: 'New Password',
                    controller: _new,
                    hint: 'New password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validator: Validators.password),
                AppTextField(
                    label: 'Confirm New Password',
                    controller: _confirm,
                    hint: 'Confirm new password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validator: (v) =>
                        v != _new.text ? 'Passwords do not match' : null),
                const Text('Use at least 8 characters.',
                    style: TextStyle(fontSize: 11, color: AppColors.grey)),
                const SizedBox(height: 16),
                PrimaryButton(
                    label: 'Update Password',
                    onPressed: _update,
                    loading: _loading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
