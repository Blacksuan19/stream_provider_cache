import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  const CustomAppBar({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(text),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.accentColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.accentColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppTheme.accentColor,
          systemNavigationBarDividerColor: AppTheme.accentColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
