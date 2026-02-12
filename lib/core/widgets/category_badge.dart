import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/business_categories.dart';

class CategoryBadge extends StatelessWidget {
  final String? categoryId;
  final bool showGroup;

  const CategoryBadge({
    super.key,
    required this.categoryId,
    this.showGroup = true,
  });

  @override
  Widget build(BuildContext context) {
    if (categoryId == null || categoryId!.isEmpty) {
      return const SizedBox.shrink();
    }

    final category = BusinessCategories.findById(categoryId!);
    if (category == null) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF4F87C9).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4F87C9).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Text(category.icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),

          // Category Name
          Text(
            category.name,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4F87C9),
            ),
          ),

          // Group Tag (Optional)
          if (showGroup) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                category.group,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Widget for "Cliente" badge
class ClientBadge extends StatelessWidget {
  const ClientBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('👤', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            'Cliente',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
