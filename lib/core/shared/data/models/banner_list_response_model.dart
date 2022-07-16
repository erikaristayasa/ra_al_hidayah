import 'package:equatable/equatable.dart';

import 'banner_model.dart';

class BannerListResponseModel extends Equatable {
  final String message;
  final List<BannerModel> data;

  const BannerListResponseModel({required this.message, required this.data});

  @override
  List<Object?> get props => [message, data];

  factory BannerListResponseModel.fromJson(Map<String, dynamic> json) => BannerListResponseModel(
      message: json['message'],
      data: json['data'] != null
          ? List<BannerModel>.from(json['data'].map(
              (x) => BannerModel.fromJson(x),
            ))
          : []);
}
