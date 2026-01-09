import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController _cancellationPolicyController;
  late TextEditingController _privacyPolicyController;
  late TextEditingController _paymentPolicyController;
  late TextEditingController _refundPolicyController;

  // Procedures are a list, let's just do 3 fixed for now like the legacy code implies
  late TextEditingController _procedure1Controller;
  late TextEditingController _procedure2Controller;
  late TextEditingController _procedure3Controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initialize with empty or current state defaults
    _cancellationPolicyController = TextEditingController();
    _privacyPolicyController = TextEditingController();
    _paymentPolicyController = TextEditingController();
    _refundPolicyController = TextEditingController();
    _procedure1Controller = TextEditingController();
    _procedure2Controller = TextEditingController();
    _procedure3Controller = TextEditingController();

    // Trigger load (using dummy ID 1 for now, or get from user context)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gregProvider.notifier).loadGreg(1);
    });
  }

  void _updateControllers(GregModel greg) {
    if (_cancellationPolicyController.text.isEmpty)
      _cancellationPolicyController.text = greg.cancellationPolicy;
    if (_privacyPolicyController.text.isEmpty)
      _privacyPolicyController.text = greg.privacyPolicy;
    if (_paymentPolicyController.text.isEmpty)
      _paymentPolicyController.text = greg.paymentPolicy;
    if (_refundPolicyController.text.isEmpty)
      _refundPolicyController.text = greg.refundPolicy;

    if (greg.procedures.isNotEmpty && _procedure1Controller.text.isEmpty)
      _procedure1Controller.text = greg.procedures[0];
    if (greg.procedures.length > 1 && _procedure2Controller.text.isEmpty)
      _procedure2Controller.text = greg.procedures[1];
    if (greg.procedures.length > 2 && _procedure3Controller.text.isEmpty)
      _procedure3Controller.text = greg.procedures[2];
  }

  @override
  void dispose() {
    _tabController.dispose();
    _cancellationPolicyController.dispose();
    _privacyPolicyController.dispose();
    _paymentPolicyController.dispose();
    _refundPolicyController.dispose();
    _procedure1Controller.dispose();
    _procedure2Controller.dispose();
    _procedure3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gregState = ref.watch(gregProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF131619),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131619),
        title: Text(
          'Entrenar a Greg',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4B39EF),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4B39EF),
          tabs: const [
            Tab(text: 'Políticas'),
            Tab(text: 'Procedimientos'),
            Tab(text: 'Pagos'),
          ],
        ),
      ),
      body: gregState is GregLoading
          ? const Center(child: CircularProgressIndicator())
          : gregState is GregError
          ? Center(
              child: Text(
                'Error: ${gregState.message}',
                style: const TextStyle(color: Colors.red),
              ),
            )
          : _buildContent(
              gregState is GregLoaded ? gregState.greg : GregModel(id: 0),
            ), // Fallback generic
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save logic
          if (gregState is GregLoaded) {
            final updatedGreg = gregState.greg.copyWith(
              cancellationPolicy: _cancellationPolicyController.text,
              privacyPolicy: _privacyPolicyController.text,
              paymentPolicy: _paymentPolicyController.text,
              refundPolicy: _refundPolicyController.text,
              procedures: [
                _procedure1Controller.text,
                _procedure2Controller.text,
                _procedure3Controller.text,
              ],
            );
            ref.read(gregProvider.notifier).updateGreg(updatedGreg);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Guardado!')));
          }
        },
        backgroundColor: const Color(0xFF4B39EF),
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildContent(GregModel greg) {
    // Ideally only update controllers once, but for simplicity in this stateless build method pattern:
    // We conditionally update if empty (done in listener or init usually)
    // For now, let's presume the user is editing what they see.

    return TabBarView(
      controller: _tabController,
      children: [
        _buildPoliciesTab(greg),
        _buildProceduresTab(greg),
        _buildPaymentsTab(greg),
      ],
    );
  }

  Widget _buildPoliciesTab(GregModel greg) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTextField(
            'Política de Cancelación',
            _cancellationPolicyController,
          ),
          const SizedBox(height: 16),
          _buildTextField('Política de Privacidad', _privacyPolicyController),
          const SizedBox(height: 16),
          _buildSwitch('Permitir Reprogramar', greg.allowRescheduling, (val) {
            // Handle local state update or direct provider update
            // ref.read(gregProvider.notifier).updateGreg(greg.copyWith(allowRescheduling: val));
          }),
        ],
      ),
    );
  }

  Widget _buildProceduresTab(GregModel greg) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTextField('Procedimiento 1', _procedure1Controller),
          const SizedBox(height: 16),
          _buildTextField('Procedimiento 2', _procedure2Controller),
          const SizedBox(height: 16),
          _buildTextField('Procedimiento 3', _procedure3Controller),
        ],
      ),
    );
  }

  Widget _buildPaymentsTab(GregModel greg) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildTextField('Política de Pagos', _paymentPolicyController),
          const SizedBox(height: 16),
          _buildTextField('Política de Reembolso', _refundPolicyController),
          const SizedBox(height: 16),
          _buildSwitch(
            'Requerir Comprobante de Pago',
            greg.requirePaymentProof,
            (val) {
              // Update logic
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF4B39EF)),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: const Color(0xFF1E2429),
      ),
      maxLines: 3,
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF4B39EF),
      tileColor: const Color(0xFF1E2429),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
