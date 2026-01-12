import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/greg_model.dart';
import '../../../core/models/user_model.dart';
import '../../settings/providers/profile_provider.dart';
import '../providers/greg_provider.dart';

class OfficeTrainGregPage extends ConsumerStatefulWidget {
  const OfficeTrainGregPage({super.key});

  @override
  ConsumerState<OfficeTrainGregPage> createState() =>
      _OfficeTrainGregPageState();
}

class _OfficeTrainGregPageState extends ConsumerState<OfficeTrainGregPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  // Controllers
  late TextEditingController _cancellationPolicyController;
  late TextEditingController _escalationTimeController;
  late TextEditingController _paymentPolicyController;
  late TextEditingController _refundPolicyDetailsController;
  late TextEditingController _privacyPolicyController;

  // Procedures
  late TextEditingController _procedure1Controller;
  late TextEditingController _procedure2Controller;
  late TextEditingController _procedure3Controller;
  late TextEditingController _procedureDetailsController;
  late TextEditingController _postBookingProceduresController;
  late TextEditingController _confidentialInfoController;

  // Local State
  bool _allowRescheduling = false;
  bool _cancellationMotive = false;
  bool _requirePaymentProof = false;
  bool _askConsent = false;
  String _refundPolicyType = 'No Refund'; // Default
  String _dataStorageLevel = 'Básico - Solo información esencial';
  List<String> _acceptedPaymentMethods = [];
  List<String> _cancellationDocuments = []; // New local state
  final List<Map<String, String>> _excludedContacts = [];
  final List<Map<String, String>> _libraryFiles = [];
  bool _isUploading = false;

  // Loading state
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 6, vsync: this);

    // Listen to tab changes to update intro section
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });

    _cancellationPolicyController = TextEditingController();
    _escalationTimeController = TextEditingController();
    _paymentPolicyController = TextEditingController();
    _refundPolicyDetailsController = TextEditingController();
    _privacyPolicyController = TextEditingController();

    _procedure1Controller = TextEditingController();
    _procedure2Controller = TextEditingController();
    _procedure3Controller = TextEditingController();
    _procedureDetailsController = TextEditingController();
    _postBookingProceduresController = TextEditingController();
    _confidentialInfoController = TextEditingController();

    // Load Data
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      int retries = 0;
      const maxRetries = 2;
      UserProfile? userProfile;

      while (retries <= maxRetries && userProfile == null) {
        try {
          debugPrint(
            '👤 Greg Page: Loading profile (Attempt ${retries + 1})...',
          );
          userProfile = await ref.read(profileProvider.future);
          if (userProfile != null) break;
        } catch (e) {
          debugPrint(
            '⚠️ Greg Page: Profile load error (Attempt ${retries + 1}): $e',
          );
          if (retries < maxRetries) {
            await Future.delayed(Duration(seconds: 1 * (retries + 1)));
          }
        }
        retries++;
      }

      try {
        if (userProfile == null) {
          debugPrint('⚠️ Greg Page: Profile is null after all attempts.');
          if (mounted) setState(() => _isLoading = false);
          return;
        }

        debugPrint(
          '🆔 Greg Page: User Profile found (ID: ${userProfile.id}, Name: ${userProfile.firstName})',
        );

        final client = Supabase.instance.client;
        debugPrint(
          '🔍 Greg Page: Fetching business for owner_client_id: ${userProfile.id}...',
        );

        final businessData = await client
            .from('business')
            .select('id')
            .eq('owner_client_id', userProfile.id)
            .maybeSingle();

        if (businessData != null) {
          final bId = businessData['id'] as int;
          debugPrint('🏢 Greg Page: Business found! businessId: $bId');

          await ref.read(gregProvider.notifier).loadGreg(bId);

          final state = ref.read(gregProvider);
          if (state is GregLoaded) {
            debugPrint('✅ Greg Page: Greg data loaded successfully!');
            _populateFields(state.greg);
          } else if (state is GregError) {
            debugPrint('❌ Greg Page: Greg load error: ${state.message}');
          }
        } else {
          debugPrint('⚠️ Greg Page: No business found for this client.');
        }
      } catch (e) {
        debugPrint('❌ Greg Page: Error during loading sequence: $e');
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _populateFields(GregModel greg) {
    if (!mounted) return;

    // Reverse Mapping for Payments
    final paymentMapReverse = {
      'connek_wallet': 'Connek Wallet',
      'card': 'Card',
      'bank_transfer': 'Bank Transfer',
      'cash': 'Cash',
    };

    // Reverse Mapping for Refund Policy
    final refundMapReverse = {
      'no_refund': 'No Refund',
      'full_refund': 'Full Refund',
      'custom_refund': 'Custom Refund',
    };

    setState(() {
      _cancellationPolicyController.text = greg.cancellations;
      _escalationTimeController.text = greg.escalationTimeMinutes.toString();
      _paymentPolicyController.text = greg.paymentPolicy;
      _refundPolicyDetailsController.text = greg.refundPolicyDetails ?? '';
      _privacyPolicyController.text = greg.privacyPolicy;
      _procedureDetailsController.text = greg.proceduresDetails ?? '';
      _postBookingProceduresController.text = greg.postBookingProcedures ?? '';

      if (greg.procedures.isNotEmpty) {
        _procedure1Controller.text = greg.procedures[0];
      } else {
        _procedure1Controller.text = '';
      }
      if (greg.procedures.length > 1) {
        _procedure2Controller.text = greg.procedures[1];
      } else {
        _procedure2Controller.text = '';
      }
      if (greg.procedures.length > 2) {
        _procedure3Controller.text = greg.procedures[2];
      } else {
        _procedure3Controller.text = '';
      }

      _allowRescheduling = greg.allowRescheduling;
      _cancellationMotive = greg.cancellationMotive;
      _requirePaymentProof = greg.requirePaymentProof;

      _refundPolicyType = refundMapReverse[greg.refundPolicy] ?? 'No Refund';

      _acceptedPaymentMethods = greg.acceptedPaymentMethods
          .map((m) => paymentMapReverse[m] ?? m)
          .toList();

      _cancellationDocuments = List<String>.from(greg.cancellationDocuments);
      _excludedContacts.clear();
      _excludedContacts.addAll(greg.excludedPhones);
      _libraryFiles.clear();
      _libraryFiles.addAll(greg.library);

      // Privacy Mapping
      _askConsent = greg.askForConsent;
      _confidentialInfoController.text = greg.informationNotToShare ?? '';

      final storageLevelMapReverse = {
        'nothing': 'Ninguno - No guardar datos de clientes',
        'basic': 'Básico - Solo información esencial',
        'full': 'Completo - Historial completo de interacciones',
      };
      _dataStorageLevel =
          storageLevelMapReverse[greg.saveInformation] ??
          'Básico - Solo información esencial';
    });
  }

  void _saveData() async {
    final currentState = ref.read(gregProvider);
    if (currentState is! GregLoaded) return;

    // Mapping for Payments (UI Label -> Backend Enum)
    final paymentMap = {
      'Connek Wallet': 'connek_wallet',
      'Card': 'card',
      'Bank Transfer': 'bank_transfer',
      'Cash': 'cash',
    };

    // Mapping for Refund Policy (UI Label -> Backend Enum)
    final refundMap = {
      'No Refund': 'no_refund',
      'Full Refund': 'full_refund',
      'Custom Refund': 'custom_refund',
    };

    final procedures = [
      _procedure1Controller.text,
      _procedure2Controller.text,
      _procedure3Controller.text,
    ].where((s) => s.isNotEmpty).toList();

    final mappedPayments = _acceptedPaymentMethods
        .map((m) => paymentMap[m] ?? m)
        .toList();
    final mappedRefund = refundMap[_refundPolicyType] ?? _refundPolicyType;

    // Privacy Mapping (UI Label -> Backend Enum)
    final storageLevelMap = {
      'Ninguno - No guardar datos de clientes': 'nothing',
      'Básico - Solo información esencial': 'basic',
      'Completo - Historial completo de interacciones': 'full',
    };
    final mappedStorage = storageLevelMap[_dataStorageLevel] ?? 'nothing';

    final updatedGreg = currentState.greg.copyWith(
      cancellations: _cancellationPolicyController.text,
      allowRescheduling: _allowRescheduling,
      cancellationMotive: _cancellationMotive,
      escalationTimeMinutes: int.tryParse(_escalationTimeController.text) ?? 0,
      paymentPolicy: _paymentPolicyController.text,
      requirePaymentProof: _requirePaymentProof,
      refundPolicy: mappedRefund,
      refundPolicyDetails: _refundPolicyDetailsController.text,
      acceptedPaymentMethods: mappedPayments,
      procedures: procedures,
      proceduresDetails: _procedureDetailsController.text,
      postBookingProcedures: _postBookingProceduresController.text,
      privacyPolicy: _privacyPolicyController.text,
      cancellationDocuments: _cancellationDocuments,
      excludedPhones: _excludedContacts,
      library: _libraryFiles,
      saveInformation: mappedStorage,
      askForConsent: _askConsent,
      informationNotToShare: _confidentialInfoController.text,
    );

    setState(() => _isLoading = true);
    try {
      if (_tabController.index == 0) {
        // Cancellations tab
        await ref
            .read(gregProvider.notifier)
            .updateGregCancellations(updatedGreg);
      } else if (_tabController.index == 1) {
        // Payments tab
        await ref.read(gregProvider.notifier).updateGregPayments(updatedGreg);
      } else if (_tabController.index == 2) {
        // Procedures tab
        await ref.read(gregProvider.notifier).updateGregProcedures(updatedGreg);
      } else if (_tabController.index == 3) {
        // Privacy tab
        await ref.read(gregProvider.notifier).updateGregPrivacy(updatedGreg);
      } else if (_tabController.index == 5) {
        // Biblioteca tab
        await ref.read(gregProvider.notifier).updateGregLibrary(updatedGreg);
      } else {
        // General update (including index 4 - Políticas)
        await ref.read(gregProvider.notifier).updateGreg(updatedGreg);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Configuración guardada correctamente')),
        );
      }
    } catch (e) {
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
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    _cancellationPolicyController.dispose();
    _escalationTimeController.dispose();
    _paymentPolicyController.dispose();
    _refundPolicyDetailsController.dispose();
    _privacyPolicyController.dispose();
    _procedure1Controller.dispose();
    _procedure2Controller.dispose();
    _procedure3Controller.dispose();
    _procedureDetailsController.dispose();
    _postBookingProceduresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF131619),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF131619),
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          thickness: 6,
          radius: const Radius.circular(3),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildIntroSection(),
                _buildTabBar(),
                // Dynamic Content based on Tab
                AnimatedBuilder(
                  animation: _tabController,
                  builder: (context, _) {
                    return IndexedStack(
                      index: _tabController.index,
                      children: [
                        _buildCancellationsTab(),
                        _buildPaymentsTab(),
                        _buildProceduresTab(),
                        _buildPrivacyTab(),
                        const Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Center(
                            child: Text(
                              'Políticas - Coming Soon',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        _buildLibraryTab(),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 101.0,
        left: 15.0,
        right: 15.0,
        bottom: 10.0,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2429),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Mis bots',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: _saveData,
            child: Row(
              children: [
                Text(
                  'Greg',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
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
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection() {
    String text =
        'Enséñame cómo funcionan tus políticas y reglas. Así podré responder como si fuera parte de tu equipo.';
    String title = 'Entrena a Greg';

    switch (_tabController.index) {
      case 0:
        text = 'Define qué decir cuando un cliente cancela o cambia su cita.';
        break;
      case 1:
        text =
            'Define los métodos de pago aceptados y condiciones de reembolsos.';
        break;
      case 2:
        text = 'Define paso a paso cómo se desarrollan tus servicios.';
        break;
      case 3:
        text = 'Define cómo Greg maneja los datos de tus clientes.';
        break;
      case 5:
        text =
            'Sube manuales, instructivos o imágenes de referencia para Greg.';
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/GREG_CARD_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enséñame cómo funcionan tus políticas, procesos y reglas internas. Así podré responder como si fuera parte de tu equipo.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: const Color(0xFF131619),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: const Color(0xFF1A2634), // Darker navy for active box
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: const Color(0xFF8BB7FF), // Light blue selected color
        unselectedLabelColor: Colors.grey,
        labelStyle: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        tabs: const [
          Tab(
            height: 56,
            child: Row(
              children: [
                Icon(Icons.highlight_off_outlined, size: 24),
                SizedBox(width: 8),
                Text('Cancelaciones'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              children: [
                Icon(Icons.payments_outlined, size: 24),
                SizedBox(width: 8),
                Text('Pagos y reembolsos'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              children: [
                Icon(Icons.list_alt_outlined, size: 24),
                SizedBox(width: 8),
                Text('Procedimientos'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              children: [
                Icon(Icons.visibility_outlined, size: 24),
                SizedBox(width: 8),
                Text('Privacidad'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              children: [
                Icon(Icons.description_outlined, size: 24),
                SizedBox(width: 8),
                Text('Políticas'),
              ],
            ),
          ),
          Tab(
            height: 56,
            child: Row(
              children: [
                Icon(Icons.menu_book_outlined, size: 24),
                SizedBox(width: 8),
                Text('Biblioteca'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer({
    required String title,
    String? subtitle,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E2429), // bg2Sec
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Center(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            ...children,
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCancellationsTab() {
    return _buildSectionContainer(
      title: 'Cancelaciones',
      children: [
        _buildTextField(
          'Cancellation policy',
          _cancellationPolicyController,
          minLines: 5,
        ),
        const SizedBox(height: 16),
        _buildSwitchTile(
          title: 'Permitir reprogramar',
          subtitle: '¿Los clientes pueden cambiar la fecha?',
          value: _allowRescheduling,
          onChanged: (v) => setState(() => _allowRescheduling = v),
        ),
        const SizedBox(height: 16),
        _buildSwitchTile(
          title: 'Solicitar motivo de cancelación',
          subtitle: '¿Por qué el cliente quiere cancelar?',
          value: _cancellationMotive,
          onChanged: (v) => setState(() => _cancellationMotive = v),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          'Escalation time (minutes)',
          _escalationTimeController,
          hintText: '24 hours',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 24),
        Text(
          'Adjuntar documentos',
          style: GoogleFonts.outfit(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        _buildUploadPlaceholder(),
        if (_cancellationDocuments.isNotEmpty) ...[
          const SizedBox(height: 16),
          ..._cancellationDocuments.map(
            (doc) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.file_present_outlined,
                      color: Colors.white70,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        doc,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white54,
                        size: 18,
                      ),
                      onPressed: () =>
                          setState(() => _cancellationDocuments.remove(doc)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 32),
        SizedBox(
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
              'Guardar Cambios',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentsTab() {
    return _buildSectionContainer(
      title: 'Pagos y reembolsos',
      subtitle:
          'Define los métodos de pago aceptados y condiciones de reembolsos.',
      children: [
        const Text(
          'Accepted payment methods',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        _buildCheckboxGroup(['Connek Wallet', 'Card', 'Bank Transfer', 'Cash']),
        const SizedBox(height: 16),
        _buildTextField(
          'Payment policy',
          _paymentPolicyController,
          hintText: 'Ej. Se requiere un depósito del 50% antes del servicio.',
          minLines: 5,
        ),
        const SizedBox(height: 16),
        _buildSwitchTile(
          title: 'Requiere comprobante de pago',
          subtitle: '¿Solicitar comprobante al cliente?',
          value: _requirePaymentProof,
          onChanged: (v) => setState(() => _requirePaymentProof = v),
        ),
        const SizedBox(height: 16),
        const Text(
          'Política de reembolsos',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        _buildRadioGroup(
          options: ['No Refund', 'Full Refund', 'Custom Refund'],
          currentValue: _refundPolicyType,
          onChanged: (val) {
            if (val != null) setState(() => _refundPolicyType = val);
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          'Refund policy',
          _refundPolicyDetailsController,
          hintText: 'Describe condiciones para devoluciones, si aplican.',
          minLines: 5,
        ),
        const SizedBox(height: 32),
        SizedBox(
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
              'Guardar Cambios',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProceduresTab() {
    return _buildSectionContainer(
      title: 'Procedimientos internos',
      subtitle: 'Define paso a paso cómo se desarrollan tus servicios.',
      children: [
        const Text(
          'Pasos del procedimiento (max 3)',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 16),
        _buildProcedureStep(1, _procedure1Controller),
        const SizedBox(height: 16),
        _buildProcedureStep(2, _procedure2Controller),
        const SizedBox(height: 16),
        _buildProcedureStep(3, _procedure3Controller),
        const SizedBox(height: 24),
        _buildTextField(
          'Detalles de procedimientos',
          _procedureDetailsController,
          hintText: 'Añade instrucciones adicionales para Greg',
          minLines: 5,
        ),
        const SizedBox(height: 24),
        _buildTextField(
          'Procedimientos post-reserva',
          _postBookingProceduresController,
          hintText: 'Añade instrucciones para después de la reserva',
          minLines: 5,
        ),
        const SizedBox(height: 24),
        const Text(
          'Adjuntar documentos de cancelación',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _isUploading ? null : _pickAndUploadCancellationDocument,
          borderRadius: BorderRadius.circular(20),
          child: _isUploading
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131619),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF4B39EF)),
                  ),
                )
              : _buildUploadPlaceholder(),
        ),
        if (_cancellationDocuments.isNotEmpty) ...[
          const SizedBox(height: 16),
          ..._cancellationDocuments.map(
            (doc) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.attach_file,
                    color: Color(0xFF4B39EF),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      doc.split('/').last,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 16,
                    ),
                    onPressed: () =>
                        setState(() => _cancellationDocuments.remove(doc)),
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 32),
        SizedBox(
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
              'Guardar Cambios',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyTab() {
    return _buildSectionContainer(
      title: 'Privacidad y confidencialidad',
      subtitle: 'Define cómo Greg maneja los datos de tus clientes',
      children: [
        const Text(
          'Nivel de almacenamiento de datos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        _buildRadioGroup(
          options: [
            'Ninguno - No guardar datos de clientes',
            'Básico - Solo información esencial',
            'Completo - Historial completo de interacciones',
          ],
          currentValue: _dataStorageLevel,
          onChanged: (val) {
            if (val != null) setState(() => _dataStorageLevel = val);
          },
        ),
        const SizedBox(height: 24),
        _buildSwitchTile(
          title: 'Pedir consentimiento antes',
          subtitle: '¿Solicitar permiso para guardar datos?',
          value: _askConsent,
          onChanged: (v) => setState(() => _askConsent = v),
        ),
        const SizedBox(height: 24),
        _buildTextField(
          'Política de privacidad (opcional)',
          _privacyPolicyController,
          hintText:
              'Informa a Greg sobre tu política de privacidad. ¿Qué información recolectas y por qué? ¿Cómo proteges la información de tus clientes?',
          minLines: 5,
        ),
        const SizedBox(height: 24),
        // Confidential Info Section
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D1E16),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1B5E20).withOpacity(0.4)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('🔒', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Información que Greg NO comparte con el cliente',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(
                '',
                _confidentialInfoController,
                hintText:
                    'Ej. Precios internos, márgenes de ganancia, información confidencial del negocio...',
                minLines: 5,
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Esta información será conocida por Greg pero nunca la revelará en las conversaciones',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: Colors.white60, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // Excluded Contacts Section
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1315),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFB71C1C).withOpacity(0.3)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Contactos Excluidos',
                style: GoogleFonts.outfit(
                  color: const Color(0xFFE53935),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Define qué contactos Greg nunca debe atender para proteger tu vida personal',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF131619),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.phone_outlined,
                        color: Color(0xFFE53935),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${_excludedContacts.length} contactos excluidos',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _showAddContactModal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Añadir contacto',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (_excludedContacts.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),
                ..._excludedContacts.map(
                  (contact) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white70,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contact['name'] ?? '',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                contact['phone'] ?? '',
                                style: GoogleFonts.inter(
                                  color: Colors.white38,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _excludedContacts.remove(contact);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
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
              'Guardar Cambios',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddContactModal() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF131619),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
              220, // Final adjustment to clear navigation bar fully
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nuevo Contacto',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Nombre',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1E2429),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Teléfono',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1E2429),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.white10),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty) {
                    setState(() {
                      _excludedContacts.add({
                        'name': nameController.text,
                        'phone': phoneController.text,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B39EF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Guardar',
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
    );
  }

  Widget _buildProcedureStep(int step, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131619),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: const Color(0xFF4B39EF).withOpacity(0.2),
              child: Text(
                '$step',
                style: const TextStyle(color: Color(0xFF4B39EF), fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              minLines: 1,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Describe el paso...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int minLines = 1,
    String? hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: minLines > 1 ? null : 1,
          keyboardType: keyboardType,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF131619),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF4B39EF),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131619),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF4B39EF),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.white10,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxGroup(List<String> options) {
    return Column(
      children: options.map((option) {
        final isSelected = _acceptedPaymentMethods.contains(option);
        return CheckboxListTile(
          title: Text(option, style: const TextStyle(color: Colors.white)),
          value: isSelected,
          activeColor: const Color(0xFF4B39EF),
          contentPadding: EdgeInsets.zero,
          onChanged: (val) {
            setState(() {
              if (val == true) {
                _acceptedPaymentMethods.add(option);
              } else {
                _acceptedPaymentMethods.remove(option);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRadioGroup({
    required List<String> options,
    required String currentValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131619),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: options.map((option) {
          final bool isSelected = currentValue == option;
          return Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white24),
            child: RadioListTile<String>(
              title: Text(
                option,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
              value: option,
              groupValue: currentValue,
              activeColor: const Color(0xFF4B39EF),
              onChanged: onChanged,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLibraryTab() {
    return _buildSectionContainer(
      title: 'Biblioteca de documentos',
      subtitle: 'Sube manuales, instructivos o imágenes de referencia.',
      children: [
        InkWell(
          onTap: _isUploading ? null : _pickAndUploadLibraryFile,
          borderRadius: BorderRadius.circular(20),
          child: _isUploading
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131619),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFF4B39EF)),
                  ),
                )
              : _buildUploadPlaceholder(),
        ),
        const SizedBox(height: 32),
        if (_libraryFiles.isNotEmpty) ...[
          Text(
            'Archivos subidos',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ..._libraryFiles.map(
            (file) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2429),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4B39EF).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child:
                          (file['name']?.toLowerCase().endsWith('.jpg') ??
                                  false) ||
                              (file['name']?.toLowerCase().endsWith('.jpeg') ??
                                  false) ||
                              (file['name']?.toLowerCase().endsWith('.png') ??
                                  false)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                'https://bzndcfewyihbytjpitil.supabase.co/storage/v1/object/public/client/${file['path'] ?? 'library/${file['filename']}'}',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.white24,
                                      size: 20,
                                    ),
                              ),
                            )
                          : const Icon(
                              Icons.description_outlined,
                              color: Color(0xFF4B39EF),
                              size: 20,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            file['name'] ?? 'Unknown',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (file['size'] != null)
                            Text(
                              file['size']!,
                              style: GoogleFonts.inter(
                                color: Colors.white38,
                                fontSize: 13,
                              ),
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _deleteLibraryFile(file),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: 32),
        SizedBox(
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
              'Guardar Cambios',
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickAndUploadLibraryFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        withData: true, // Required for Web to get bytes
      );

      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        final fileBytes = file.bytes!;

        // Check size (3MB limit as per brief)
        if (file.size > 3 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('El archivo supera el límite de 3MB'),
              ),
            );
          }
          return;
        }

        setState(() => _isUploading = true);

        final fileName =
            'greg_${DateTime.now().millisecondsSinceEpoch}_${file.name}';
        final filePath = 'library/$fileName';

        // Upload to Supabase Storage
        final supabase = Supabase.instance.client;

        await supabase.storage
            .from('client')
            .uploadBinary(
              filePath,
              fileBytes,
              fileOptions: const FileOptions(upsert: true),
            );

        // Get Filename/URL
        // The brief says structural metadata: {"name": "...", "filename": "..."}
        if (mounted) {
          setState(() {
            _libraryFiles.add({
              'name': file.name,
              'filename': fileName,
              'size': '${(file.size / 1024 / 1024).toStringAsFixed(1)} mb',
              'path': filePath,
            });
            _isUploading = false;
          });
        }
      }
    } catch (e) {
      print('Error uploading file: $e');
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al subir archivo: $e')));
      }
    }
  }

  void _deleteLibraryFile(Map<String, String> file) {
    setState(() {
      _libraryFiles.remove(file);
    });
  }

  Future<void> _pickAndUploadCancellationDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
        withData: true,
      );

      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        if (file.size > 3 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('El archivo supera el límite de 3MB'),
              ),
            );
          }
          return;
        }

        setState(() => _isUploading = true);
        final fileName =
            'cancel_${DateTime.now().millisecondsSinceEpoch}_${file.name}';
        final filePath = 'cancellations/$fileName';

        final supabase = Supabase.instance.client;
        await supabase.storage
            .from('client')
            .uploadBinary(
              filePath,
              file.bytes!,
              fileOptions: const FileOptions(upsert: true),
            );

        if (mounted) {
          setState(() {
            _cancellationDocuments.add(filePath);
            _isUploading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al subir documento: $e')));
      }
    }
  }

  Widget _buildUploadPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF131619),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.description_outlined, color: Colors.white, size: 32),
          const SizedBox(height: 12),
          Text(
            'Subir documentos',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '.pdf, .docxs, .doc (3MB por archivo)',
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
