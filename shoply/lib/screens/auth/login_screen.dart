import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';
import '../main/main_shell.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    final err = await context.read<AuthService>().signIn(_email.text, _pass.text);
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _form,
            child: Column(
              children: [
                const SizedBox(height: 30),
                const AppLogo(size: 40),
                const SizedBox(height: 24),
                const Text('Welcome Back',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                const Text('Sign in to continue shopping',
                    style: TextStyle(fontSize: 13, color: AppColors.grey)),
                const SizedBox(height: 28),
                AppTextField(
                  controller: _email,
                  hint: 'Email',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                AppTextField(
                  controller: _pass,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  validator: (v) => Validators.notEmpty(v, 'Password'),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen())),
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ),
                const SizedBox(height: 8),
                PrimaryButton(label: 'Login', onPressed: _login, loading: _loading),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ",
                        style: TextStyle(fontSize: 13, color: AppColors.grey)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignUpScreen())),
                      child: const Text('Sign Up',
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
