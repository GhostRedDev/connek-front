import 'package:flutter/material.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:connek_frontend/features/office/widgets/greg_card.dart';

class BusinessEmployeesSection extends StatelessWidget {
  final List<dynamic> employees;
  final Map<String, dynamic> t;

  const BusinessEmployeesSection({
    super.key,
    required this.employees,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    // GregCard uses its own internal state/style, we just wrap it for layout consistency
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.h4(t['employees'] ?? 'Empleados'),
          const SizedBox(height: 20),
          if (employees.isEmpty)
            _NoEmployeesCard(t: t)
          else
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: employees
                  .map((e) {
                    final rawActive = e['active'] ?? e['is_active'];
                    final isActive =
                        rawActive == true ||
                        rawActive == 1 ||
                        rawActive.toString().toLowerCase() == 'true';
                    return GregCard(isActive: isActive);
                  })
                  .toList()
                  .cast<Widget>(),
            ),
        ],
      ),
    );
  }
}

class _NoEmployeesCard extends StatelessWidget {
  final Map<String, dynamic> t;
  const _NoEmployeesCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.badge_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 10),
            AppText.p(
              t['no_employees'] ?? 'No hay empleados registrados',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
