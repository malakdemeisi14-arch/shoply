import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../core/theme.dart';

class UserAvatar extends StatelessWidget {
  final String? url;
  final Uint8List? bytes;
  final double radius;
  final bool showCamera;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    this.url,
    this.bytes,
    this.radius = 30,
    this.showCamera = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? img;
    if (bytes != null) {
      img = MemoryImage(bytes!);
    } else if (url != null && url!.isNotEmpty) {
      img = NetworkImage(url!);
    }

    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFD5D9D6),
      backgroundImage: img,
      child: img == null
          ? Icon(Icons.person, size: radius, color: Colors.white)
          : null,
    );

    if (!showCamera) return avatar;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child:
                  const Icon(Icons.photo_camera, size: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
