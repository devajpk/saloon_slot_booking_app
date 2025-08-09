import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/asset_image.dart';
import 'package:project_k/comman/screen_utilse/image_loaded.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/comman/shimmer/barber_home_screen_shimmer.dart';
import 'package:project_k/comman/widget/searchfield.dart';
import 'package:project_k/feature/booking/presentation/view/my_slote_screen.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_bloc.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_state.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_bloc.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_state.dart';

class BarberHomePage extends StatefulWidget {
  const BarberHomePage({super.key});

  @override
  State<BarberHomePage> createState() => _BarberHomePageState();
}

class _BarberHomePageState extends State<BarberHomePage> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        endTime = picked;
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return "--:--:--";
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.Hms().format(dt); // "HH:mm:ss"
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return BarberHomeScreenShimmer();
        }
        return Scaffold(
          backgroundColor: const Color(0xFFF5F4E7),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColor.primaryColor,
                  backgroundImage: AssetImage(
                    'assets/icons/owl-logo-stylized-blue-owl-logo-design-6bu8QXk6.jpg',
                  ),
                ),
                const SizedBox(width: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "${state.profile[0].username}\n",
                        style: AppText.mediumBoldGrey,
                      ),
                      TextSpan(text: 'welcome !', style: AppText.standardText),
                    ],
                  ),
                ),
                const Spacer(),
                CustomeImageLoader(
                  imagePath: AssetImages.bellIcon,
                  width: 24,
                  hight: 24,
                  boxFit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SearchTextfieldWidget(
                  hintText: "search",
                  onChanged: (onchange) {},
                ),
                kHeight15,
                const SizedBox(height: 20),
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "My slot",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Text(
                              "2 Slot",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 6),
                            InkWell(
                              onTap: () async {
                                final token = await SharedPrefHelper.getToken();
                                print(" EEEEE $token");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MySlotPage(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "slots",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Add slot",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Start Time
                    Expanded(
                      child: Column(
                        children: [
                          Text("start Time", style: AppText.smallBlack),
                          kHeight2,
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () => _selectStartTime(context),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _formatTimeOfDay(startTime),
                                  style: AppText.tSmallDarkBold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kWidth5,
                    // End Time
                    Expanded(
                      child: Column(
                        children: [
                          Text("End Time", style: AppText.smallBlack),
                          kHeight2,
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () => _selectEndTime(context),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _formatTimeOfDay(endTime),
                                  style: AppText.tSmallDarkBold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Date
                    Expanded(
                      child: Column(
                        children: [
                          kHeight15,
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: Container(
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _formatDate(selectedDate),
                                style: AppText.tSmallDarkBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        kHeight15,
                        BlocBuilder<BookingBloc, BookingState>(
                          builder: (context, bookingState) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.darkGreen,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed:
                                  bookingState.isLoading
                                      ? null
                                      : () {
                                        if (startTime != null &&
                                            endTime != null &&
                                            selectedDate != null) {
                                          final startDateTime = DateTime(
                                            selectedDate!.year,
                                            startTime!.hour,
                                          );
                                          final endDateTime = DateTime(
                                            endTime!.hour,
                                          );

                                          if (endDateTime.isAfter(
                                                startDateTime,
                                              ) ||
                                              startDateTime.isAtSameMomentAs(
                                                endDateTime,
                                              )) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Start time must be before end time',
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }

                                          final formattedDate = _formatDate(
                                            selectedDate,
                                          );
                                          final formattedStart =
                                              _formatTimeOfDay(startTime);
                                          final formattedEnd = _formatTimeOfDay(
                                            endTime,
                                          );

                                          context.read<BookingBloc>().add(
                                            CreateBooking(
                                              data: formattedDate,
                                              startingTime: formattedStart,
                                              endingTime: formattedEnd,
                                              context: context,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Please pick time and date',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                              child:
                                  bookingState.isLoading
                                      ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                      : Text(
                                        "Submit",
                                        style: AppText.extraBoldMediumDark
                                            .copyWith(
                                              color: AppColor.white,
                                              fontSize: 12,
                                            ),
                                      ),
                            );
                          },
                        ),
                      ],
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
}
