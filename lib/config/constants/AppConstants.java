class AppConstants {
  const AppConstants._();

  // App information
  static const String appName = 'DriveNotes';
  static const String appVersion = '1.0.0';
  
  // Storage keys
  static const String userKey = 'user_info';
  static const String notesKey = 'cached_notes';
  static const String themeKey = 'app_theme';
  
  // Routes
  static const String loginRoute = '/login';
  static const String notesRoute = '/notes';
  static const String noteDetailRoute = '/notes/:id';
  static const String noteEditRoute = '/notes/:id/edit';
  static const String createNoteRoute = '/notes/create';
}