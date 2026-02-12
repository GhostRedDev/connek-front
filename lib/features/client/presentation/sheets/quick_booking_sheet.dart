import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';
import '../../../../system_ui/form/date_pickers.dart';
import '../../../search/models/service_search_item.dart';
import '../../../../shared/providers/booking_provider.dart';
import '../../../../features/settings/providers/profile_provider.dart';
import '../../../../features/business/presentation/providers/business_provider.dart';

class QuickBookingSheet extends ConsumerStatefulWidget {
  final ServiceSearchItem service;

  const QuickBookingSheet({super.key, required this.service});

  @override
  ConsumerState<QuickBookingSheet> createState() => _QuickBookingSheetState();
}

class _QuickBookingSheetState extends ConsumerState<QuickBookingSheet> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  int? _selectedEmployeeId;
  bool _isLoading = false;
  Map<String, dynamic> _formAnswers = {};
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print('QuickBookingSheet V2 Loaded');
  }

  // Generating time slots every 30 mins from 8 AM to 6 PM
  List<TimeOfDay> _generateTimeSlots() {
    final slots = <TimeOfDay>[];
    for (int hour = 8; hour < 18; hour++) {
      slots.add(TimeOfDay(hour: hour, minute: 0));
      slots.add(TimeOfDay(hour: hour, minute: 30));
    }
    return slots;
  }

  // Mock checking if a slot is busy (randomly for demo)
  bool _isSlotBusy(DateTime date, TimeOfDay time) {
    // For demo purposes, disable 10:00 and 14:30 on the selected date
    if (time.hour == 10 && time.minute == 0) return true;
    if (time.hour == 14 && time.minute == 30) return true;
    return false;
  }

  Future<void> _handleBooking() async {
    if (_selectedTime == null) return;
    if (widget.service.customForm != null &&
        widget.service.customForm!.isNotEmpty) {
      if (!_formKey.currentState!.validate()) {
        ShadToaster.of(context).show(
          const ShadToast.destructive(
            title: Text('Datos requeridos'),
            description: Text('Por favor responda las preguntas del servicio.'),
          ),
        );
        return;
      }
      _formKey.currentState!.save();
    }

    // Check if user is logged in via profile
    final profile = ref.read(profileProvider).value;
    if (profile == null) {
      ShadToaster.of(context).show(
        ShadToast.destructive(
          title: const Text('Acceso Denegado'),
          description: const Text('Debes iniciar sesión para agendar.'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final bookingDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    try {
      final success = await ref
          .read(bookingUpdateProvider)
          .createClientBooking(
            businessId: widget.service.businessId,
            serviceId: widget.service.serviceId,
            date: bookingDate,
            employeeId: _selectedEmployeeId,
            customFormAnswers: _formAnswers,
          );

      if (mounted) {
        setState(() => _isLoading = false);
        if (success) {
          Navigator.pop(context);
          _showSuccessDialog();
        } else {
          ShadToaster.of(context).show(
            ShadToast.destructive(
              title: const Text('Error'),
              description: const Text(
                'Error al crear la reserva. Intenta de nuevo.',
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        print('QuickBookingSheet Error: $e');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Ocurrió un error: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '¡Reserva Exitosa!',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Tu cita para ${widget.service.serviceName} ha sido agendada correctamente.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              '${DateFormat('EEEE d, HH:mm', 'es').format(DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime!.hour, _selectedTime!.minute))}',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Entendido',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final timeSlots = _generateTimeSlots();

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agendar Cita',
                      style: GoogleFonts.outfit(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.foreground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.service.serviceName,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'con ${widget.service.businessName}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: theme.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Calendar Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: theme.colorScheme.border.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selecciona fecha',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.mutedForeground,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AppCalendar(
                          value: _selectedDate,
                          onValueChange: (date) {
                            if (date != null) {
                              setState(() {
                                _selectedDate = date;
                                _selectedTime = null; // Reset time
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Employee Selection Section
                  _EmployeeSelection(
                    businessId: widget.service.businessId,
                    selectedId: _selectedEmployeeId,
                    onSelect: (id) => setState(() => _selectedEmployeeId = id),
                  ),

                  const SizedBox(height: 24),

                  // Custom Service Questions
                  if (widget.service.customForm != null &&
                      widget.service.customForm!.isNotEmpty) ...[
                    Text(
                      'Detalles del Servicio',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: widget.service.customForm!.map((q) {
                          final id = q['id'].toString();
                          final type = q['type'];
                          final label = q['label'];
                          final required = q['required'] == true;
                          final options = q['options'] as List<dynamic>?;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  label + (required ? ' *' : ''),
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: theme.colorScheme.foreground,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (type == 'boolean')
                                  Row(
                                    children: [
                                      Expanded(
                                        child: RadioListTile<bool>(
                                          title: const Text('Si'),
                                          value: true,
                                          groupValue: _formAnswers[id],
                                          onChanged: (val) => setState(
                                            () => _formAnswers[id] = val,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile<bool>(
                                          title: const Text('No'),
                                          value: false,
                                          groupValue: _formAnswers[id],
                                          onChanged: (val) => setState(
                                            () => _formAnswers[id] = val,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    ],
                                  )
                                else if (type == 'options' && options != null)
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: theme.colorScheme.card,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: theme.colorScheme.border,
                                        ),
                                      ),
                                    ),
                                    dropdownColor: theme.colorScheme.card,
                                    items: options
                                        .map<DropdownMenuItem<String>>((opt) {
                                          return DropdownMenuItem(
                                            value: opt.toString(),
                                            child: Text(opt.toString()),
                                          );
                                        })
                                        .toList(),
                                    onChanged: (val) =>
                                        setState(() => _formAnswers[id] = val),
                                    validator: required
                                        ? (val) =>
                                              val == null ? 'Requerido' : null
                                        : null,
                                  )
                                else
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: 'Escribe tu respuesta',
                                      filled: true,
                                      fillColor: theme.colorScheme.card,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: theme.colorScheme.border,
                                        ),
                                      ),
                                    ),
                                    onSaved: (val) => _formAnswers[id] = val,
                                    validator: required
                                        ? (val) => val == null || val.isEmpty
                                              ? 'Requerido'
                                              : null
                                        : null,
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Time Slots Section
                  Text(
                    'Horarios disponibles',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('EEEE d, MMMM', 'es').format(_selectedDate),
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: timeSlots.map((time) {
                      final isSelected = _selectedTime == time;
                      final isBusy = _isSlotBusy(_selectedDate, time);

                      return InkWell(
                        onTap: isBusy
                            ? null
                            : () => setState(() => _selectedTime = time),
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 85,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isBusy
                                ? theme.colorScheme.muted.withOpacity(0.5)
                                : isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.card,
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.border,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: theme.colorScheme.primary
                                          .withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                              style: GoogleFonts.inter(
                                color: isBusy
                                    ? theme.colorScheme.mutedForeground
                                    : isSelected
                                    ? theme.colorScheme.primaryForeground
                                    : theme.colorScheme.foreground,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                decoration: isBusy
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),

          // Bottom Action Bar
          Container(
            padding: const EdgeInsets.only(top: 16, bottom: 32),
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              border: Border(top: BorderSide(color: theme.colorScheme.border)),
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (_selectedTime != null && !_isLoading)
                      ? _handleBooking
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: theme.colorScheme.primary.withOpacity(0.4),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : Text(
                          'Confirmar Reserva',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primaryForeground,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmployeeSelection extends ConsumerWidget {
  final int businessId;
  final int? selectedId;
  final Function(int?) onSelect;

  const _EmployeeSelection({
    required this.businessId,
    required this.selectedId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We can use a FutureProvider for employees here or just watch a future
    // For simplicity, let's create a temporary provider or just use FutureBuilder/Repository
    // But since we are inside a ConsumerWidget, let's use the repository directly via FutureProvider

    final employeesFuture = ref.watch(employeesProvider(businessId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selecciona Profesional',
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        employeesFuture.when(
          data: (employees) {
            if (employees.isEmpty) {
              return Text(
                'Cualquier profesional disponible',
                style: GoogleFonts.inter(color: Colors.grey),
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // "Anyone" Option
                  _buildAvatarItem(
                    context,
                    id: null,
                    name: 'Cualquiera',
                    imageUrl: null,
                    isSelected: selectedId == null,
                  ),
                  ...employees.map(
                    (e) => _buildAvatarItem(
                      context,
                      id: e['id'],
                      name: e['first_name'] ?? 'Staff',
                      imageUrl: e['photo_url'], // Standardize image key?
                      isSelected: selectedId == e['id'],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text(
            'Error al cargar personal',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarItem(
    BuildContext context, {
    required int? id,
    required String name,
    String? imageUrl,
    required bool isSelected,
  }) {
    final theme = ShadTheme.of(context);
    return GestureDetector(
      onTap: () => onSelect(id),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  width: 3,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0), // Gap
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                      ? CachedNetworkImageProvider(imageUrl)
                      : null,
                  child: imageUrl == null || imageUrl.isEmpty
                      ? Icon(
                          id == null ? Icons.groups : Icons.person,
                          color: Colors.grey,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Provider for fetching employees for this sheet
final employeesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((
      ref,
      businessId,
    ) async {
      final repo = ref.read(businessRepositoryProvider);
      return repo.getEmployees(businessId);
    });
