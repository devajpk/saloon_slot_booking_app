import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/screen_utilse/image_loaded.dart';
import 'package:project_k/comman/services/network_services.dart';
import 'package:project_k/comman/shared_prefernce/shared_preference.dart';
import 'package:project_k/comman/widget/bottom_naviagator.dart';
import 'package:project_k/feature/authentication/presentation/view/login_page.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_bloc.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // Optional short delay for splash effect
    await Future.delayed(const Duration(seconds: 2));
    final token = await SharedPrefHelper.getToken();

    print("🔐 Token from shared pref: $token");

    if (token != null && token.isNotEmpty) {
          NetworkService.initAuthToken(() => token);
      final isValid = await _validateToken();

      if (isValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ScreenParentNavigation()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  Future<bool> _validateToken() async {
    final completer = Completer<bool>();
    final bloc = context.read<HomeBloc>();

    final subscription = bloc.stream.listen((state) {
      if (state.isLoaded) {
        context.read<HomeBloc>().add(
                                  GetShopDetails(context: context),
                                );
        completer.complete(true);
      } else if (state.error != null && state.error!.isNotEmpty) {
        completer.complete(false);
      }
    }
    );

    bloc.add(GetProfile(context: context));
    return completer.future
        .timeout(const Duration(seconds: 10), onTimeout: () => false)
        .whenComplete(() => subscription.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFBFAF8),
      body: Center(
        child: CustomeImageLoader(
          imagePath:
              'assets/icons/WhatsApp Image 2025-07-31 at 22.35.28_c0b5bd5a.jpg',
          hight: 200,
          width: 300,
          boxFit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
