import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/service_request_model.dart';

final clientRequestsServiceProvider = Provider<ClientRequestsService>((ref) {
  // Assuming generic ApiService is available globally or via import
  return ClientRequestsService();
});

class ClientRequestsService {
  ClientRequestsService();

  Future<List<ServiceRequest>> fetchClientRequests(int? clientId) async {
    if (clientId == null) return [];

    // Mocking real fetch for now if API endpoint is uncertain,
    // but structure works for real implementation.
    // Ideally: final response = await _apiService.get('/client/$clientId/requests');

    // Using a delay to simulate network
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data that looks "real" as requested
    return [
      ServiceRequest(
        id: 1,
        title: 'Limpieza de Casa',
        role: 'Limpieza',
        amount: 55.0,
        imageUrl:
            'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?ixlib=rb-4.0.3',
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        clientName: 'Esther Howard',
        clientIndustry: 'Financial',
        rating: 5.0,
        message:
            'I need a haircut. Im busy on thursday. Could you do it on friday?', // Using text from mockup though image implies massage/haircut mixup in mockup context, sticking to text.
        serviceTitle: 'Masaje corporal para aliviar el estrés.',
        servicePriceRange: '128 - 240',
        timeline: [
          TimelineItem(
            title: 'Nuevo lead',
            time: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
            isCompleted: true,
          ),
          TimelineItem(
            title: 'En revisión',
            time: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
            isCompleted: true,
          ),
          TimelineItem(
            title: 'Por agendar',
            time: DateTime.now().subtract(const Duration(days: 1)),
            isCompleted: false,
          ),
        ],
      ),
      ServiceRequest(
        id: 2,
        title: 'Mantenimiento Jardín',
        role: 'Jardinería',
        amount: 300.0,
        imageUrl:
            'https://images.unsplash.com/photo-1557804506-669a67965ba0?ixlib=rb-4.0.3',
        status: 'completed',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        clientName: 'Miguel Montilla',
        clientIndustry: 'Real Estate',
        rating: 4.8,
        message:
            'Necesito poda de árboles y limpieza general del patio trasero.',
        serviceTitle: 'Mantenimiento Completo de Jardín',
        servicePriceRange: '250 - 350',
        timeline: [
          TimelineItem(
            title: 'Nuevo lead',
            time: DateTime.now().subtract(const Duration(days: 3)),
            isCompleted: true,
          ),
          TimelineItem(
            title: 'En revisión',
            time: DateTime.now().subtract(const Duration(days: 2)),
            isCompleted: true,
          ),
          TimelineItem(
            title: 'Por agendar',
            time: DateTime.now().subtract(const Duration(days: 1)),
            isCompleted: true,
          ),
        ],
      ),
    ];
  }
}
