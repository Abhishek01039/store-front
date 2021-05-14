import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Store extends Equatable {
  String customerId;
  String? storeId;
  String storeTitle;
  String? ourStory;
  dynamic? logo;
  dynamic? headerImage;

  Store({
    required this.storeTitle,
    this.storeId,
    required this.customerId,
    this.ourStory,
    this.logo,
    this.headerImage,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      customerId: json['customerId'] as String,
      storeId: json['storeId'] as String,
      storeTitle: json['storeTitle'] as String,
      ourStory: json['ourStory'] as String,
      logo: json['logo'] as dynamic,
      headerImage: json['headerImage'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'storeTitle': storeTitle,
        'storeId': storeId,
        'ourStory': ourStory,
        'logo': logo,
        'customerId': customerId,
        'headerImage': headerImage,
      };

  Store copyWith({
    String? storeId,
    String? customerId,
    String? storeTitle,
    String? ourStory,
    dynamic? logo,
    dynamic? headerImage,
  }) {
    return Store(
      customerId: customerId ?? this.customerId,
      storeId: storeId ?? this.storeId,
      storeTitle: storeTitle ?? this.storeTitle,
      ourStory: ourStory ?? this.ourStory,
      logo: logo ?? this.logo,
      headerImage: headerImage ?? this.headerImage,
    );
  }

  @override
  List<Object?> get props => [
        customerId,
        storeId,
        storeTitle,
        ourStory,
        logo,
        headerImage,
      ];
}
