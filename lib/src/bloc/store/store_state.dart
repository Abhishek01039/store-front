part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoadSuccess extends StoreState {}

class StoreError extends StoreState {
  const StoreError({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}

class StoreLogoImageSuccess extends StoreState {
  const StoreLogoImageSuccess({this.imageDownloadUrl});

  final List<String>? imageDownloadUrl;

  @override
  List<Object?> get props => [imageDownloadUrl];
}

class StoreHeaderImageSuccess extends StoreState {
  const StoreHeaderImageSuccess({this.imageDownloadUrl});

  final List<String>? imageDownloadUrl;

  @override
  List<Object?> get props => [imageDownloadUrl];
}

class StoreSuccess extends StoreState {}
