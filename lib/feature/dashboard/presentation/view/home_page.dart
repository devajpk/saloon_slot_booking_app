import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/asset_image.dart';
import 'package:project_k/comman/screen_utilse/image_loaded.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart'
    show kHeight11, kHeight13, kHeight15, kWidth15;
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/comman/widget/searchfield.dart';
import 'package:project_k/feature/booking/presentation/view/booking_page.dart';
import 'package:project_k/feature/booking/presentation/view/my_booking_screen.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_bloc.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_event.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_bloc.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F0DA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F0DA),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/profile.jpg',
              ), // Replace with your image
            ),
            const SizedBox(width: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Hi devaj\n', style: AppText.mediumBoldGrey),
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextfieldWidget(hintText: "search", onChanged: (onchange) {}),
            kHeight15,
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("My Booking", style: AppText.standardText),
                                kHeight15,
                                Text(
                                  "1",
                                  style: AppText.largeBoldImportant.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // context.read<HomeBloc>().add(
                                //   GetShopDetails(context: context),
                                // );
                                context.read<BookingBloc>().add(
                                  MyBook(context: context),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const MyBookingScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.darkGreen,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.shopping_bag_outlined),
                                  Text(
                                    "bookings",
                                    style: AppText.extraBoldMediumDark.copyWith(
                                      color: AppColor.white,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            kHeight11,
            const Text(
              "Recommended",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            kHeight13,

            // 📦 Card
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.borderColor),
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🖼️ Image
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    child: CustomeImageLoader(
                      imagePath: AssetImages.saloonImage,
                      boxFit: BoxFit.fitHeight,
                      hight: 150,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tandoo",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BookingScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFDCA49),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Book"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColor.darkGreen,
                                ),
                                child: const Text(
                                  "open",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            kWidth15,
                            Text(
                              "📍 Thara, cherukunnu",
                              style: AppText.tSmallGrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
