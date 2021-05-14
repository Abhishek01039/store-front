part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class LogoImageLoading extends StoreEvent {
  const LogoImageLoading({required this.image, required this.storeName});

  final dynamic image;
  final String storeName;

  @override
  List<Object?> get props => [image, storeName];
}

class HeaderImageLoading extends StoreEvent {
  const HeaderImageLoading({required this.image, required this.storeName});

  final dynamic image;
  final String storeName;

  @override
  List<Object?> get props => [image, storeName];
}

class LogoImageLoaded extends StoreEvent {
  const LogoImageLoaded(this.store);

  final Store store;

  @override
  List<Object> get props => [store];
}

class LogoUpdateRequest extends StoreEvent {
  const LogoUpdateRequest(this.store);

  final Store store;

  @override
  List<Object> get props => [store];
}
