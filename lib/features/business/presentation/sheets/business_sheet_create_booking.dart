import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connek_frontend/system_ui/typography.dart';
import 'package:connek_frontend/system_ui/form/inputs.dart'; // AppInput probably or similar
import 'package:connek_frontend/system_ui/layout/buttons.dart';
import 'package:connek_frontend/features/business/presentation/providers/business_provider.dart';
import 'package:connek_frontend/shared/providers/booking_provider.dart';
import 'package:connek_frontend/core/providers/locale_provider.dart';
import 'package:connek_frontend/core/constants/connek_icons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';

class BusinessSheetCreateBooking extends ConsumerStatefulWidget {
  const BusinessSheetCreateBooking({super.key});

  @override
  ConsumerState<BusinessSheetCreateBooking> createState() =>
      _BusinessSheetCreateBookingState();
}

class _BusinessSheetCreateBookingState
    extends ConsumerState<BusinessSheetCreateBooking> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int? _selectedClientId;
  int? _selectedServiceId;

  @override
  Widget build(BuildContext context) {
    final tAsync = ref.watch(translationProvider);
    final t = tAsync.value ?? {};
    final businessData = ref.watch(businessProvider).value;
    final clients = businessData?.clients ?? [];
    final services = businessData?.services ?? [];
    final theme = ShadTheme.of(context);

    // Filter valid clients/services
    final validClients = clients
        .where((c) => c['client'] != null && c['client']['id'] != null)
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.h3(t['business_bookings_new_title'] ?? 'Nueva Reserva'),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(ConnekIcons.close, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Selection
                  AppText.p(
                    t['business_bookings_client_label'] ?? 'Cliente',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ShadSelect<int>(
                    placeholder: Text(
                      t['business_bookings_client_hint'] ??
                          'Seleccionar Cliente',
                    ),
                    options: validClients.map((c) {
                      final name =
                          '${c['client']['first_name']} ${c['client']['last_name']}';
                      return ShadOption(
                        value: c['client']['id'] as int,
                        child: Text(name),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedClientId = val),
                    selectedOptionBuilder: (context, value) {
                      final client = validClients.firstWhere(
                        (c) => c['client']['id'] == value,
                        orElse: () => {},
                      );
                      if (client.isEmpty) return const Text('Seleccionar');
                      return Text(
                        '${client['client']['first_name']} ${client['client']['last_name']}',
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Service Selection
                  AppText.p(
                    t['business_bookings_service_label'] ?? 'Servicio',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ShadSelect<int>(
                    placeholder: Text(
                      t['business_bookings_service_hint'] ??
                          'Seleccionar Servicio',
                    ),
                    options: services.map((s) {
                      return ShadOption(
                        value: s['id'] as int,
                        child: Text(s['name'] ?? 'Servicio'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _selectedServiceId = val),
                    selectedOptionBuilder: (context, value) {
                      final service = services.firstWhere(
                        (s) => s['id'] == value,
                        orElse: () => {},
                      );
                      return Text(service['name'] ?? 'Servicio');
                    },
                  ),
                  const SizedBox(height: 20),

                  // DateTime Row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.p(
                              t['business_bookings_date_label'] ?? 'Fecha',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (date != null)
                                  setState(() => _selectedDate = date);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.colorScheme.border,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(ConnekIcons.calendar, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      _selectedDate == null
                                          ? (t['business_bookings_select'] ??
                                                'Seleccionar')
                                          : DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(_selectedDate!),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.p(
                              t['business_bookings_time_label'] ?? 'Hora',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null)
                                  setState(() => _selectedTime = time);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: theme.colorScheme.border,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(ConnekIcons.clock, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      _selectedTime == null
                                          ? (t['business_bookings_select'] ??
                                                'Seleccionar')
                                          : _selectedTime!.format(context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AppButton.primary(
            text: 'Confirmar Reserva',
            width: double.infinity,
            onPressed:
                (_selectedClientId != null &&
                    _selectedServiceId != null &&
                    _selectedDate != null &&
                    _selectedTime != null)
                ? () async {
                    final date = DateTime(
                      _selectedDate!.year,
                      _selectedDate!.month,
                      _selectedDate!.day,
                      _selectedTime!.hour,
                      _selectedTime!.minute,
                    );

                    final success = await ref
                        .read(bookingUpdateProvider)
                        .createManualBooking(
                          clientId: _selectedClientId!,
                          serviceId: _selectedServiceId!,
                          date: date,
                        );

                    if (success && context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reserva creada con éxito'),
                        ),
                      );
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
