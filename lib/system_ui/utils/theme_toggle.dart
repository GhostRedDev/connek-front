import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: ThemeToggleGroup
/// Props: currentMode, onThemeChanged
class ThemeToggleGroup extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const ThemeToggleGroup({
    super.key,
    required this.currentMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ThemeOption(
            icon: Icons.wb_sunny,
            label: 'Light',
            isSelected: currentMode == ThemeMode.light,
            onTap: () => onThemeChanged(ThemeMode.light),
          ),
          _ThemeOption(
            icon: Icons.nightlight_round,
            label: 'Dark',
            isSelected: currentMode == ThemeMode.dark,
            onTap: () => onThemeChanged(ThemeMode.dark),
          ),
          _ThemeOption(
            icon: Icons.settings_system_daydream,
            label: 'System',
            isSelected: currentMode == ThemeMode.system,
            onTap: () => onThemeChanged(ThemeMode.system),
          ),
        ],
      ),
    );
  }
}

/// Internal sub-component for ThemeToggleGroup
class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? ShadTheme.of(context).cardTheme.backgroundColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: ShadTheme.of(context).colorScheme.border,
                  width: 1,
                )
              : Border.all(color: Colors.transparent),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? ShadTheme.of(context).colorScheme.foreground
                  : ShadTheme.of(context).colorScheme.mutedForeground,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: ShadTheme.of(context).textTheme.small.copyWith(
                fontSize: 12,
                color: isSelected
                    ? ShadTheme.of(context).colorScheme.foreground
                    : ShadTheme.of(context).colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
