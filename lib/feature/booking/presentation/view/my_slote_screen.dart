import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/asset_image.dart';
import 'package:project_k/comman/screen_utilse/image_loaded.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_bloc.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_state.dart';
import 'package:project_k/feature/booking/presentation/model/barber_my_slote.dart';

class MySlotPage extends StatefulWidget {
  @override
  State<MySlotPage> createState() => _MySlotPageState();
}

class _MySlotPageState extends State<MySlotPage> {
  DateTime? startDate;
  DateTime? endDate;

  String _formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => startDate = picked);
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => endDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4DE),
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "My Slots",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Date pickers and submit button
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Start time", style: AppText.tSmallDarkBold),
                      kHeight2,
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () => _selectStartDate(context),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _formatDate(startDate),
                              style: AppText.tSmallDarkBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),

                kHeight2,
                Expanded(
                  child: Column(
                    children: [
                      Text("End date", style: AppText.tSmallDarkBold),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () => _selectEndDate(context),
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _formatDate(endDate),
                              style: AppText.tSmallDarkBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    kHeight15,
                    ElevatedButton(
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
                      onPressed: () {
                        final formattedStart = _formatDate(startDate);
                        final formattedEnd = _formatDate(endDate);
                        context.read<BookingBloc>().add(
                          GetSlote(
                            startingTime: formattedStart,
                            endingTime: formattedEnd,
                            context: context,
                          ),
                        );
                      },
                      child: Text(
                        "Submit",
                        style: AppText.extraBoldMediumDark.copyWith(
                          color: AppColor.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Slot list
            Expanded(
              child: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.mySlote.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomeImageLoader(
                          imagePath: AssetImages.emptyIcon,
                          width: 100,
                          hight: 100,
                          boxFit: BoxFit.fitWidth,
                        ),
                        Text("Select dates", style: AppText.h1Dark),
                      ],
                    );
                  }

                  return ListView.builder(
                    itemCount: state.mySlote.length,
                    itemBuilder: (context, index) {
                      final slot = state.mySlote[index];
                      return MySlotes(slot: slot);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySlotes extends StatelessWidget {
  const MySlotes({super.key, required this.slot});

  final MySloteModel slot;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          "Date: ${slot.slotDate}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "From ${slot.startTime} to ${slot.endTime}\nBooked: ${slot.isBooked ? 'Yes' : 'No'}",
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[400],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            context.read<BookingBloc>().add(
              DeteSlote(id: slot.id, context: context),
            );

            // TODO: add delete event
            print("Delete slot ID: ${slot.id}");
          },
          child: const Text("Delete"),
        ),
      ),
    );
  }
}
