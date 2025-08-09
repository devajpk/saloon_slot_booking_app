import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_bloc.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_state.dart';
import 'package:shimmer/shimmer.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F4E9),
        centerTitle: true,
        title: Text("My Booking", style: AppText.appBartext),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state.isLoading) {
            return _buildShimmerList();
          }

          if (state.myBook.isNotEmpty) {
            final bookings = state.myBook;

            if (bookings.isEmpty) {
              return const Center(child: Text("No bookings found."));
            }

            return ListView.builder(
              itemCount: bookings.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final booking = bookings[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColor.borderColor),
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Side
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                booking.shopName,
                                style: AppText.standardText,
                              ),
                              kHeight15,
                              Row(
                                children: [
                                  Text(booking.slotDate, style: AppText.h1Dark),
                                  kWidth5,
                                  const Icon(Icons.calendar_today, size: 16),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Right Side
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              booking.startTime,
                              style: AppText.standardText,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // cancel logic
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                "cancel",
                                style: AppText.smallBlack.copyWith(
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 4,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 100,
          ),
        );
      },
    );
  }
}
