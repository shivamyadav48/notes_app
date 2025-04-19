import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/notes/presentation/screens/notes_list_screen.dart';
import '../../../features/notes/presentation/screens/note_edit_screen.dart';
import '../../../features/notes/domain/entities/note.dart';
import '../../../features/notes/presentation/screens/note_detail_screen.dart';
import '../../features/auth/presentation/screen/login_screen.dart';

class AppRoutes {
  static const login = 'login';
  static const notesList = 'notes_list';
  static const noteEdit = 'note_edit';
  static const noteDetail = 'note_detail';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/notes',
        name: AppRoutes.notesList,
        builder: (context, state) => const NotesListScreen(),
      ),
      GoRoute(
        path: '/edit',
        name: AppRoutes.noteEdit,
        builder: (context, state) {
          final note = state.extra as Note?;
          return NoteEditScreen(note: note);
        },
      ),
      GoRoute(
        path: '/view',
        name: AppRoutes.noteDetail,
        builder: (context, state) {
          final note = state.extra as Note;
          return NoteDetailScreen(note: note);
        },
      ),
    ],
  );
});
