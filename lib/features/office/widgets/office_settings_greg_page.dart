import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/greg_provider.dart';
import '../providers/office_provider.dart';
import '../../../core/models/greg_model.dart';
import 'package:intl/intl.dart';
import '../../settings/providers/profile_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'office_menu_widget.dart';

class OfficeSettingsGregPage extends ConsumerStatefulWidget {
  const OfficeSettingsGregPage({super.key});

  @override
  ConsumerState<OfficeSettingsGregPage> createState() =>
      _OfficeSettingsGregPageState();
}

class _OfficeSettingsGregPageState extends ConsumerState<OfficeSettingsGregPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _blacklistController;
  bool _isLoading = true;
  bool _isSwitchLoading = false;
  bool _isSubscriptionLoading = false;

  // Local state for settings
  bool _isActive = true;
  String _conversationTone = 'friendly';
  List<String> _blacklist = [];
  bool _notifications = true;
  bool _isSubscriptionActive = false;
  bool _cancelAtPeriodEnd = false; // New state
  String? _nextBillingDate; // Store locally for display
  int? _businessId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _blacklistController = TextEditingController();

    _tabController.addListener(() {
      if (mounted) setState(() {});
    });

    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;

    try {
      final userProfile = await ref.read(profileProvider.future);
      if (userProfile == null) {
        debugPrint('⚠️ Settings Page: User profile is null');
        return;
      }
      debugPrint('👤 Settings Page: User Profile ID: ${userProfile.id}');

      final client = Supabase.instance.client;
      final businessData = await client
          .from('business')
          .select('*')
          .eq('owner_client_id', userProfile.id)
          .maybeSingle();

      debugPrint(
        '🏢 Settings Page: Business Data from Supabase: $businessData',
      );

      if (businessData != null) {
        final bId = businessData['id'] as int;
        _businessId = bId; // Store locally
        debugPrint('📡 Settings Page: Loading Greg for businessId: $bId');
        await ref.read(gregProvider.notifier).loadGreg(bId);

        final state = ref.read(gregProvider);
        if (state is GregLoaded) {
          debugPrint('✅ Settings Page: Greg loaded successfully');
          debugPrint('📦 Greg Data: ${state.greg.toJson()}');
          _populateFields(state.greg);
        } else if (state is GregError) {
          debugPrint('❌ Settings Page: Greg state is Error: ${state.message}');
        }
      } else {
        debugPrint(
          '⚠️ Settings Page: No business found for user ${userProfile.id}',
        );
      }
    } catch (e) {
      debugPrint('❌ Settings Page: Error loading data: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _populateFields(GregModel greg) {
    setState(() {
      _isActive = greg.active;
      _conversationTone = greg.conversationTone;
      _blacklist = List<String>.from(greg.blacklist);
      _notifications = greg.notifications;
      _notifications = greg.notifications;
      _isSubscriptionActive = greg.subscriptionActive;
      _cancelAtPeriodEnd = greg.cancelAtPeriodEnd;
      _nextBillingDate = greg.nextBillingDate;
    });
    debugPrint(
      '📝 Fields populated: SubActive=$_isSubscriptionActive, Tone=$_conversationTone',
    );
  }

  Future<void> _saveData() async {
    debugPrint('💾 OfficeSettingsGregPage: Starting _saveData...');
    final currentState = ref.read(gregProvider);
    if (currentState is! GregLoaded) {
      debugPrint(
        '⚠️ OfficeSettingsGregPage: Current state is not GregLoaded. Actual state: ${currentState.runtimeType}',
      );
      return;
    }

    final businessId = currentState.greg.businessId;
    final updatedGreg = currentState.greg.copyWith(
      active: _isActive,
      conversationTone: _conversationTone,
      blacklist: _blacklist,
      notifications: _notifications,
    );

    debugPrint('📦 OfficeSettingsGregPage: Saving for businessId: $businessId');
    debugPrint('📦 Original Data: ${currentState.greg.toJson()}');
    debugPrint('📦 Updated Data to send: ${updatedGreg.toJson()}');

    setState(() => _isLoading = true);
    try {
      debugPrint(
        '🚀 OfficeSettingsGregPage: Calling gregProvider.notifier.updateGreg...',
      );
      await ref.read(gregProvider.notifier).updateGreg(updatedGreg);
      debugPrint('✅ OfficeSettingsGregPage: updateGreg successful');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Configuración guardada correctamente')),
        );
      }
    } catch (e) {
      debugPrint('❌ OfficeSettingsGregPage: updateGreg failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
      debugPrint('🏁 OfficeSettingsGregPage: _saveData finished');
    }
  }

  Future<void> _toggleActivation(bool value) async {
    final currentState = ref.read(gregProvider);
    if (currentState is! GregLoaded) return;

    final businessId = currentState.greg.businessId;

    setState(() {
      _isActive = value;
      _isSwitchLoading = true;
    });

    try {
      await ref.read(gregProvider.notifier).toggleActivation(businessId, value);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              value
                  ? 'Greg activado correctamente'
                  : 'Greg ahora está en reposo',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isActive = !value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cambiar estado: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSwitchLoading = false);
    }
  }

  Future<void> _toggleNotifications(bool value) async {
    final currentState = ref.read(gregProvider);
    if (currentState is! GregLoaded) return;

    setState(() {
      _notifications = value;
      _isSwitchLoading = true;
    });

    try {
      final updatedGreg = currentState.greg.copyWith(notifications: value);
      await ref.read(gregProvider.notifier).updateGreg(updatedGreg);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              value
                  ? 'Notificaciones activadas'
                  : 'Notificaciones desactivadas',
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _notifications = !value);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSwitchLoading = false);
    }
  }

  Future<void> _activateSubscription() async {
    int? businessId;

    final currentState = ref.read(gregProvider);
    if (currentState is GregLoaded) {
      businessId = currentState.greg.businessId;
    } else {
      businessId = _businessId; // Fallback to locally stored ID
    }

    if (businessId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: No se pudo identificar el negocio.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    debugPrint('🔘 UI: Activate Subscription Clicked. BusinessID: $businessId');
    setState(() => _isSubscriptionLoading = true);

    try {
      final redirectUrl = await ref
          .read(gregServiceProvider)
          .activateSubscription(businessId: businessId);

      debugPrint('🔗 UI: Received Redirect URL: $redirectUrl');

      if (redirectUrl != null && redirectUrl.isNotEmpty) {
        final uri = Uri.parse(redirectUrl);
        debugPrint('🚀 UI: Attempting to launch URL: $uri');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
          debugPrint('✅ UI: URL Launched');
        } else {
          debugPrint('❌ UI: Cannot launch URL');
          throw 'No se pudo abrir la URL: $redirectUrl';
        }
      } else {
        throw 'No se recibió URL de redirección';
      }
    } catch (e) {
      debugPrint('❌ UI: Error activating: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al iniciar suscripción: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubscriptionLoading = false);
    }
  }

  Future<void> _confirmCancelSubscription(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E2429),
          title: Text(
            '¿Estás seguro de suspender esta suscripción?',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Tu suscripción permanecerá activa hasta el final del periodo de facturación actual. No se te volverá a cobrar.',
            style: GoogleFonts.inter(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close modal
              child: Text('No', style: GoogleFonts.inter(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close modal first
                _handleCancelSubscription(); // Proceed
              },
              child: Text(
                'Sí, suspender',
                style: GoogleFonts.inter(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleCancelSubscription() async {
    int? businessId;
    final currentState = ref.read(gregProvider);
    if (currentState is GregLoaded) {
      businessId = currentState.greg.businessId;
    } else {
      businessId = _businessId;
    }

    if (businessId == null) return;

    setState(() => _isSubscriptionLoading = true);

    try {
      final success = await ref
          .read(gregServiceProvider)
          .cancelSubscription(businessId: businessId);

      if (success) {
        // Refresh data to reflect status
        await ref.read(gregProvider.notifier).loadGreg(businessId);

        // Update local state with new data
        final newState = ref.read(gregProvider);
        if (newState is GregLoaded) {
          _populateFields(newState.greg);
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Suscripción suspendida correctamente'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw 'La API devolvió éxito falso';
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al suspender: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubscriptionLoading = false);
    }
  }

  void _showVideoPlayer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          const _VideoPlayerDialog(assetPath: 'assets/videos/greg-bot.mp4'),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _blacklistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 130), // Clear Glass Header
              OfficeMenuWidget(
                selectedIndex: 0,
                onTabSelected: (index) {
                  if (index == 1) {
                    ref
                        .read(officeSelectedIndexProvider.notifier)
                        .updateIndex(1);
                    context.pop();
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildTabBar(),
              ),
              const SizedBox(height: 10),
              _buildTabContent(),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Mis bots',
                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Greg',
            style: GoogleFonts.outfit(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/Greg_Top_Bot_CArd.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      width: double.infinity,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Theme.of(
          context,
        ).colorScheme.primary, // Or specific active color
        unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
        tabs: [
          _buildTabItem(Icons.face_outlined, 'Identidad'),
          _buildTabItem(Icons.chat_bubble_outline, 'Conversación'),
          _buildTabItem(Icons.sync_outlined, 'Integraciones'),
          _buildTabItem(Icons.notifications_none_outlined, 'Notificaciones'),
          _buildTabItem(Icons.credit_card_outlined, 'Suscripción'),
        ],
      ),
    );
  }

  Widget _buildTabItem(IconData icon, String label) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Column(
        key: ValueKey(_tabController.index),
        children: [
          if (_tabController.index == 0) _buildIdentityTab(),
          if (_tabController.index == 1) _buildConversationTab(),
          if (_tabController.index == 2) _buildIntegrationsTab(),
          if (_tabController.index == 3) _buildNotificationsTab(),
          if (_tabController.index == 4) _buildSubscriptionManagementTab(),
        ],
      ),
    );
  }

  Widget _buildIdentityTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E2429),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Card Preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/Greg_BG.png'),
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/Greg_Card_M.png'),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Text(
                                  '💰 Finanzas',
                                  style: TextStyle(
                                    color: Color(0xFF131619),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: GestureDetector(
                                onTap: () => _showVideoPlayer(context),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(
                                    Icons.play_circle_outline,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Greg',
                    style: GoogleFonts.outfit(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Te ayuda a responder consultas sobre obras, materiales y servicios de construcción.',
                  style: GoogleFonts.inter(
                    color:
                        Theme.of(context).textTheme.bodySmall?.color ??
                        Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(color: Theme.of(context).dividerColor),
                ),
                // Status Toggle Card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estado',
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Inactivo',
                              style: GoogleFonts.inter(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 5),
                            if (_isSwitchLoading)
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xFF249689),
                                ),
                              )
                            else
                              Switch(
                                value: _isActive,
                                onChanged: _toggleActivation,
                                activeThumbColor: const Color(0xFF249689),
                                activeTrackColor: const Color(
                                  0xFF249689,
                                ).withOpacity(0.3),
                              ),
                            const SizedBox(width: 5),
                            Text(
                              'Activo',
                              style: GoogleFonts.inter(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          // Subscription & Training Logic
          Consumer(
            builder: (context, ref, child) {
              final gregState = ref.watch(gregProvider);
              // Strict check: Only true if backend says so
              final isSubscribed =
                  gregState is GregLoaded && gregState.greg.subscriptionActive;
              final greg = gregState is GregLoaded
                  ? gregState.greg
                  : GregModel(id: 0); // Fallback

              return Column(
                children: [
                  // Subscription Info Card (Only if Subscribed)
                  if (isSubscribed)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2429),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF249689).withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFF249689),
                                size: 24,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Información de Suscripción',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildSubInfoRow(
                            'Plan',
                            greg.subscriptionPlan != null &&
                                    greg.subscriptionPlan!.isNotEmpty
                                ? greg.subscriptionPlan!
                                : 'Greg Asistente (Mensual)',
                          ),
                          const SizedBox(height: 12),
                          _buildSubInfoRow(
                            'Costo',
                            '${greg.subscriptionPrice == 0 ? "15.00" : greg.subscriptionPrice.toStringAsFixed(2)} ${greg.subscriptionCurrency} / mes',
                          ),
                          const SizedBox(height: 12),
                          _buildSubInfoRow(
                            'Activo',
                            'Estado',
                            valueColor: const Color(0xFF249689),
                            icon: Icons.check_circle,
                          ),
                          const SizedBox(height: 12),
                          Builder(
                            builder: (context) {
                              String formattedDate = 'Próximamente';
                              if (greg.nextBillingDate != null) {
                                try {
                                  final date = DateTime.parse(
                                    greg.nextBillingDate!,
                                  );
                                  formattedDate = DateFormat(
                                    'dd MMM yyyy',
                                    'es',
                                  ).format(date);
                                } catch (e) {
                                  formattedDate = greg.nextBillingDate!;
                                }
                              }
                              return _buildSubInfoRow(
                                'Próxima Facturación',
                                formattedDate,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isSubscribed) {
                          context.push('/office/train-greg');
                        } else {
                          // Only allow activation if NOT subscribed
                          if (!_isSubscriptionLoading) {
                            _activateSubscription();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B39EF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: _isSubscriptionLoading && !isSubscribed
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              isSubscribed
                                  ? 'Entrenar a Greg'
                                  : 'Activar Suscripción',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubInfoRow(
    String label,
    String value, {
    Color? valueColor,
    IconData? icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
        ),
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: valueColor ?? Colors.white, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor ?? Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConversationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E2429),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personalidad & Estilo de Conversación',
                  style: GoogleFonts.outfit(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Define cómo quieres que hable Greg con tus clientes.',
                  style: GoogleFonts.inter(
                    color:
                        Theme.of(context).textTheme.bodySmall?.color ??
                        Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: Theme.of(context).dividerColor),
                ),
                // Tone Selection
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tono de conversación',
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildToneOption('Friendly', 'friendly'),
                          _buildToneOption('Professional', 'professional'),
                          _buildToneOption('Casual', 'casual'),
                          _buildToneOption('Formal', 'formal'),
                          _buildToneOption('Technical', 'technical'),
                          _buildToneOption('Absolute', 'absolute'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Blacklist Section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lista negra de palabras',
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _blacklistController,
                                decoration: const InputDecoration(
                                  hintText: 'Agrega palabras...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_blacklistController.text.isNotEmpty) {
                                  setState(() {
                                    _blacklist.add(_blacklistController.text);
                                    _blacklistController.clear();
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Color(0xFF4B39EF),
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _blacklist
                            .map((word) => _buildBlacklistChip(word))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildToneOption(String label, String value) {
    bool isSelected = _conversationTone == value;
    return InkWell(
      onTap: () {
        setState(() => _conversationTone = value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4B39EF).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF4B39EF)
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              size: 16,
              color: isSelected ? const Color(0xFF4B39EF) : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlacklistChip(String word) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF4B39EF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF4B39EF).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(word, style: const TextStyle(color: Colors.white, fontSize: 13)),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              setState(() => _blacklist.remove(word));
            },
            child: const Icon(Icons.close, size: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Integraciones',
                  style: GoogleFonts.outfit(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Define cómo quieres que hable Greg con tus clientes.',
                  style: GoogleFonts.inter(
                    color:
                        Theme.of(context).textTheme.bodySmall?.color ??
                        Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: Theme.of(context).dividerColor),
                ),
                // WhatsApp Integration Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.chat,
                              color: Color(0xFF25D366),
                              size: 32,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Activo',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF249689),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.chat,
                                    color: Color(0xFF25D366),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '+58 4242885054',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF249689),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'WhatsApp',
                        style: GoogleFonts.outfit(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Crea un asistente virtual y conéctalo a tu cuenta de WhatsApp Business.',
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Conectar',
                              style: GoogleFonts.inter(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Switch(
                            value: true, // Hardcoded as per image for now
                            onChanged: (v) {},
                            activeThumbColor: const Color(0xFF4B39EF),
                            activeTrackColor: const Color(
                              0xFF4B39EF,
                            ).withOpacity(0.3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notificaciones & Alertas',
                  style: GoogleFonts.outfit(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Decide cuándo recibir notificaciones sobre Greg.',
                  style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: Theme.of(context).dividerColor),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      'Recibir alertas de Greg',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Te avisaremos cuando Greg necesite ayuda o complete tareas importantes.',
                      style: TextStyle(
                        color:
                            Theme.of(context).textTheme.bodySmall?.color ??
                            Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    value: _notifications,
                    onChanged: _isSwitchLoading ? null : _toggleNotifications,
                    activeThumbColor: const Color(0xFF4B39EF),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionManagementTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (!_isSubscriptionActive)
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2429),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.credit_card_off,
                    color: Colors.grey,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No tienes una suscripción activa',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Activa Greg para acceder a todas sus funciones.',
                    style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else if (_cancelAtPeriodEnd)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E2429),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.withOpacity(0.3)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.amber),
                      const SizedBox(width: 8),
                      Text(
                        'Cancelación Programada',
                        style: GoogleFonts.outfit(
                          color: Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Builder(
                    builder: (context) {
                      String dateStr =
                          _nextBillingDate ?? 'el final del periodo';
                      try {
                        if (_nextBillingDate != null) {
                          final date = DateTime.parse(_nextBillingDate!);
                          dateStr = DateFormat(
                            'dd MMM yyyy',
                            'es_ES',
                          ).format(date);
                        }
                      } catch (e) {
                        debugPrint('Date Format Error in Tab: $e');
                      }
                      return Text(
                        'Tu suscripción se cancelará automáticamente el $dateStr. Hasta entonces, seguirás teniendo acceso.',
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E2429),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suspender suscripción:',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSubscriptionLoading
                          ? null
                          : () => _confirmCancelSubscription(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSubscriptionLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Suspender suscripción',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _saveData,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4B39EF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            'Guardar cambios',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoPlayerDialog extends StatefulWidget {
  final String assetPath;
  const _VideoPlayerDialog({required this.assetPath});

  @override
  _VideoPlayerDialogState createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<_VideoPlayerDialog> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Use .asset for all platforms, the plugin handles web path resolution
    _controller = VideoPlayerController.asset(widget.assetPath);

    _controller
        .initialize()
        .then((_) {
          if (mounted) {
            setState(() => _initialized = true);
            _controller.play();
            _controller.setLooping(true);
          }
        })
        .catchError((e) {
          if (mounted) {
            setState(() => _error = e.toString());
          }
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Error al cargar video: $_error',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          else if (_initialized)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Color(0xFF4B39EF),
                    bufferedColor: Colors.white24,
                    backgroundColor: Colors.white10,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                    ),
                  ],
                ),
              ],
            )
          else
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4B39EF)),
            ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
