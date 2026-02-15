import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/office_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'providers/greg_provider.dart';
import '../settings/providers/profile_provider.dart';
import 'widgets/office_menu_widget.dart';
import 'widgets/office_my_bots_widget.dart';
import 'widgets/office_marketplace_widget.dart';
import 'widgets/office_resources_widget.dart';
import 'staff/staff_management_page.dart';
import '../../system_ui/core/constants.dart';

class OfficePage extends ConsumerStatefulWidget {
  const OfficePage({super.key});

  @override
  ConsumerState<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends ConsumerState<OfficePage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final userProfile = await ref.read(profileProvider.future);
      if (userProfile == null) return;

      final client = Supabase.instance.client;
      final businessData = await client
          .from('business')
          .select('id')
          .eq('owner_client_id', userProfile.id)
          .maybeSingle();

      if (businessData != null) {
        final bId = businessData['id'] as int;
        if (mounted) {
          // Use try/catch to avoid errors if provider is disposed
          try {
            await ref.read(gregProvider.notifier).loadGreg(bId);
          } catch (e) {
            debugPrint('Error loading Greg: $e');
          }
        }
      }
    } catch (e) {
      debugPrint('Error in OfficePage _loadData: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final selectedIndex = ref.watch(officeSelectedIndexProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppBreakpoints.ultraWide,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 115,
                  ), // Increased to clear the taller Glass Header (125px)
                  // TOP MENU
                  OfficeMenuWidget(
                    selectedIndex: selectedIndex,
                    onTabSelected: (index) {
                      ref
                          .read(officeSelectedIndexProvider.notifier)
                          .updateIndex(index);
                    },
                  ),

                  // CONTENT AREA
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeOutQuad,
                      switchOutCurve: Curves.easeInQuad,
                      transitionBuilder: (child, animation) {
                        final offsetAnimation = Tween<Offset>(
                          begin: const Offset(0.03, 0.0),
                          end: Offset.zero,
                        ).animate(animation);
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          ),
                        );
                      },
                      child: _buildOfficeView(selectedIndex),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaffManagement() {
    // Get business and employee IDs from providers
    return FutureBuilder(
      future: _getBusinessAndEmployeeIds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Text('Error al cargar Staff Management: ${snapshot.error}'),
          );
        }

        final data = snapshot.data as Map<String, int>;
        return StaffManagementPage(
          businessId: data['businessId']!,
          employeeId: data['employeeId']!,
        );
      },
    );
  }

  Future<Map<String, int>> _getBusinessAndEmployeeIds() async {
    final userProfile = await ref.read(profileProvider.future);
    if (userProfile == null) {
      throw Exception('No user profile found');
    }

    final client = Supabase.instance.client;
    final businessData = await client
        .from('business')
        .select('id')
        .eq('owner_client_id', userProfile.id)
        .maybeSingle();

    if (businessData == null) {
      throw Exception('No business found');
    }

    // Get employee ID for this business (first employee or create one)
    // Since employees table doesn't have client_id, we'll use the first employee
    // or you can create a specific employee for the owner
    final employeeData = await client
        .from('employees')
        .select('id')
        .eq('business_id', businessData['id'])
        .limit(1)
        .maybeSingle();

    if (employeeData == null) {
      print('🔧 DEBUG: Creating default employee for owner...');

      // Create a default employee for the owner if none exists
      try {
        final newEmployee = await client
            .from('employees')
            .insert({
              'business_id': businessData['id'],
              'name': '${userProfile.firstName} ${userProfile.lastName}',
              'role': 'Owner',
              'type': 'human',
              'status': 'Activo',
              'purpose': 'Staff Management',
              'description': 'Business owner and administrator',
              'skills': '', // Required NOT NULL field
              'price': 0, // Required NOT NULL field
              'currency': 'USD', // Required NOT NULL field
              'frequency': 'monthly', // Required NOT NULL field
            })
            .select('id')
            .single();

        print('✅ DEBUG: Employee created successfully: ${newEmployee['id']}');

        return {
          'businessId': businessData['id'] as int,
          'employeeId': newEmployee['id'] as int,
        };
      } catch (employeeError) {
        print('❌ DEBUG: Error creating employee: $employeeError');
        rethrow;
      }
    }

    return {
      'businessId': businessData['id'] as int,
      'employeeId': employeeData['id'] as int,
    };
  }

  // Helper to build current Office tab view for AnimatedSwitcher
  Widget _buildOfficeView(int index) {
    switch (index) {
      case 0:
        return const OfficeMyBotsWidget(key: ValueKey('office-0'));
      case 1:
        return const OfficeMarketplaceWidget(key: ValueKey('office-1'));
      case 2:
        return KeyedSubtree(
          key: const ValueKey('office-2'),
          child: _buildStaffManagement(),
        );
      case 3:
        return OfficeResourcesWidget(key: const ValueKey('office-3'));
      default:
        return const SizedBox.shrink(key: ValueKey('office-default'));
    }
  }
}
