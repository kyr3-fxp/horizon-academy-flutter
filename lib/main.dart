import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/app_colors.dart';
import 'controllers/school_controller.dart';
import 'views/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HorizonAcademyApp());
}

class HorizonAcademyApp extends StatelessWidget {
  const HorizonAcademyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SchoolController(),
      child: MaterialApp(
        title: 'Horizon International Academy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            surface: AppColors.bgMain,
          ),
          scaffoldBackgroundColor: AppColors.bgMain,
        ),
        home: const HomePage(),
      ),
    );
  }
}
