import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import ' app_theme.dart' as AppTheme;

final isDarkModeProvider = StateProvider<bool>((ref) => false);

final themeProvider = Provider<ThemeData>((ref) {
  final isDark = ref.watch(isDarkModeProvider);
  return isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
});
