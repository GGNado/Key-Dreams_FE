import 'package:flutter/material.dart';

/// A custom app bar widget used across the application.
///
/// This widget implements [PreferredSizeWidget] to be used in the `appBar` property of a [Scaffold].
/// It provides a consistent look with a title, optional back button, and optional actions.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text to display in the app bar.
  final String title;

  /// Whether to show the back button.
  ///
  /// Defaults to `false`.
  final bool showBackButton;

  /// A list of widgets to display in a row after the [title] widget.
  ///
  /// Typically these are [IconButton]s representing common operations.
  final List<Widget>? actions;

  /// Creates a [CustomAppBar].
  ///
  /// [key] is the widget key.
  /// [title] is required and sets the text in the app bar.
  /// [showBackButton] determines visibility of the leading back arrow.
  /// [actions] provides additional action buttons on the right side.
  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.actions,
  }) : super(key: key);

  /// The size of the app bar.
  ///
  /// Returns a [Size] with height [kToolbarHeight].
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// Builds the [AppBar] widget.
  ///
  /// Returns an [AppBar] configured with the provided [title], [showBackButton] logic,
  /// background color, and [actions].
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          showBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
              : null,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      centerTitle: true,
      backgroundColor: Colors.orange,
      elevation: 4,
      actions: actions,
    );
  }
}
