import 'package:flutter/material.dart';
import '../core/theme.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final bool enabled;
  final String? label;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.enabled = true,
    this.label,
    this.keyboardType,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(widget.label!,
                  style: const TextStyle(fontSize: 12, color: AppColors.grey)),
            ),
          TextFormField(
            controller: widget.controller,
            enabled: widget.enabled,
            obscureText: widget.isPassword && _hidden,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
              prefixIcon: Icon(widget.icon, size: 20, color: AppColors.grey),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _hidden
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: AppColors.grey,
                      ),
                      onPressed: () => setState(() => _hidden = !_hidden),
                    )
                  : null,
              filled: true,
              fillColor: AppColors.field,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
