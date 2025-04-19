import 'package:flutter/material.dart';

class EmptyNotesWidget extends StatelessWidget {
  final VoidCallback? onCreateNote;
  final Color? accentColor;

  const EmptyNotesWidget({
    super.key,
    this.onCreateNote,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final primaryColor = accentColor ?? colorScheme.primary;
    final onPrimary = colorScheme.onPrimary;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated note icon
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.8, end: 1.0),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.note_add_sharp,
                size: 80,
                color: primaryColor,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Title text
          Text(
            'No Notes Yet',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onBackground,
            ),
          ),

          const SizedBox(height: 12),

          // Description text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Create your first note to get started. Capture thoughts, ideas, or anything you want to remember.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Create note button
          if (onCreateNote != null)
            ElevatedButton.icon(
              onPressed: onCreateNote,
              icon: const Icon(Icons.add),
              label: const Text('Create Note'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: onPrimary,
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
