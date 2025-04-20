import 'package:drive_notes/features/notes/domain/entities/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/notes_providers.dart';

class NoteEditScreen extends ConsumerStatefulWidget {
  final String? noteId;
  final String? initialTitle;
  final String? initialContent;
  final Note? note;

  const NoteEditScreen({
    super.key,
    this.noteId,
    this.initialTitle,
    this.initialContent,
    this.note,
  });

  @override
  ConsumerState<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends ConsumerState<NoteEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  bool _isEdited = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final initialTitle = widget.note?.title ?? widget.initialTitle ?? '';
    final initialContent = widget.note?.content ?? widget.initialContent ?? '';

    _titleController = TextEditingController(text: initialTitle);
    _contentController = TextEditingController(text: initialContent);

    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (!_isEdited) {
      setState(() => _isEdited = true);
    }
  }

  Future<void> _saveNote() async {
    if (_titleController.text.trim().isEmpty) {
      _showEmptyFieldError('Title cannot be empty');
      return;
    }

    setState(() => _isSaving = true);

    try {
      final noteId = widget.noteId ?? widget.note?.id;
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();

      if (noteId != null) {
        await ref.read(updateNoteUseCaseProvider)(noteId, title, content);
      } else {
        await ref.read(createNoteUseCaseProvider)(title, content);
      }

      ref.invalidate(notesListProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Note saved successfully'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save note: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showEmptyFieldError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (!_isEdited) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text(
            'You have unsaved changes. Are you sure you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel',
            style: TextStyle(
              color: Colors.green,
            ),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.noteId != null || widget.note != null;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEditMode ? 'Edit Note' : 'New Note',
            style: textTheme.titleLarge,
          ),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          actions: [
            _isSaving
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: colorScheme.onPrimary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: _saveNote,
                    icon: const Icon(Icons.save_rounded),
                    tooltip: 'Save Note',
                    color: colorScheme.onPrimary,
                  ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: colorScheme.onPrimary),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.clear_all, size: 20),
                      SizedBox(width: 8),
                      Text('Clear All'),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'clear') {
                  setState(() {
                    _titleController.clear();
                    _contentController.clear();
                    _isEdited = true;
                  });
                }
              },
            ),
          ],
        ),
        body: Container(
          color: colorScheme.surface.withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: theme.hintColor),
                      ),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.only(bottom: 42),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          hintText: 'Write your note...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: theme.hintColor),
                        ),
                        style: textTheme.bodyMedium,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _saveNote,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          child: const Icon(Icons.check),
          tooltip: 'Save Note',
        ),
      ),
    );
  }
}
