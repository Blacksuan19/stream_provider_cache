import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider_cache/src/pages/home.dart';
import 'package:stream_provider_cache/src/utils/utils.dart';

void main() async => runApp(
      ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: AppTheme.buildMaterialColor(AppTheme.accentColor),
            scaffoldBackgroundColor: AppTheme.backgroundColor,
          ),
          home: const Home(),
        ),
      ),
    );
