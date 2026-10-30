import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  static const _bucket = 'avatars';

  /// يرفع صورة المستخدم على Supabase ويرجّع رابطها، أو null لو فشل.
  static Future<String?> uploadAvatar(String uid, Uint8List bytes) async {
    try {
      final storage = Supabase.instance.client.storage.from(_bucket);
      final path = '$uid.jpg';
      await storage.uploadBinary(
        path,
        bytes,
        fileOptions: const FileOptions(contentType: 'image/jpeg', upsert: true),
      );
      // الرقم بآخر الرابط عشان الصورة الجديدة ما تتعلق بالكاش
      return '${storage.getPublicUrl(path)}?v=${DateTime.now().millisecondsSinceEpoch}';
    } catch (e) {
      // ignore: avoid_print
      print('Supabase upload error: $e');
      return null;
    }
  }
}
