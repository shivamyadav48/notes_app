import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router/app_router.dart';
import 'config/themes/theme_provider.dart';

class DriveNotesApp extends ConsumerWidget {
  const DriveNotesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'DriveNotes',

      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: router,
    );
  }
}
