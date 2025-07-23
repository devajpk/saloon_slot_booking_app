import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view/sign_up_page.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_event.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/booking/data/data_source/booking_remote_data_Source.dart';
import 'package:project_k/feature/booking/domain/repo/repo.dart';
import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';

class BookingImp implements BookingRepo {
  final RemoteBookingDataSource remotebookingDataSoruce;

  BookingImp({required this.remotebookingDataSoruce});

  @override
  EitherResponse<SignUpResponseModel> createBooking({
    required String token,
    required String startingAt,
    required String endingAt,
    required String date,
  }) {
    return remotebookingDataSoruce.createBooking(
      token,
      startingAt,
      endingAt,
      date,
    );
  }

  @override
  EitherResponse<List<MySloteModel>> GetSlote({
    required String token,
    required String startingAt,
    required String endingAt,
  }) {
    return remotebookingDataSoruce.getSlote(token, startingAt, endingAt);
  }
}
