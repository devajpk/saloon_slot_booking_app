import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_k/feature/authentication/data/data_source/remote_data_sorce.dart';
import 'package:project_k/feature/authentication/data/repositories/repo_imp.dart';
import 'package:project_k/feature/authentication/presentation/view/splash_screen.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_bloc.dart';
import 'package:project_k/feature/booking/data/data_source/booking_remote_data_Source.dart';
import 'package:project_k/feature/booking/data/repo/repo_imp.dart';
import 'package:project_k/feature/booking/presentation/view_model/bloc/booking_bloc.dart';
import 'package:project_k/feature/dashboard/data/data_sorce/remote_data_Source.dart';
import 'package:project_k/feature/dashboard/data/repo/repo_imp.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authRepo = AuthenticationRepoImpl(
      remoteDataSoruce: RemoteAuthDataSource(),
    );
    final homeRepo = HomeRepoImpl(dataSource: RemoteHomeDataSource());
     final bookingrepo = BookingImp(remotebookingDataSoruce: RemoteBookingDataSource());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(authRepo: authRepo),
        ),
        BlocProvider(create: (context) => HomeBloc(homeRepo: homeRepo)),
         BlocProvider(create: (context) => BookingBloc(bookingrepo: bookingrepo)),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => const MaterialApp(home: SplashScreen()),
      ),
    );
  }
}
