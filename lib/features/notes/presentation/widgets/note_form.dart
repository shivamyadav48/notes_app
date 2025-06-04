import 'package:flutter/material.dart';

class NoteForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final TextEditingController? categoryController;
  final VoidCallback onSave;
  final VoidCallback? onCancel;
  final Color accentColor;

  const NoteForm({
    super.key,
    required this.titleController,
    required this.contentController,
    this.categoryController,
    required this.onSave,
    this.onCancel,
    this.accentColor = const Color(0xFFFFDE21),
  });

  InputDecoration _inputDecoration({
    required BuildContext context,
    required String hintText,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final fillColor = theme.colorScheme.surface;

    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: theme.hintColor),
      prefixIcon: Icon(icon, color: accentColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      filled: true,
      fillColor: fillColor,
    );
  }

  BoxDecoration _boxDecoration(BuildContext context) {
    final theme = Theme.of(context);
    return BoxDecoration(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: theme.shadowColor.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title input
          Container(
            decoration: _boxDecoration(context),
            child: TextField(
              controller: titleController,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              decoration: _inputDecoration(
                context: context,
                hintText: 'Note Title',
                icon: Icons.title,
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),

          const SizedBox(height: 16),

          if (categoryController != null)
            Container(
              decoration: _boxDecoration(context),
              child: TextField(
                controller: categoryController,
                decoration: _inputDecoration(
                  context: context,
                  hintText: 'Category',
                  icon: Icons.category,
                ),
              ),
            ),

          if (categoryController != null) const SizedBox(height: 16),

          // Content input area
          Expanded(
            child: Container(
              decoration: _boxDecoration(context),
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(color: theme.hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Action buttons
          Row(
            children: [
              if (onCancel != null)
                Expanded(
                  child: TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: theme.colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: accentColor, width: 1),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              if (onCancel != null) const SizedBox(width: 16),
              Expanded(
                flex: onCancel != null ? 2 : 1,
                child: ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.save),
                      const SizedBox(width: 8),
                      const Text(
                        'Save Note',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
