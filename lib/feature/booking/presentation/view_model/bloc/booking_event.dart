import 'package:flutter/material.dart';

abstract class Booking {}

class CreateBooking extends Booking {
  final String startingTime;
  final String endingTime;
  final String data;
  final BuildContext context;

  CreateBooking({
    required this.data,
    required this.startingTime,
    required this.endingTime,
    required this.context,
  });
}
class GetSlote extends Booking {
   String startingTime;
   String endingTime;
  final BuildContext context;

  GetSlote({
    required this.startingTime,
    required this.endingTime,
    required this.context,
  });
}
class ConfirmStatus extends Booking {
   int id;
   String new_status;
  final BuildContext context;

  ConfirmStatus({
    required this.id,
    required this.new_status,
    required this.context,
  });
}
class Book extends Booking {
   int slote_id;
  final BuildContext context;

  Book({
    required this.slote_id,
    required this.context,
  });
}
class MyBook extends Booking {
  final BuildContext context;

  MyBook({
    required this.context,
  });
}
class CancelMyBook extends Booking {
  int booking_id;
  final BuildContext context;

  CancelMyBook({
    required this.booking_id,
    required this.context,
  });
}
class GetMyBooking extends Booking {
  final BuildContext context;

  GetMyBooking({
    required this.context,
  });
}
class DeteSlote extends Booking {
   int id;
  final BuildContext context;

  DeteSlote({
    required this.id,
    required this.context,
  });
}