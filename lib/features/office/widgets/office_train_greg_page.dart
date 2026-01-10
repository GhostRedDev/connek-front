import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/models/greg_model.dart';
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

  // Local State
  bool _allowRescheduling = false;
  bool _cancellationMotive = false;
  bool _requirePaymentProof = false;
  String _refundPolicyType = 'No Refund'; // Default
  List<String> _acceptedPaymentMethods = [];

  // Loading state
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);

    _cancellationPolicyController = TextEditingController();
    _escalationTimeController = TextEditingController();
    _paymentPolicyController = TextEditingController();
    _refundPolicyDetailsController = TextEditingController();
    _privacyPolicyController = TextEditingController();

    _procedure1Controller = TextEditingController();
    _procedure2Controller = TextEditingController();
    _procedure3Controller = TextEditingController();

    // Load Data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TODO: Replace with actual business ID logic
      ref.read(gregProvider.notifier).loadGreg(1).then((_) {
        // Safe access to state after load
        final state = ref.read(gregProvider);
        if (state is GregLoaded) {
          _populateFields(state.greg);
        }
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    });
  }

  void _populateFields(GregModel greg) {
    _cancellationPolicyController.text = greg.cancellationPolicy;
    _escalationTimeController.text = greg.escalationTimeMinutes.toString();
    _paymentPolicyController.text = greg.paymentPolicy;
    _refundPolicyDetailsController.text = greg.refundPolicyDetails ?? '';
    _privacyPolicyController.text = greg.privacyPolicy;

    if (greg.procedures.isNotEmpty) {
      _procedure1Controller.text = greg.procedures[0];
    }
    if (greg.procedures.length > 1) {
      _procedure2Controller.text = greg.procedures[1];
    }
    if (greg.procedures.length > 2) {
      _procedure3Controller.text = greg.procedures[2];
    }

    if (mounted) {
      setState(() {
        _allowRescheduling = greg.allowRescheduling;
        _cancellationMotive = greg.cancellationMotive;
        _requirePaymentProof = greg.requirePaymentProof;
        _refundPolicyType = greg.refundPolicy.isNotEmpty
            ? greg.refundPolicy
            : 'No Refund';
        _acceptedPaymentMethods = List.from(greg.acceptedPaymentMethods);
      });
    }
  }

  void _saveData() {
    final currentState = ref.read(gregProvider);
    if (currentState is! GregLoaded) return;

    final procedures = [
      _procedure1Controller.text,
      _procedure2Controller.text,
      _procedure3Controller.text,
    ].where((s) => s.isNotEmpty).toList();

    final updatedGreg = currentState.greg.copyWith(
      cancellationPolicy: _cancellationPolicyController.text,
      allowRescheduling: _allowRescheduling,
      cancellationMotive: _cancellationMotive,
      escalationTimeMinutes: int.tryParse(_escalationTimeController.text) ?? 0,
      paymentPolicy: _paymentPolicyController.text,
      requirePaymentProof: _requirePaymentProof,
      refundPolicy: _refundPolicyType,
      refundPolicyDetails: _refundPolicyDetailsController.text,
      acceptedPaymentMethods: _acceptedPaymentMethods,
      procedures: procedures,
      privacyPolicy: _privacyPolicyController.text,
    );

    ref.read(gregProvider.notifier).updateGreg(updatedGreg);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración guardada correctamente')),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cancellationPolicyController.dispose();
    _escalationTimeController.dispose();
    _paymentPolicyController.dispose();
    _refundPolicyDetailsController.dispose();
    _privacyPolicyController.dispose();
    _procedure1Controller.dispose();
    _procedure2Controller.dispose();
    _procedure3Controller.dispose();
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
        child: SingleChildScrollView(
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
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Text(
                            'Biblioteca - Coming Soon',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 70),
            ],
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
                // Using a placeholder or the requested asset if available
                image: AssetImage('assets/images/GREG_CARD_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Define qué decir cuando un cliente cancela o cambia su cita.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            'Entrena a Greg',
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
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: const Color(0xFF4B39EF),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Cancelaciones', icon: Icon(Icons.cancel_outlined)),
          Tab(
            text: 'Pagos y reembolsos',
            icon: Icon(Icons.monetization_on_outlined),
          ),
          Tab(text: 'Procedimientos', icon: Icon(Icons.format_list_numbered)),
          Tab(text: 'Privacidad', icon: Icon(Icons.privacy_tip_outlined)),
          Tab(text: 'Políticas', icon: Icon(Icons.article_outlined)),
          Tab(text: 'Biblioteca', icon: Icon(Icons.library_books_outlined)),
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
        const Text('Adjuntar documentos', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        _buildUploadPlaceholder(),
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
        _buildRadioGroup(['No Refund', 'Full Refund', 'Custom Refund']),
        const SizedBox(height: 16),
        _buildTextField(
          'Refund policy',
          _refundPolicyDetailsController,
          hintText: 'Describe condiciones para devoluciones, si aplican.',
          minLines: 5,
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
      ],
    );
  }

  Widget _buildPrivacyTab() {
    return _buildSectionContainer(
      title: 'Privacidad',
      subtitle: 'Gestiona la información privada y el consentimiento.',
      children: [
        _buildTextField(
          'Política de Privacidad',
          _privacyPolicyController,
          hintText: 'Información que no se debe compartir...',
          minLines: 5,
        ),
      ],
    );
  }

  Widget _buildProcedureStep(int step, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131619),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: const Color(0xFF4B39EF).withOpacity(0.2),
            child: Text(
              '$step',
              style: const TextStyle(color: Color(0xFF4B39EF), fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Describe el paso...',
                hintStyle: TextStyle(color: Colors.grey),
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
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: minLines > 1 ? null : 1,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color(0xFF131619),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4B39EF)),
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
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFF4B39EF),
            activeTrackColor: const Color(0xFF4B39EF).withOpacity(0.3),
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

  Widget _buildRadioGroup(List<String> options) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131619),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: options.map((option) {
          return RadioListTile<String>(
            title: Text(option, style: const TextStyle(color: Colors.white)),
            value: option,
            groupValue: _refundPolicyType,
            activeColor: const Color(0xFF4B39EF),
            onChanged: (val) {
              if (val != null) setState(() => _refundPolicyType = val);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF131619),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.upload_file, color: Colors.white54, size: 32),
          SizedBox(height: 8),
          Text('Subir documentos', style: TextStyle(color: Colors.white54)),
          Text(
            '.pdf, .docx, .doc (3MB por archivo)',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
