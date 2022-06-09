import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageUtils {
  static Future<String?> uploadImage(Uint8List image, String fileName) async {
    String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    String newFileName = dateTime + ".png";
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("user_image/$fileName$newFileName");
    await ref.putData(image);
    return await ref.getDownloadURL();
  }
}
