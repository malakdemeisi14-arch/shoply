import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/utils.dart';
import '../../core/validators.dart';
import '../../services/auth_service.dart';
import '../../services/image_helper.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/user_avatar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _username;
  late final TextEditingController _email;
  late final TextEditingController _address;
  Uint8List? _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final p = context.read<AuthService>().profile;
    _name = TextEditingController(text: p?.fullName ?? '');
    _username = TextEditingController(text: p?.username ?? '');
    _email = TextEditingController(text: p?.email ?? '');
    _address = TextEditingController(text: p?.address ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final bytes = await pickProfileImage();
    if (bytes != null && mounted) setState(() => _image = bytes);
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    final err = await context.read<AuthService>().updateProfile(
          fullName: _name.text,
          username: _username.text,
          address: _address.text,
          imageBytes: _image,
        );
    if (!mounted) return;
    setState(() => _loading = false);
    showMsg(context, err ?? 'Profile updated');
    if (err == null) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AuthService>().profile;
    return Scaffold(
      appBar: AppBar(title: const Text('Update Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _form,
            child: Column(
              children: [
                UserAvatar(
                  bytes: _image,
                  url: p?.photoUrl,
                  radius: 48,
                  showCamera: true,
                  onTap: _pick,
                ),
                const SizedBox(height: 24),
                AppTextField(
                    label: 'Full Name',
                    controller: _name,
                    hint: 'Full Name',
                    icon: Icons.person_outline,
                    validator: (v) => Validators.notEmpty(v, 'Full name')),
                AppTextField(
                    label: 'Username',
                    controller: _username,
                    hint: 'Username',
                    icon: Icons.person_outline,
                    validator: (v) => Validators.notEmpty(v, 'Username')),
                AppTextField(
                    label: 'Email',
                    controller: _email,
                    hint: 'Email',
                    icon: Icons.mail_outline,
                    enabled: false),
                AppTextField(
                    label: 'Address',
                    controller: _address,
                    hint: 'Address',
                    icon: Icons.location_on_outlined,
                    validator: (v) => Validators.notEmpty(v, 'Address')),
                const SizedBox(height: 12),
                PrimaryButton(
                    label: 'Save Changes', onPressed: _save, loading: _loading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
