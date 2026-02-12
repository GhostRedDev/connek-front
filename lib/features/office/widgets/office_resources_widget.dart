import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/features/business/presentation/views/services/business_resource_sheet.dart';
import 'package:connek_frontend/features/office/widgets/resource_assignment_dialog.dart';

// Resources Sub-Tab
final resourcesTabProvider = StateProvider<String>((ref) => 'all');

class OfficeResourcesWidget extends ConsumerWidget {
  const OfficeResourcesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(resourcesTabProvider);
    final businessAsync = ref.watch(businessProvider);
    final businessId = businessAsync.value?.businessProfile?['id'] as int?;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AppTabs<String>(
        value: selectedTab,
        onValueChange: (value) {
          ref.read(resourcesTabProvider.notifier).state = value;
        },
        tabs: [
          AppTabItem(
            value: 'all',
            label: 'Recursos',
            content: _buildResourcesTab(
              context,
              ref,
              businessId: businessId,
              tab: _ResourcesTab.all,
            ),
          ),
          AppTabItem(
            value: 'sites',
            label: 'Sitios',
            content: _buildResourcesTab(
              context,
              ref,
              businessId: businessId,
              tab: _ResourcesTab.sites,
            ),
          ),
          AppTabItem(
            value: 'offices',
            label: 'Oficinas',
            content: _buildResourcesTab(
              context,
              ref,
              businessId: businessId,
              tab: _ResourcesTab.offices,
            ),
          ),
          AppTabItem(
            value: 'materials',
            label: 'Materiales',
            content: _buildResourcesTab(
              context,
              ref,
              businessId: businessId,
              tab: _ResourcesTab.materials,
            ),
          ),
          AppTabItem(
            value: 'vehicles',
            label: 'Vehículos',
            content: _buildResourcesTab(
              context,
              ref,
              businessId: businessId,
              tab: _ResourcesTab.vehicles,
            ),
          ),
          AppTabItem(
            value: 'equipment',
            label: 'Equipos',
            content: _buildResourcesTab(
              context,
              ref,
              businessId: businessId,
              tab: _ResourcesTab.equipment,
            ),
          ),
          AppTabItem(
            value: 'other',
            label: 'Otros',
            content: _buildResourcesTab(
              context,
              ref,
              businessId: businessId,
              tab: _ResourcesTab.other,
            ),
          ),
          AppTabItem(
            value: 'docs',
            label: 'Documentos',
            content: _buildPlaceholder(
              context,
              title: 'Documentos',
              icon: Icons.description_outlined,
              description:
                  'Documentos y archivos operativos que luego podrás asignar a equipos y recursos.',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab(
    BuildContext context,
    WidgetRef ref, {
    required int? businessId,
    required _ResourcesTab tab,
  }) {
    if (businessId == null || businessId == 0) {
      return _buildPlaceholder(
        context,
        title: 'Recursos',
        icon: Icons.inventory_2_outlined,
        description: 'Cargando negocio...',
      );
    }

    final repo = ref.read(businessRepositoryProvider);
    final future = repo.getResources(businessId);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final allResources = snapshot.data ?? const <Map<String, dynamic>>[];
        final resources = _filterResourcesForTab(allResources, tab);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              title: _tabTitle(tab),
              description: 'Asignación, estado, auditoría y condiciones.',
              padding: const EdgeInsets.all(16),
              footer: Row(
                children: [
                  AppButton.primary(
                    text: 'Añadir recurso',
                    icon: Icons.add,
                    onPressed: () => _openCreateResourceSheet(context),
                  ),
                  const SizedBox(width: 12),
                  AppBadge.secondary('Asignable a equipos'),
                  const SizedBox(width: 8),
                  AppBadge.outline('Auditoría'),
                ],
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AppBadge.secondary('Estados'),
                  AppBadge.secondary('Condiciones de uso'),
                  AppBadge.secondary('Check-in / Check-out'),
                  AppBadge.secondary('Reportes de uso'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (resources.isEmpty)
              Expanded(
                child: _buildPlaceholder(
                  context,
                  title: _tabTitle(tab),
                  icon: _tabIcon(tab),
                  description:
                      'No hay recursos en esta categoría todavía. Crea uno y luego podrás asignarlo a equipos y registrar su uso.',
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: resources.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final r = resources[index];
                    return _ResourceRow(
                      resource: r,
                      onEdit: () =>
                          _openEditResourceSheet(context, resource: r),
                      onAssign: () => _openAssignmentDialog(
                        context,
                        ref,
                        businessId: businessId,
                        resource: r,
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  void _openAssignmentDialog(
    BuildContext context,
    WidgetRef ref, {
    required int businessId,
    required Map<String, dynamic> resource,
  }) {
    final repo = ref.read(businessRepositoryProvider);
    showShadDialog(
      context: context,
      builder: (context) => ResourceAssignmentDialog(
        businessId: businessId,
        resource: resource,
        repo: repo,
      ),
    );
  }

  void _openCreateResourceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const BusinessResourceSheet(),
    );
  }

  void _openEditResourceSheet(
    BuildContext context, {
    required Map<String, dynamic> resource,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BusinessResourceSheet(resourceToEdit: resource),
    );
  }

  List<Map<String, dynamic>> _filterResourcesForTab(
    List<Map<String, dynamic>> all,
    _ResourcesTab tab,
  ) {
    bool matchesKeywords(String? type, List<String> keywords) {
      final value = (type ?? '').toLowerCase();
      return keywords.any((k) => value.contains(k));
    }

    switch (tab) {
      case _ResourcesTab.all:
        return all;
      case _ResourcesTab.vehicles:
        return all
            .where((r) => (r['resource_type'] ?? '').toString() == 'Vehículo')
            .toList();
      case _ResourcesTab.equipment:
        return all
            .where((r) => (r['resource_type'] ?? '').toString() == 'Equipo')
            .toList();
      case _ResourcesTab.offices:
        return all
            .where(
              (r) =>
                  (r['resource_type'] ?? '').toString() == 'Sala' ||
                  (r['resource_type'] ?? '').toString() == 'Puesto',
            )
            .toList();
      case _ResourcesTab.sites:
        return all
            .where(
              (r) => matchesKeywords((r['resource_type'] ?? '').toString(), [
                'sitio',
                'obra',
                'work',
                'site',
              ]),
            )
            .toList();
      case _ResourcesTab.materials:
        return all
            .where(
              (r) => matchesKeywords((r['resource_type'] ?? '').toString(), [
                'material',
                'materials',
                'insumo',
                'inventario',
              ]),
            )
            .toList();
      case _ResourcesTab.other:
        return all
            .where(
              (r) =>
                  (r['resource_type'] ?? '').toString() != 'Vehículo' &&
                  (r['resource_type'] ?? '').toString() != 'Equipo' &&
                  (r['resource_type'] ?? '').toString() != 'Sala' &&
                  (r['resource_type'] ?? '').toString() != 'Puesto',
            )
            .toList();
    }
  }

  String _tabTitle(_ResourcesTab tab) {
    switch (tab) {
      case _ResourcesTab.all:
        return 'Recursos';
      case _ResourcesTab.sites:
        return 'Sitios de trabajo';
      case _ResourcesTab.offices:
        return 'Oficinas';
      case _ResourcesTab.materials:
        return 'Materiales';
      case _ResourcesTab.vehicles:
        return 'Vehículos';
      case _ResourcesTab.equipment:
        return 'Equipos';
      case _ResourcesTab.other:
        return 'Otros';
    }
  }

  IconData _tabIcon(_ResourcesTab tab) {
    switch (tab) {
      case _ResourcesTab.all:
        return Icons.inventory_2_outlined;
      case _ResourcesTab.sites:
        return Icons.location_on_outlined;
      case _ResourcesTab.offices:
        return Icons.apartment_outlined;
      case _ResourcesTab.materials:
        return Icons.inventory_2_outlined;
      case _ResourcesTab.vehicles:
        return Icons.directions_car_outlined;
      case _ResourcesTab.equipment:
        return Icons.build_outlined;
      case _ResourcesTab.other:
        return Icons.category_outlined;
    }
  }

  Widget _buildPlaceholder(
    BuildContext context, {
    required String title,
    required IconData icon,
    String? description,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: AppCard(
          title: 'Gestión de $title',
          description: 'Próximamente',
          child: Row(
            children: [
              Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  description ??
                      'Aquí podrás administrar $title y asignarlo a equipos cuando aplique.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _ResourcesTab {
  all,
  sites,
  offices,
  materials,
  vehicles,
  equipment,
  other,
}

class _ResourceRow extends StatelessWidget {
  final Map<String, dynamic> resource;
  final VoidCallback onEdit;
  final VoidCallback onAssign;

  const _ResourceRow({
    required this.resource,
    required this.onEdit,
    required this.onAssign,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final name = (resource['name'] ?? 'Recurso').toString();
    final type = (resource['resource_type'] ?? 'Otro').toString();
    final isActive = (resource['active'] ?? true) == true;

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          AppAvatar(alt: name, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    AppBadge.secondary(type),
                    isActive
                        ? AppBadge.outline('Activo')
                        : AppBadge.destructive('Inactivo'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          AppButton.outline(
            text: 'Asignar',
            icon: Icons.assignment_ind_outlined,
            onPressed: onAssign,
          ),
          const SizedBox(width: 8),
          AppButton.outline(
            text: 'Editar',
            icon: Icons.edit,
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
