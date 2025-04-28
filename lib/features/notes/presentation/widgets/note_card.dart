import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/note.dart';
import '../providers/notes_providers.dart';
import '../screens/note_detail_screen.dart';

class NoteCard extends ConsumerWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final accent = const Color(0xFFFFDE21);
    final borderColor = colorScheme.primary.withOpacity(0.8);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: borderColor,
            width: 1.8,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteDetailScreen(note: note),
                ),
              );
            },
            onLongPress: () async {
              final shouldDelete = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Note'),
                  content: const Text('Are you sure you want to delete this note ?'),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );

              if (shouldDelete == true) {
                await ref.read(deleteNoteUseCaseProvider)(note.id);
                ref.invalidate(notesListProvider);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Row(
                children: [
                  Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      note.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
