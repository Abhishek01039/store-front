import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:storefront/src/utils/message_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'image_upload.dart';

class FileUploadRepositoryImpl extends FileUploadRepository {
  late firebase_storage.FirebaseStorage storage;
  late FirebaseAuth _firebaseAuth;

  static final FileUploadRepositoryImpl _singleton =
      FileUploadRepositoryImpl._internal();

  factory FileUploadRepositoryImpl(
      {FirebaseAuth? firebaseAuth,
      firebase_storage.FirebaseStorage? firebaseStorage}) {
    _singleton._firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
    _singleton.storage =
        firebaseStorage ?? firebase_storage.FirebaseStorage.instance;
    return _singleton;
  }

  FileUploadRepositoryImpl._internal();

  @override
  Future<List<String>?>? uploadFile(List<dynamic> files, String productName,
      {bool isStoreImage = false}) async {
    try {
      final List<String> downloadUrl = <String>[];
      for (final file in files) {
        /// File upload depends on platform
        final String imageName;
        final String path = isStoreImage
            ? '/${_firebaseAuth.currentUser?.uid ?? ''}/stores/$productName/'
            : '/${_firebaseAuth.currentUser?.uid ?? ''}/products/$productName/';
        if (kIsWeb) {
          final Random rn = Random();
          imageName = 'image_${rn.nextInt(999).toString()}';

          await storage
              .refFromURL('gs://localenergy-64c59.appspot.com')
              .child('$path$imageName')
              .putData(file as Uint8List);
        } else {
          imageName = file?.path?.split('/')[file?.path?.split('/')?.length - 1]
              as String;

          await storage
              .refFromURL('gs://localenergy-64c59.appspot.com')
              .child('$path$imageName')
              .putFile(file as File);
        }

        // get the url of image
        downloadUrl.add(await storage
            .refFromURL('gs://localenergy-64c59.appspot.com')
            .child('$path$imageName')
            .getDownloadURL());
      }
      return downloadUrl;
    } catch (e) {
      throw Exception(Message.genericErrorMessage);
    }
  }
}
