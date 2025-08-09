import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';
import 'package:project_k/feature/booking/presentation/model/booking_status_model.dart';
import 'package:project_k/feature/booking/presentation/model/my_booking_model.dart';
import 'package:project_k/feature/booking/presentation/model/my_bookings_model.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';
abstract class BookingRepo {
  EitherResponse<void> createBooking({
    required String token,
   required String startingAt,
   required String endingAt,
   required String date
  });
  EitherResponse<List<MySloteModel>> GetSlote({
    required String token,
   required String startingAt,
   required String endingAt,
  });
   EitherResponse<void> deletSlote({
    required String token,
   required int id,
  });
     EitherResponse<List<BookingModel>> getMyBooking({
    required String token,
  });
    EitherResponse<BookingStatusUpdate> confirmBooking({
    required String token,
     required int id,
    required String new_status  });
    EitherResponse<void> Book({
     required int slote_id,
    required String token});
    EitherResponse<void> cancelMyBook({
     required int barber_id,
    required String token});
    EitherResponse<List< MyBookingModel>> MyBook();
}
