import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../../core/models/greg_model.dart';
import '../../../core/services/api_service.dart';

class GregService {
  final ApiService _apiService;

  GregService(this._apiService);

  // Fetch Greg configuration for a specific business
  Future<GregModel?> getGregByBusinessId(int businessId) async {
    try {
      debugPrint('📡 GregService: GET Greg for business $businessId');
      final response = await _apiService.get(
        '/employees/greg/business/$businessId',
      );

      if (response == null || response['success'] != true) {
        debugPrint('⚠️ GregService: API returned failure or null');
        return null;
      }

      final data = response['data'];
      if (data == null) {
        debugPrint('⚠️ GregService: Data field is null');
        return null;
      }

      debugPrint('📦 GregService: Mapping GregModel from data...');
      return GregModel.fromJson(data);
    } catch (e) {
      debugPrint('❌ GregService: Error fetching Greg: $e');
      return null;
    }
  }

  // Update Greg configuration (Generic JSON update if supported)
  Future<void> updateGreg(GregModel greg) async {
    try {
      await _apiService.put(
        '/employees/greg/business/${greg.id}',
        body: greg.toJson(),
      );
    } catch (e) {
      print('Error updating Greg via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Cancellations (Form Data)
  Future<void> updateGregCancellations(GregModel greg) async {
    try {
      final fields = {
        'cancellations': greg.cancellations,
        'allow_rescheduling': greg.allowRescheduling.toString(),
        'cancellation_motive': greg.cancellationMotive.toString(),
        'escalation_time_minutes': greg.escalationTimeMinutes.toString(),
        'cancellation_documents': jsonEncode(greg.cancellationDocuments),
      };

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      print('Error updating Greg cancellations via Form API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Privacy and Excluded Contacts (Form Data)
  Future<void> updateGregPrivacy(GregModel greg) async {
    try {
      final fields = {
        'privacy_policy': greg.privacyPolicy,
        'blacklist': jsonEncode(greg.excludedPhones),
        'save_information': greg.saveInformation,
        'ask_for_consent': greg.askForConsent.toString(),
        'information_not_to_share': greg.informationNotToShare ?? '',
      };

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      print('Error updating Greg privacy via Form API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Procedures (Form Data)
  Future<void> updateGregProcedures(GregModel greg) async {
    try {
      final fields = {
        'procedures': jsonEncode(greg.procedures),
        'procedures_details': greg.proceduresDetails ?? '',
        'post_booking_procedures': greg.postBookingProcedures ?? '',
        'cancellation_documents': jsonEncode(greg.cancellationDocuments),
      };

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      print('Error updating Greg procedures via Form API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Payments (Form Data)
  Future<void> updateGregPayments(GregModel greg) async {
    try {
      // Mapping UI labels to backend Enums
      final paymentMap = {
        'Connek Wallet': 'connek_wallet',
        'Card': 'card',
        'Bank Transfer': 'bank_transfer',
        'Cash': 'cash',
      };

      final refundMap = {
        'No Refund': 'no_refund',
        'Full Refund': 'full_refund',
        'Custom Refund': 'custom_refund',
      };

      final mappedPaymentMethods = greg.acceptedPaymentMethods
          .map((m) => paymentMap[m] ?? m.toLowerCase().replaceAll(' ', '_'))
          .toList();

      final mappedRefundPolicy = refundMap[greg.refundPolicy] ?? 'no_refund';

      final fields = {
        'payment_policy': greg.paymentPolicy,
        'require_payment_proof': greg.requirePaymentProof.toString(),
        'refund_policy': mappedRefundPolicy,
        'refund_policy_details': greg.refundPolicyDetails ?? '',
        'accepted_payment_methods': jsonEncode(mappedPaymentMethods),
      };

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      print('Error updating Greg payments via Form API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Document Library (Form Data)
  Future<void> updateGregLibrary(GregModel greg) async {
    try {
      final fields = {
        // The brief says "library" must be a JSON string.
        'library': jsonEncode(greg.library),
      };

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      print('Error updating Greg library via Form API: $e');
      rethrow;
    }
  }
}
