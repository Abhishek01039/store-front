import 'package:storefront/src/models/store.dart';

abstract class StoreRepository {
  // data store to firebase
  Future<void>? setStore(Store store);

  // get the store by userId
  Future<void> getStores(String uid);

  // get the store by Id
  Future<void> getStoreById(String id);

  // data update to firebase
  Future<void> updateStore(Store store);

  // data delete to firebase
  Future<void> deleteStore(String? prodId);
}
