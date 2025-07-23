import 'dart:convert';

import 'package:project_k/comman/services/network_services.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/comman/utilse/url/app_url.dart';
import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';

class RemoteBookingDataSource {
  EitherResponse<SignUpResponseModel> createBooking(
    String token,
    String startingTime,
    String endingTime,
    String date,
  ) async {
    return NetworkService.postEither<Map<String, dynamic>, SignUpResponseModel>(
      endPoint: AppUrl.createSlote,
      body: {
        "slot_date": date,
        "start_time": startingTime,
        "end_time": endingTime,
      },
      jsonTransform: (json) => SignUpResponseModel.fromJson(json),
      useAuthToken: true,
    );
  }

EitherResponse<List<MySloteModel>> getSlote(
  String token,
  String start_date,
  String end_date,
) {
  return NetworkService.fetchEither<Map<String, dynamic>, List<MySloteModel>>(
    queryParams: {
      "start_date": start_date,
      "end_date": end_date,
    },
    endPoint: AppUrl.getBarberSlote,
    jsonTransform: (json) => (json['data'] as List)
        .map((e) => MySloteModel.fromJson(e))
        .toList(),
    useAuthToken: true,
  );
}

}
