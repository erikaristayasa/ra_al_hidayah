import 'package:flutter/material.dart';

import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool canBack;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? customBackAction;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.canBack = false,
    this.leading,
    this.trailing,
    this.customBackAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      leading: canBack
          ? CustomBackButton(
              customAction: customBackAction,
            )
          : leading,
      actions: trailing != null ? [trailing!] : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
