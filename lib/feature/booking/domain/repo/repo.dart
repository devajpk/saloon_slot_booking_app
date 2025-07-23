import 'package:project_k/comman/typedef/typedef.dart';
import 'package:project_k/feature/authentication/presentation/view_model/models/Sign_up_model.dart';
import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';
abstract class BookingRepo {
  EitherResponse<SignUpResponseModel> createBooking({
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
}
