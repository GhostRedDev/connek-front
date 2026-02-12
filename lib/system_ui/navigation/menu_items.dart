import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: MenuLinkItem
/// Props: label, icon, onTap
class MenuLinkItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const MenuLinkItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Text(
              label,
              style: ShadTheme.of(
                context,
              ).textTheme.p.copyWith(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            // Small Icon Button style (Icono encapsulado)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ShadTheme.of(context).colorScheme.muted.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: ShadTheme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
