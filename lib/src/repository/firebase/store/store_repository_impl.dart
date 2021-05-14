import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storefront/src/models/store.dart';
import 'package:storefront/src/repository/firebase/store/store_repository.dart';
import 'package:storefront/src/utils/message_text.dart';

class StoreRepositoryImpl extends StoreRepository {
  late FirebaseFirestore firebaseFirestore;

  static final StoreRepositoryImpl _singleton = StoreRepositoryImpl._internal();

  factory StoreRepositoryImpl({FirebaseFirestore? firebaseAuth}) {
    _singleton.firebaseFirestore = firebaseAuth ?? FirebaseFirestore.instance;
    return _singleton;
  }

  StoreRepositoryImpl._internal();

  @override
  Future<void> deleteStore(String? prodId) {
    throw UnimplementedError();
  }

  @override
  Future<void> getStoreById(String id) {
    throw UnimplementedError();
  }

  @override
  Future<void> getStores(String uid) {
    throw UnimplementedError();
  }

  @override
  Future<void>? setStore(Store store) async {
    // Create a CollectionReference called products that references the firestore collection
    try {
      final CollectionReference stores = firebaseFirestore.collection('stores');
      final DocumentReference ref = stores.doc();
      store.storeId = ref.id;
      await stores.doc(ref.id).set(store.toJson());
    } catch (e) {
      throw Exception(Message.genericErrorMessage);
    }
  }

  @override
  Future<void> updateStore(Store store) {
    throw UnimplementedError();
  }
}
