import 'package:flutter/material.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';

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
      body: ListView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
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
                        Text("Tandoo", style: AppText.standardText),
                        kHeight15,
                        Row(
                          children: [
                            Text("24/12/2002", style: AppText.h1Dark),
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
                      Text("9 Am", style: AppText.standardText),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
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
      ),
    );
  }
}
