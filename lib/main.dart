import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/view/mainpage.dart';
import 'package:wallpaper_app/controller/providers/imagescreenprovider.dart'; // Import your provider

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchResultsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
