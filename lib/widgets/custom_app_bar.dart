import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final Color? backgroundColor;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
    this.centerTitle = true,
    this.backgroundColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: actions,
      bottom: bottom,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      leading: leading,
      elevation: 2,
      shadowColor: Colors.black26,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}