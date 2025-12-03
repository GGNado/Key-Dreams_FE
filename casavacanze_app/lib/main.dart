import 'package:casavacanze_app/core/app_bar.dart';
import 'package:casavacanze_app/pages/home/home_page.dart';
import 'package:casavacanze_app/pages/login/login_page.dart';
import 'package:casavacanze_app/service/http_login.dart';
import 'package:casavacanze_app/service/token.dart' as TokenStorage;
import 'package:flutter/material.dart';

/// The entry point of the application.
///
/// Ensures Flutter bindings are initialized and runs the [CasaVacanzeApp].
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CasaVacanzeApp());
}

/// The root widget of the Casa Vacanze application.
///
/// This widget sets up the [MaterialApp], including the title, theme,
/// and the home screen which starts with [SplashScreen].
class CasaVacanzeApp extends StatelessWidget {
  /// Creates an instance of [CasaVacanzeApp].
  ///
  /// [key] is the widget key.
  const CasaVacanzeApp({super.key});

  /// Builds the widget tree for the application.
  ///
  /// Returns a [MaterialApp] widget configured with the app's theme and initial route.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Casa Vacanze',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const SplashScreen(),
    );
  }
}

/// A splash screen widget displayed when the app launches.
///
/// This widget handles checking the user's login status (token validation)
/// and navigates to either the [HomePage] or [LoginPage] accordingly.
class SplashScreen extends StatefulWidget {
  /// Creates an instance of [SplashScreen].
  ///
  /// [key] is the widget key.
  const SplashScreen({super.key});

  /// Creates the mutable state for this widget at a given location in the tree.
  ///
  /// Returns a [_SplashScreenState] which handles the login check logic.
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  /// Checks the login status by verifying the stored token.
  ///
  /// If a token exists and is valid, navigates to [HomePage].
  /// Otherwise, navigates to [LoginPage].
  Future<void> _checkLoginStatus() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
      return;
    }

    await Future.delayed(const Duration(seconds: 2)); // Simula caricamento
    if (!mounted) return;
    final isValid = await HttpLogin.validateToken(token);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isValid ? const HomePage() : const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/img/logo.png'), height: 120),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
