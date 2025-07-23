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
