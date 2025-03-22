import 'package:casavacanze_app/core/app_bar.dart';
import 'package:casavacanze_app/pages/home/home_app_bar.dart';
import 'package:casavacanze_app/pages/home/home_content.dart';
import 'package:casavacanze_app/pages/login/login_page.dart';
import 'package:casavacanze_app/service/http_login.dart';
import 'package:casavacanze_app/service/token.dart' as TokenStorage;
import 'package:casavacanze_app/widget/house_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CasaVacanzeApp());
}

class CasaVacanzeApp extends StatelessWidget {
  const CasaVacanzeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Casa Vacanze',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse && _isAppBarVisible) {
        setState(() => _isAppBarVisible = false);
      } else if (direction == ScrollDirection.forward && !_isAppBarVisible) {
        setState(() => _isAppBarVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: HomeContent(scrollController: _scrollController)),
      bottomNavigationBar: AnimatedSlide(
        duration: Duration(milliseconds: 300),
        offset: _isAppBarVisible ? Offset.zero : Offset(0, 1),
        child: HomeBottomAppBar(
          currentIndex: _selectedIndex,
          onTabSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

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
