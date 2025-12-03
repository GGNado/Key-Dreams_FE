import 'package:casavacanze_app/service/token.dart';
import 'package:casavacanze_app/pages/login/login_page.dart';
import 'package:flutter/material.dart';

/// A custom bottom navigation bar for the home screen.
///
/// Provides navigation to Home, Profile, and a Logout action.
class HomeBottomAppBar extends StatelessWidget {
  /// Callback when a tab is selected.
  final Function(int) onTabSelected;

  /// The index of the currently active tab.
  final int currentIndex;

  /// Callback executed when the Home icon is tapped.
  final void Function() onClickHome;

  /// Callback executed when the Profile icon is tapped.
  final void Function() onClickProfilo;

  /// Creates a [HomeBottomAppBar].
  ///
  /// [onTabSelected] reports tab index changes.
  /// [currentIndex] indicates which tab is active.
  /// [onClickHome] and [onClickProfilo] handle specific tap events.
  const HomeBottomAppBar({
    Key? key,
    required this.onTabSelected,
    required this.currentIndex,
    required this.onClickHome,
    required this.onClickProfilo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: onClickHome,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: currentIndex == 0 ? Colors.white : Colors.white70,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: onClickProfilo,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: currentIndex == 1 ? Colors.white : Colors.white70,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text('Conferma Logout'),
                        content: const Text('Confermi di voler uscire?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(false),
                            child: const Text('Annulla'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(true),
                            child: const Text('Conferma'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirm == true) {
                    await clearToken();
                    await clearUser();
                    if (context.mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                      );
                    }
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
    );
  }
}
