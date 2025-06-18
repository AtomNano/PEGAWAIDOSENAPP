import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/dosen_list_page.dart';
import 'screens/add_dosen_page.dart';
import 'screens/dosen_detail_page.dart';
import 'models/dosen_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Dosen CRUD',
      debugShowCheckedModeBanner: false, // Hide debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Custom font if desired, make sure it's in pubspec.yaml
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white, // For icons and text
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.amber), // Accent color
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/dosenList': (context) => const DosenListPage(),
        '/addDosen': (context) => const AddDosenPage(),
        '/dosenDetail': (context) {
          final dosen = ModalRoute.of(context)!.settings.arguments as Dosen;
          return DosenDetailPage(dosen: dosen);
        },
      },
    );
  }
}