import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/views/home/home_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "lib/.env");
  setupLocator();
  isLoggedIn();
  final prefs = await SharedPreferences.getInstance();
  final isloggedIn = prefs.getBool('isLoggedIn') ?? false;
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  runApp(AppEntry(isLoggedIn: isloggedIn, isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});

  final router = locator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();
    final isDark = model.themeMode == ThemeMode.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: model.themeMode,
        routerConfig: router.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

void isLoggedIn() async {
  final router = locator<AppRouter>();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  if (isLoggedIn) {
    router.replace(HomoViewRoute());
  } else {
    router.replace(LoginViewRoute());
  }
}

class AppEntry extends StatelessWidget {
  final bool isLoggedIn;
  final bool isDarkMode;

  const AppEntry({required this.isLoggedIn, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(initialDarkMode: isDarkMode),
      child: MyApp(isLoggedIn: isLoggedIn),
    );
  }
}
