import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:project_k/comman/services/network_services.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/comman/utilse/app_exception/app_exception.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/comman/utilse/url/app_url.dart';
import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';
import 'package:project_k/feature/booking/presentation/model/booking_status_model.dart';
import 'package:project_k/feature/booking/presentation/model/create_booking.dart';
import 'package:project_k/feature/booking/presentation/model/my_booking_model.dart';
import 'package:project_k/feature/booking/presentation/model/my_bookings_model.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';

class RemoteBookingDataSource {
  EitherResponse<SlotModel> createBooking(
    String token,
    String startingTime,
    String endingTime,
    String date,
  ) async {
    return NetworkService.postEither<Map<String, dynamic>, SlotModel>(
      endPoint: AppUrl.createSlote,
      body: {
        "slot_date": date,
        "start_time": startingTime,
        "end_time": endingTime,
      },
      jsonTransform: (json) {
        return SlotModel.fromJson(json);
      },
      useAuthToken: true,
    );
  }

  EitherResponse<void> Book(int slote_id, String token) async {
    return NetworkService.postEither<Map<String, dynamic>, void>(
      endPoint: AppUrl.Book,
      body: {"slot_id": slote_id},
      jsonTransform: (json) {},
      useAuthToken: true,
    );
  }

  EitherResponse<BookingStatusUpdate> confirmbooking(
    String token,
    int id,
    String new_status,
  ) async {
    return NetworkService.putEither<Map<String, dynamic>, BookingStatusUpdate>(
      endPoint: AppUrl.confirmStatus,
      body: {"booking_id": id, "new_status": new_status},
      jsonTransform: (json) => BookingStatusUpdate.fromJson(json),
      useAuthToken: true,
    );
  }

  EitherResponse<List<MySloteModel>> getSlote(
    String token,
    String start_date,
    String end_date,
  ) {
    return NetworkService.fetchEither<List<dynamic>, List<MySloteModel>>(
      queryParams: {"start_date": start_date, "end_date": end_date},
      endPoint: AppUrl.getBarberSlote,
      jsonTransform:
          (json) =>
              (json as List).map((e) => MySloteModel.fromJson(e)).toList(),
      useAuthToken: true,
    );
  }

  EitherResponse<List<BookingModel>> getMyBooking(String token) {
    return NetworkService.fetchEither<List<dynamic>, List<BookingModel>>(
      endPoint: AppUrl.getMyBooking,
      jsonTransform:
          (json) =>
              (json as List).map((e) => BookingModel.fromJson(e)).toList(),
      useAuthToken: true,
    );
  }

  EitherResponse<List<MySloteModel>> getMySlote(
    String token,
    String start_date,
    String end_date,
  ) {
    return NetworkService.fetchEither<List<dynamic>, List<MySloteModel>>(
      queryParams: {"start_date": start_date, "end_date": end_date},
      endPoint: AppUrl.getBarberSlote,
      jsonTransform:
          (json) =>
              (json as List).map((e) => MySloteModel.fromJson(e)).toList(),
      useAuthToken: true,
    );
  }

  EitherResponse<List<MyBookingModel>> MyBook() {
    return NetworkService.fetchEither<List<dynamic>, List<MyBookingModel>>(
      endPoint: AppUrl.getMyBook,
      queryParams: {'upcoming_only': true.toString()},
      jsonTransform:
          (json) =>
              (json as List).map((e) => MyBookingModel.fromJson(e)).toList(),
      useAuthToken: true,
    );
  }
 EitherResponse<void> cancelMyBook(String token, int barberId) async {
    {
      try {
        final response = await NetworkService.deleteApi(
          AppUrl.baseUrl + "/bookings/$barberId",
          token,
        );
        NetworkService.transformResponse(response);
        return Right(null);
      } on BadRequestException catch (er) {
        return Left(er.message);
      } catch (e) {
        return Left("Something went wrong");
      }
    }
  }
  EitherResponse<void> deletSlote(String token, int id) async {
    {
      try {
        final response = await NetworkService.deleteApi(
          AppUrl.baseUrl + "/slots/$id",
          token,
        );
        NetworkService.transformResponse(response);
        return Right(null);
      } on BadRequestException catch (er) {
        return Left(er.message);
      } catch (e) {
        return Left("Something went wrong");
      }
    }
  }
}
