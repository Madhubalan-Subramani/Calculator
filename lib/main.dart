import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/features/core/screens/age_cal_screen.dart';
import 'src/features/core/screens/basic_cal_screen.dart';
import 'src/features/core/screens/category_screen.dart';
import 'src/features/core/screens/date_difference_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BasicCalScreen(),
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      getPages: [
        GetPage(name: '/category', page: () => const CategoryScreen()),
        GetPage(name: '/basicCal', page: () => const BasicCalScreen()),
        GetPage(name: '/ageCal', page: () => const AgeCalScreen()),
        GetPage(
            name: '/differenceCal',
            page: () => const DateDifferenceCalScreen()),
      ],
    );
  }
}
