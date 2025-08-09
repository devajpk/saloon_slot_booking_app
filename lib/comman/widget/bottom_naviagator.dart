import 'package:flutter/material.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/feature/booking/presentation/view/barber_booking_page.dart';
import 'package:project_k/feature/booking/presentation/view/barber_home_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/home_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/near_me_page.dart';
import 'package:project_k/feature/booking/presentation/view/profile_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/search_page.dart';
import 'package:project_k/feature/dashboard/presentation/view/user_profile_page.dart';

class ScreenParentNavigation extends StatefulWidget {
  const ScreenParentNavigation({super.key});

  @override
  State<ScreenParentNavigation> createState() => _ScreenParentNavigationState();
}

class _ScreenParentNavigationState extends State<ScreenParentNavigation> {
  ValueNotifier<int> pageNotifier = ValueNotifier<int>(0);
  String? userRole;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();

    loadRole();
  }

  Future<void> loadRole() async {
    userRole = await SharedPrefHelper.getRole();
    pageNotifier = ValueNotifier(0);
    final isBarber = userRole == 'barber';

    // ✅ Reset screens based on role
    screens =
        isBarber
            ? [
              const BarberHomePage(),
              const BarberBookingsPage(),
              const ProfileScreen(),
            ]
            : [
              const HomePage(),
              const SearchPage(),
              const NearMePage(),
              const UserProfileScreen(),
            ];

    // ✅ Reset to first page to avoid range error
    pageNotifier.value = 0;

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (userRole == null || screens.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final bool isBarber = userRole == 'barber';

    return Scaffold(
      backgroundColor: AppColor.white,
      body: ValueListenableBuilder<int>(
        valueListenable: pageNotifier,
        builder: (context, index, _) {
          // ✅ Safety check to avoid RangeError
          final safeIndex = index >= screens.length ? 0 : index;
          return screens[safeIndex];
        },
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavigationBar(
          pageNotifier: pageNotifier,
          isBarber: isBarber,
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueNotifier<int> pageNotifier;
  final bool isBarber;

  const CustomBottomNavigationBar({
    super.key,
    required this.pageNotifier,
    required this.isBarber,
  });

  @override
  Widget build(BuildContext context) {
    final items =
        isBarber
            ? [
              _navItem('Home', 'assets/icons/Vector (27).png', 0),
              _navItem('My Booking', 'assets/icons/Group (6).png', 1),
              _navItem('Profile', 'assets/icons/Group (7).png', 2),
            ]
            : [
              _navItem('Home', 'assets/icons/Vector (27).png', 0),
              _navItem('Search', 'assets/icons/Vector (28).png', 1),
              _navItem('Near Me', 'assets/icons/Group (6).png', 2),
              _navItem('Profile', 'assets/icons/Group (7).png', 3),
            ];

    return Material(
      elevation: 5,
      child: Container(
        height: 70,
        padding: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }

  Expanded _navItem(String label, String iconPath, int index) {
    return Expanded(
      child: InkWell(
        onTap: () => pageNotifier.value = index,
        child: ValueListenableBuilder<int>(
          valueListenable: pageNotifier,
          builder: (context, value, _) {
            final isSelected = value == index;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  iconPath,
                  height: isSelected ? 30 : 25,
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
            );
          },
        ),
      ),
    );
  }
}
