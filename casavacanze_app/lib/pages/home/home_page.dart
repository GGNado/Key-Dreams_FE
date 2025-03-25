import 'dart:convert';

import 'package:casavacanze_app/core/app_bar.dart';
import 'package:casavacanze_app/pages/home/home_app_bar.dart';
import 'package:casavacanze_app/pages/home/home_bottom_app_bar.dart';
import 'package:casavacanze_app/pages/home/home_content.dart';
import 'package:casavacanze_app/pages/login/login_page.dart';
import 'package:casavacanze_app/service/http_login.dart';
import 'package:casavacanze_app/service/token.dart' as TokenStorage;
import 'package:casavacanze_app/pages/home/house_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import '../user/user_profile.dart';

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
  final GlobalKey<HomeContentState> homeContentKey = GlobalKey<HomeContentState>();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> houses = [];
  List<Map<String, dynamic>> caseFiltrate = [];
  int _selectedIndex = 0;
  bool _isAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final direction = _scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse && _isAppBarVisible) {
        setState(() => _isAppBarVisible = false);
      } else if (direction == ScrollDirection.forward && !_isAppBarVisible) {
        setState(() => _isAppBarVisible = true);
        debugPrint("AppBar visibile");
      }
    });
  }

  void onClickHome(){
    print("Click sulla home");
    setState(() {
      _selectedIndex = 0;
    });
  }

  void onClickProfilo(){
    setState(() {
      print("Click sulla profilo");
      _selectedIndex = 1;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFEE7724), // Arancione acceso
            Color(0xFFD8363A), // Rosso scuro
            Color(0xFFDD3675), // Rosa acceso
            Color(0xFFB44593), // Viola intenso
          ],
        ),
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _isAppBarVisible ? 1.0 : 0.0,
            child: HomeAppBar(onSearch: (String query) {
              homeContentKey.currentState?.filterHouses(query);
            }),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(
              scale: animation,
              child: RotationTransition(
                turns: Tween<double>(begin: 0.05, end: 0.0).animate(animation),
                child: child,
              ),
            );
          },
          child: _selectedIndex == 0
              ? Center(
                  key: ValueKey(0),
                  child: HomeContent(key: homeContentKey, scrollController: _scrollController),
                )
              : const UserProfileContent(key: ValueKey(1)),
        ),
        bottomNavigationBar: HomeBottomAppBar(
          onClickProfilo: onClickProfilo,
          onClickHome: onClickHome,
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
