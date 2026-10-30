import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';
import '../../services/image_helper.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/user_avatar.dart';
import '../main/main_shell.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  Uint8List? _image;
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    _address.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final bytes = await pickProfileImage();
    if (bytes != null && mounted) setState(() => _image = bytes);
  }

  Future<void> _signUp() async {
    if (_image == null) {
      showMsg(context, 'Please choose a profile photo');
      return;
    }
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    final err = await context.read<AuthService>().signUp(
          fullName: _name.text,
          username: _username.text,
          email: _email.text,
          address: _address.text,
          password: _pass.text,
          imageBytes: _image,
        );
    if (!mounted) return;
    setState(() => _loading = false);
    if (err != null) {
      showMsg(context, err);
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainShell()),
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Form(
            key: _form,
            child: Column(
              children: [
                const Text('Join us and start shopping',
                    style: TextStyle(fontSize: 12, color: AppColors.grey)),
                const SizedBox(height: 16),
                UserAvatar(
                    bytes: _image, radius: 44, showCamera: true, onTap: _pick),
                const SizedBox(height: 8),
                const Text('Tap to add your photo',
                    style: TextStyle(fontSize: 11, color: AppColors.grey)),
                const SizedBox(height: 20),
                AppTextField(
                    controller: _name,
                    hint: 'Full Name',
                    icon: Icons.person_outline,
                    validator: (v) => Validators.notEmpty(v, 'Full name')),
                AppTextField(
                    controller: _username,
                    hint: 'Username',
                    icon: Icons.person_outline,
                    validator: (v) => Validators.notEmpty(v, 'Username')),
                AppTextField(
                    controller: _email,
                    hint: 'Email',
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email),
                AppTextField(
                    controller: _address,
                    hint: 'Address',
                    icon: Icons.location_on_outlined,
                    validator: (v) => Validators.notEmpty(v, 'Address')),
                AppTextField(
                    controller: _pass,
                    hint: 'Password',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validator: Validators.password),
                AppTextField(
                  controller: _confirm,
                  hint: 'Confirm Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: (v) =>
                      v != _pass.text ? 'Passwords do not match' : null,
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                    label: 'Sign Up', onPressed: _signUp, loading: _loading),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text('Login',
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
