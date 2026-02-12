import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/teams_provider.dart';
import 'providers/tasks_provider.dart';
import 'providers/skills_provider.dart';
import 'providers/time_tracking_provider.dart';
import 'providers/activity_feed_provider.dart';
import 'providers/evaluations_provider.dart';
import 'pages/staff_employees_page.dart';
import 'pages/staff_teams_page.dart';
import 'pages/staff_tasks_page.dart';
import 'pages/staff_activity_feed_page.dart';
import 'widgets/time_tracker_widget.dart';

class StaffManagementPage extends StatefulWidget {
  final int businessId;
  final int employeeId;

  const StaffManagementPage({
    super.key,
    required this.businessId,
    required this.employeeId,
  });

  @override
  State<StaffManagementPage> createState() => _StaffManagementPageState();
}

class _StaffManagementPageState extends State<StaffManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeamsProvider()),
        ChangeNotifierProvider(create: (_) => TasksProvider()),
        ChangeNotifierProvider(create: (_) => SkillsProvider()),
        ChangeNotifierProvider(create: (_) => TimeTrackingProvider()),
        ChangeNotifierProvider(create: (_) => ActivityFeedProvider()),
        ChangeNotifierProvider(create: (_) => EvaluationsProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Staff Management'),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(icon: Icon(Icons.people), text: 'Employees'),
              Tab(icon: Icon(Icons.groups), text: 'Teams'),
              Tab(icon: Icon(Icons.task_alt), text: 'Tasks'),
              Tab(icon: Icon(Icons.feed), text: 'Activity'),
            ],
          ),
          actions: [
            // Time Tracker in AppBar
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SizedBox(
                height: 48,
                child: TimeTrackerWidget(
                  employeeId: widget.employeeId,
                  businessId: widget.businessId,
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            StaffEmployeesPage(businessId: widget.businessId),
            StaffTeamsPage(businessId: widget.businessId),
            StaffTasksPage(businessId: widget.businessId),
            StaffActivityFeedPage(businessId: widget.businessId),
          ],
        ),
      ),
    );
  }
}
