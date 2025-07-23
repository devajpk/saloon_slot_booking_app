import 'package:flutter/material.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/feature/booking/presentation/view/barber_booking_page.dart';
import 'package:project_k/feature/booking/presentation/view/barber_home_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/home_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/near_me_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/profile_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/search_page.dart';

final pageNotifier = ValueNotifier(0);

class ScreenParentNavigation extends StatefulWidget {
  ScreenParentNavigation({super.key});

  @override
  State<ScreenParentNavigation> createState() => _ScreenParentNavigationState();
}

class _ScreenParentNavigationState extends State<ScreenParentNavigation> {
  String? userRole;
  final List<Widget> customerScreens = [
    HomePage(),
    SearchPage(),
    NearMePage(),
    ProfileScreen(),
  ];

  final List<Widget> barberScreens = [
    BarberHomePage(),
    BarberBookingsPage(), // You can replace with Barber-specific screens
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    loadRole();
  }

  void loadRole() async {
    userRole = await SharedPrefHelper.getRole(); // Expects getRole() method
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screens = userRole == 'barber' ? barberScreens : customerScreens;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (context, value, _) => screens[pageNotifier.value],
      ),
      // bottomNavigationBar: NavigationBar(pageNotifier: pageNotifier),
      bottomNavigationBar: SafeArea(
        top: false,
        left: false,
        right: false,
        child: NavigationBar(pageNotifier: pageNotifier),
      ),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key, required this.pageNotifier});
  final ValueNotifier<int> pageNotifier;

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  String? userRole;
  @override
  void initState() {
    super.initState();
    loadRole();
  }

  void loadRole() async {
    userRole = await SharedPrefHelper.getRole();
  }

  @override
  Widget build(BuildContext context) {
    final isBarber = userRole == 'barber';
    return ValueListenableBuilder(
      valueListenable: widget.pageNotifier,
      builder: (context, value, _) {
        return Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 4),
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
                  isBarber
                      ? [
                        bottomNavigationItems(
                          imagePath: 'assets/icons/Vector (27).png',
                          label: 'Home',
                          onTap: () => widget.pageNotifier.value = 0,
                          isSelected: widget.pageNotifier.value == 0,
                        ),
                        bottomNavigationItems(
                          imagePath: 'assets/icons/Group (6).png',
                          label: 'my Booking',
                          onTap: () => widget.pageNotifier.value = 1,
                          isSelected: widget.pageNotifier.value == 1,
                        ),
                        bottomNavigationItems(
                          imagePath: 'assets/icons/Group (7).png',
                          label: 'profile',
                          onTap: () => pageNotifier.value = 2,
                          isSelected: pageNotifier.value == 2,
                        ),
                      ]
                      : [
                        bottomNavigationItems(
                          imagePath: 'assets/icons/Vector (27).png',
                          label: 'Home',
                          onTap: () => widget.pageNotifier.value = 0,
                          isSelected: widget.pageNotifier.value == 0,
                        ),
                        bottomNavigationItems(
                          imagePath: 'assets/icons/Vector (28).png',
                          label: 'search',
                          onTap: () => pageNotifier.value = 1,
                          isSelected: pageNotifier.value == 1,
                        ),
                        bottomNavigationItems(
                          imagePath: 'assets/icons/Group (6).png',
                          label: 'near me',
                          onTap: () => pageNotifier.value = 2,
                          isSelected: pageNotifier.value == 2,
                        ),
                        bottomNavigationItems(
                          imagePath: 'assets/icons/Group (7).png',
                          label: 'profile',
                          onTap: () => pageNotifier.value = 3,
                          isSelected: pageNotifier.value == 3,
                        ),
                      ],
            ),
          ),
        );
      },
    );
  }

  Expanded bottomNavigationItems({
    required String label,
    required String imagePath,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: isSelected ? 30 : 25, // Increase size when selected
              width: isSelected ? 30 : 25,
              color: isSelected ? Colors.black : Colors.grey.shade500,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey.shade500,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
