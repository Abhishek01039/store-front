import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storefront/src/models/store.dart';
import 'package:storefront/src/repository/firebase/image_upload.dart';
import 'package:storefront/src/repository/firebase/image_upload_impl.dart';
import 'package:storefront/src/repository/firebase/store/store_repository.dart';
import 'package:storefront/src/repository/firebase/store/store_repository_impl.dart';
import 'package:storefront/src/utils/message_text.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc({
    FileUploadRepository? fileUpload,
    StoreRepository? storeRepository,
  })  : _fileUpload = fileUpload ?? FileUploadRepositoryImpl(),
        _storeRepositoryImpl = storeRepository ?? StoreRepositoryImpl(),
        super(StoreInitial());

  final FileUploadRepository _fileUpload;
  final StoreRepository _storeRepositoryImpl;

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is LogoImageLoading) {
      yield StoreLoading();
      try {
        final List<String>? imageLink = await _fileUpload
            .uploadFile([event.image], event.storeName, isStoreImage: true);

        if (imageLink == null || imageLink.isEmpty) {
          yield const StoreError(errorMessage: Message.genericErrorMessage);
        } else {
          yield StoreLogoImageSuccess(
            imageDownloadUrl: imageLink,
          );
        }
      } catch (e) {
        yield StoreError(errorMessage: e.toString());
      }
    } else if (event is HeaderImageLoading) {
      yield StoreLoading();
      try {
        final List<String>? imageLink = await _fileUpload
            .uploadFile([event.image], event.storeName, isStoreImage: true);

        if (imageLink == null || imageLink.isEmpty) {
          yield const StoreError(errorMessage: Message.genericErrorMessage);
        } else {
          yield StoreHeaderImageSuccess(
            imageDownloadUrl: imageLink,
          );
        }
      } catch (e) {
        yield StoreError(errorMessage: e.toString());
      }
    } else if (event is LogoImageLoaded) {
      yield StoreLoading();
      try {
        await _storeRepositoryImpl.setStore(event.store);

        yield StoreSuccess();
      } catch (e) {
        yield StoreError(errorMessage: e.toString());
      }
    }
  }
}
