import 'package:casavacanze_app/service/token.dart';
import 'package:casavacanze_app/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class HomeBottomAppBar extends StatelessWidget {
  final Function(int) onTabSelected;
  final int currentIndex;

  const HomeBottomAppBar({
    Key? key,
    required this.onTabSelected,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEE7724),
              Color(0xFFD8363A),
              Color(0xFFDD3675),
              Color(0xFFB44593),
            ],
          ),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => onTabSelected(0),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        color:
                            currentIndex == 0 ? Colors.white : Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => onTabSelected(1),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color:
                            currentIndex == 1 ? Colors.white : Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    await clearToken();
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    }
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.logout, color: Colors.white70)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
