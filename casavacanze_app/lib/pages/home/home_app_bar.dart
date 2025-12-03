import 'package:flutter/material.dart';

/// The app bar used on the Home screen.
///
/// It supports a title mode and a search mode, allowing users to filter content.
class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Callback function triggered when the search text changes.
  final Function(String) onSearch;

  /// Whether the title should be centered.
  final bool centerTitle;

  /// Whether the search button is visible.
  final bool showSearch;

  /// Creates a [HomeAppBar].
  ///
  /// [onSearch] handles search input updates.
  /// [centerTitle] controls title alignment.
  /// [showSearch] toggles the visibility of the search action.
  const HomeAppBar({
    super.key,
    required this.onSearch,
    required this.centerTitle,
    required this.showSearch,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          final scaleAnimation = Tween<double>(
            begin: 0.95,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ));

          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: _isSearching
            ? TextField(
                key: const ValueKey('searchField'),
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Cerca...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: widget.onSearch,
              )
            : Align(
                key: ValueKey('titleText-${widget.centerTitle}'),
                alignment: Alignment.centerLeft,
                child: widget.centerTitle
                    ? Center(
                        child: Text(
                          'Key & Dreams',
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      )
                    : Text(
                        'Key & Dreams',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
              ),
      ),
      actions: [
        !widget.centerTitle
            ? IconButton(
                icon: Icon(
                  _isSearching ? Icons.close : Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    if (!_isSearching) {
                      _searchController.clear();
                      widget.onSearch('');
                    }
                  });
                },
              )
            : SizedBox(),
      ],
    );
  }
}
