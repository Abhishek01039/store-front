import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storefront/src/models/store.dart';

class StoreCreateViewModel extends ChangeNotifier {
  TextEditingController storeTitleController = TextEditingController();
  TextEditingController ourStoryController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late Store store;

  // Logo for stores
  File? logo;
  Uint8List? logoForWeb;

  // Image header for stores
  File? headerImage;
  Uint8List? headerImageForWeb;

  /// [customerId] is for testing purpose.
  ///
  /// we should assign any random [customerId] when we are trying to unit test or widget test.
  String? customerId;

  StoreCreateViewModel({String? customerId}) {
    this.customerId ??= customerId;
    store = Store(
      storeTitle: storeTitleController.text,
      customerId: customerId ?? FirebaseAuth.instance.currentUser?.uid ?? '',
    );
  }

  // reset all state after adding the product to database.
  void resetState() {
    storeTitleController = TextEditingController();
    ourStoryController = TextEditingController();
    store = Store(
      storeTitle: storeTitleController.text,
      customerId: customerId ?? FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    logo = null;
    logoForWeb = null;
    headerImage = null;
    headerImageForWeb = null;
    notifyListeners();
  }

  void addLogo(File file) {
    logo = file;
    notifyListeners();
  }

  void removeLogo() {
    logo = null;
    notifyListeners();
  }

  void addLogoForWeb(Uint8List file) {
    logoForWeb = file;
    notifyListeners();
  }

  void removeLogoForWeb() {
    logoForWeb = null;
    notifyListeners();
  }

  void addHeaderImage(File file) {
    headerImage = file;
    notifyListeners();
  }

  void removeHeaderImage() {
    headerImage = null;
    notifyListeners();
  }

  void addHeaderImageForWeb(Uint8List file) {
    headerImageForWeb = file;
    notifyListeners();
  }

  void removeHeaderImageForWeb() {
    headerImageForWeb = null;
    notifyListeners();
  }
}
