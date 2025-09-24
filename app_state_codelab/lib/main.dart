import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'state/global_state.dart';
import 'pages/counters_page.dart';

// Entry point aplikasi
void main() => runApp(const MyApp());

/// Root widget aplikasi dengan Global State Management
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<GlobalState>(
      model: GlobalState(),
      child: MaterialApp(
        title: 'Global State Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardTheme: const CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        home: const CountersPage(),
      ),
    );
  }
}
