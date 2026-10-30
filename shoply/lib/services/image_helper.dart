import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

/// يفتح المعرض ويرجّع الصورة مصغّرة (عشان تنحفظ بأمان داخل Firestore).
Future<Uint8List?> pickProfileImage() async {
  try {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 70,
    );
    if (file == null) return null;
    return await file.readAsBytes();
  } catch (_) {
    return null;
  }
}
