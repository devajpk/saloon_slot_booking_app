import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/asset_image.dart';
import 'package:project_k/comman/screen_utilse/image_loaded.dart';
import 'package:project_k/comman/screen_utilse/launcher.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/comman/utilse/utilse.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_bloc.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_state.dart';

class BarberBookingsPage extends StatefulWidget {
  const BarberBookingsPage({super.key});

  @override
  State<BarberBookingsPage> createState() => _BarberBookingsPageState();
}

class _BarberBookingsPageState extends State<BarberBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4E7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F4E7),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        centerTitle: true,
        title: const Text(
          "My Bookings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.booking.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomeImageLoader(
                      imagePath: AssetImages.emptyIcon,
                      width: 100,
                      hight: 100,
                      boxFit: BoxFit.fitWidth,
                    ),
                    kHeight15,
                    Text("no bookings found"),
                  ],
                ),
              );
            }
            if (state.booking.isNotEmpty) {
              final data = state.booking;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 0.5,
                          color: AppColor.borderColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    state.booking[index].slotDate ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                  ),
                                ],
                              ),
                              Text(
                                "${state.booking[index].startTime} - ${state.booking[index].endTime}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          kHeight7,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Customer name : ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        state.booking[index].customerName ?? '',
                                        style: AppText.standardText,
                                      ),
                                    ],
                                  ),
                                  kHeight7,
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap:
                                            () => UrlLauncherUtil.callNumber(
                                              context,
                                              state
                                                  .booking[index]
                                                  .customerPhone!,
                                            ),
                                        child: Icon(Icons.call, size: 22),
                                      ),
                                      kWidth2,
                                      Text(
                                        state.booking[index].customerPhone ??
                                            '',
                                        style: AppText.standardText,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      data[index].status == 'pending'
                                          ? Colors.green
                                          : Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                ),
                                onPressed: () {
                                  String newStatus =
                                      data[index].status == 'pending'
                                          ? 'confirmed'
                                          : 'cancelled';

                                  context.read<BookingBloc>().add(
                                    ConfirmStatus(
                                      new_status: newStatus,
                                      id: data[index].bookingId!,
                                      context: context,
                                    ),
                                  );
                                },
                                child: Text(
                                  data[index].status == 'pending'
                                      ? "Confirm"
                                      : "Cancel",
                                  style: TextStyle(color: Colors.white),
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
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
