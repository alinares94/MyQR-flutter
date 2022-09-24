import 'package:flutter/material.dart';
import 'package:my_qr/providers/providers.dart';
import 'package:my_qr/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesProvider.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkMode: PreferencesProvider.isDarkMode))
      ],
      child: const MyQrApp()
    )
  );
}

class MyQrApp extends StatelessWidget {
  
  const MyQrApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My QR',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes
    );
  }

  
}