import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'package:connek_frontend/system_ui/system_ui.dart';
import '../providers/teams_provider.dart';
import '../models/team_model.dart';
import '../widgets/create_team_dialog.dart';
import '../widgets/add_member_dialog.dart';

class StaffTeamsPage extends StatefulWidget {
  final int businessId;

  const StaffTeamsPage({super.key, required this.businessId});

  @override
  State<StaffTeamsPage> createState() => _StaffTeamsPageState();
}

class _StaffTeamsPageState extends State<StaffTeamsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeamsProvider>().loadTeams(widget.businessId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.groups, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Equipos',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TeamsProvider>(
              builder: (context, provider, child) {
                final theme = Theme.of(context);
                final colorScheme = theme.colorScheme;

                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: AppCard(
                          title: 'Ocurrió un error',
                          description: 'No pudimos cargar los equipos.',
                          footer: Align(
                            alignment: Alignment.centerRight,
                            child: AppButton.outline(
                              text: 'Reintentar',
                              icon: Icons.refresh,
                              onPressed: () =>
                                  provider.loadTeams(widget.businessId),
                            ),
                          ),
                          child: AppText.p(
                            provider.error!,
                            style: theme.textTheme.bodyMedium,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                if (provider.teams.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 520),
                        child: AppCard(
                          title: 'Equipos',
                          description: 'Crea tu primer equipo para empezar.',
                          footer: Align(
                            alignment: Alignment.centerRight,
                            child: AppButton.primary(
                              text: 'Nuevo equipo',
                              icon: Icons.add,
                              onPressed: _showCreateTeamDialog,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.groups_outlined,
                                size: 20,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppText.muted(
                                  'Aún no hay equipos.',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => provider.loadTeams(widget.businessId),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: provider.teams.length,
                    itemBuilder: (context, index) {
                      final team = provider.teams[index];
                      return _TeamCard(
                        team: team,
                        businessId: widget.businessId,
                        onEdit: () => _showEditTeamDialog(team),
                        onDelete: () => _confirmDeleteTeam(team),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateTeamDialog,
        icon: const Icon(Icons.add),
        label: const Text('Nuevo equipo'),
      ),
    );
  }

  void _showCreateTeamDialog() {
    final provider = context.read<TeamsProvider>();
    showShadDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: CreateTeamDialog(businessId: widget.businessId),
      ),
    );
  }

  void _showEditTeamDialog(Team team) {
    final provider = context.read<TeamsProvider>();
    showShadDialog(
      context: context,
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: CreateTeamDialog(businessId: widget.businessId, team: team),
      ),
    );
  }

  void _confirmDeleteTeam(Team team) {
    AppDialog.confirm(
      context,
      title: 'Eliminar equipo',
      description: '¿Seguro que quieres eliminar "${team.name}"?',
      confirmText: 'Eliminar',
      cancelText: 'Cancelar',
      isDestructive: true,
    ).then((confirmed) {
      if (!confirmed) return;
      if (!mounted) return;
      context.read<TeamsProvider>().deleteTeam(team.id);
    });
  }
}

class _TeamCard extends StatelessWidget {
  final Team team;
  final int businessId;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TeamCard({
    required this.team,
    required this.businessId,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: AppCollapsible(
            trigger: Row(
              children: [
                AppAvatar(
                  alt: team.name,
                  size: 36,
                  backgroundColor: colorScheme.primaryContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        team.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (team.description != null &&
                          team.description!.trim().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            team.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ShadButton.ghost(
                  onPressed: onEdit,
                  child: const Icon(Icons.edit_outlined, size: 18),
                ),
                ShadButton.ghost(
                  onPressed: onDelete,
                  child: Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: ShadTheme.of(context).colorScheme.destructive,
                  ),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Miembros',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      AppButton.outline(
                        text: 'Agregar',
                        icon: Icons.person_add,
                        onPressed: () => _showAddMemberDialog(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (team.members.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: AppText.muted(
                        'No hay miembros en este equipo.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: team.members.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 16,
                        color: theme.dividerColor.withAlpha(102),
                      ),
                      itemBuilder: (context, index) {
                        final member = team.members[index];
                        final isLeader = member.role == 'leader';
                        final displayName = member.employee?.name ?? 'Unknown';
                        final email = member.employee?.email ?? '';

                        return Row(
                          children: [
                            AppAvatar(
                              alt: displayName,
                              size: 32,
                              backgroundColor: colorScheme.primaryContainer,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayName,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  if (email.isNotEmpty)
                                    Text(
                                      email,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            isLeader
                                ? const AppBadge('Líder')
                                : AppBadge.secondary('Miembro'),
                            const SizedBox(width: 8),
                            ShadButton.ghost(
                              onPressed: () =>
                                  _confirmRemoveMember(context, member),
                              child: Icon(
                                Icons.remove_circle_outline,
                                size: 18,
                                color: ShadTheme.of(
                                  context,
                                ).colorScheme.destructive,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddMemberDialog(BuildContext context) {
    final provider = context.read<TeamsProvider>();
    showShadDialog(
      context: context,
      builder: (ctx) => ChangeNotifierProvider.value(
        value: provider,
        child: AddMemberDialog(teamId: team.id, businessId: businessId),
      ),
    );
  }

  void _confirmRemoveMember(BuildContext context, TeamMember member) {
    AppDialog.confirm(
      context,
      title: 'Remover miembro',
      description:
          '¿Seguro que quieres remover a "${member.employee?.name ?? 'este miembro'}" del equipo?',
      confirmText: 'Remover',
      cancelText: 'Cancelar',
      isDestructive: true,
    ).then((confirmed) async {
      if (!confirmed) return;
      if (!context.mounted) return;
      final provider = context.read<TeamsProvider>();
      final ok = await provider.removeMember(team.id, member.employeeId);
      if (context.mounted) {
        if (ok) {
          await AppDialog.alert(
            context,
            title: 'Listo',
            description: 'Miembro removido del equipo.',
          );
        } else {
          await AppDialog.alert(
            context,
            title: 'Error',
            description:
                provider.error ??
                'No se pudo remover el miembro. Intenta de nuevo.',
          );
        }
      }
    });
  }
}
