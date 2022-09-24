
import 'package:flutter/material.dart';
import 'package:my_qr/pages/pages.dart';

class AppRoutes {

  static const initialRoute = 'home';

  static Map<String, WidgetBuilder> get routes {
    return {
      'scan': (_) => const ScanPage(),
      'home': (_) => const HomePage()
    };
  }
}