import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/themes/theme_provider.dart';
import '../../../../shared/widgets/common/error_widget.dart';
import '../../../../shared/widgets/common/loading_widget.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/notes_providers.dart';
import '../widgets/note_card.dart';
import '../../../../../config/router/app_router.dart';
import '../../domain/entities/note.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesListProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;
    final textColor = colorScheme.onPrimary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: [
            Icon(Icons.note_add, color: textColor),
            const SizedBox(width: 10),
            Text(
              'DriveNotes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                ),
              ),
            ),

            SwitchListTile(
              title: Text(
                'Dark Mode',
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              ),
              value: isDarkMode,
              onChanged: (value) {
                ref.read(isDarkModeProvider.notifier).state = value;
              },
              secondary: Icon(Icons.dark_mode, color: theme.iconTheme.color),
            ),

            const Divider(),

            // 🔐 Logout Tile
            ListTile(
              leading: Icon(Icons.logout, color: theme.iconTheme.color),
              title: Text(
                'Logout',
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              ),
              onTap: () async {
                final shouldLogout = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel',
                          style: TextStyle(
                              color: Colors.black
                          ),),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Logout',
                        style: TextStyle(
                          color: Colors.black
                        ),),
                      ),
                    ],
                  ),
                );

                if (shouldLogout == true) {
                  await ref.read(logoutUseCaseProvider).call();
                  context.goNamed(AppRoutes.login);
                }
              },
            ),
          ],
        ),
      )
,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor.withOpacity(0.3),
              theme.scaffoldBackgroundColor,
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 12),
                child: Text(
                  'My Notes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onBackground,
                  ),
                ),
              ),
              Expanded(
                child: notesAsync.when(
                  data: (notes) => notes.isEmpty
                      ? _buildEmptyState(context, primaryColor)
                      : _buildNotesList(notes),
                  loading: () => const LoadingWidget(),
                  error: (err, _) => CustomErrorWidget(message: err.toString()),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushNamed(AppRoutes.noteEdit);
          ref.invalidate(notesListProvider);
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: textColor),
        elevation: 4,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, Color primaryColor) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_add,
            size: 80,
            color: primaryColor.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            "No notes yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the + button to create your first note",
            style: TextStyle(
              color: colorScheme.onBackground.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList(List<Note> notes) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: NoteCard(note: note),
        );
      },
    );
  }
}
