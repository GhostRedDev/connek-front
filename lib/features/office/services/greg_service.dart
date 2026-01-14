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

      debugPrint('📡 GregService: GET Greg response: $response');

      if (response == null || response['success'] != true) {
        debugPrint('⚠️ GregService: API returned failure or null');
        return null;
      }

      final data = response['data'];
      if (data == null) {
        debugPrint('⚠️ GregService: Data field is null');
        return null;
      }

      debugPrint('📦 GregService: Mapping GregModel from raw data: $data');
      final model = GregModel.fromJson(data);
      // Explicitly set/override businessId to ensure it's preserved
      return model.copyWith(businessId: businessId);
    } catch (e) {
      debugPrint('❌ GregService: Error fetching Greg: $e');
      return null;
    }
  }

  Future<void> updateGreg(GregModel greg) async {
    debugPrint(
      '📡 GregService: Updating Greg settings for business ${greg.businessId}',
    );
    try {
      final String refundPolicy = greg.refundPolicy.isEmpty
          ? 'no_refund'
          : greg.refundPolicy;

      final Map<String, dynamic> fields = {
        'cancellations': greg.cancellations,
        'allow_rescheduling': greg.allowRescheduling,
        'cancellation_motive': greg.cancellationMotive,
        'procedures':
            greg.procedures, // raw list for form array (expects array)
        'procedures_details': greg.proceduresDetails ?? '',
        'post_booking_procedures': greg.postBookingProcedures ?? '',
        'privacy_policy': greg.privacyPolicy,
        'payment_policy': greg.paymentPolicy,
        'accepted_payment_methods':
            greg.acceptedPaymentMethods, // raw list (OpenAPI type: array)
        'require_payment_proof': greg.requirePaymentProof,
        'refund_policy': refundPolicy,
        'refund_policy_details': greg.refundPolicyDetails ?? '',
        'escalation_time_minutes': greg.escalationTimeMinutes,
        'cancellation_documents':
            greg.cancellationDocuments, // raw list (DB expects array)
        'blacklist': jsonEncode(
          greg.blacklist,
        ), // jsonb type, needs stringified array
        'excluded_phones': jsonEncode(greg.excludedPhones), // One string
        'library': jsonEncode(greg.library), // One string
        'conversation_tone': greg.conversationTone,
        'notifications': greg.notifications,
        'active': greg.active,
        'save_information': greg.saveInformation,
        'ask_for_consent': greg.askForConsent,
        'information_not_to_share': greg.informationNotToShare ?? '',
        'custom_policies':
            greg.customPolicies?.map((e) => jsonEncode(e)).toList() ?? [],
      };

      final response = await _apiService.putUrlEncoded(
        '/employees/greg/business/${greg.businessId}',
        fields,
      );
      debugPrint('📥 GregService: Update response: $response');
      debugPrint('✅ GregService: Greg settings updated successfully');
    } catch (e) {
      debugPrint('❌ GregService: Error updating Greg via API: $e');
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
      debugPrint('❌ Error updating Greg cancellations via API: $e');
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
      debugPrint('❌ Error updating Greg privacy via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Procedures (Form Data)
  Future<void> updateGregProcedures(GregModel greg) async {
    try {
      final Map<String, dynamic> fields = {
        'procedures': greg.procedures, // raw list for form array
        'procedures_details': greg.proceduresDetails ?? '',
        'post_booking_procedures': greg.postBookingProcedures ?? '',
        'cancellation_documents': jsonEncode(greg.cancellationDocuments),
      };

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      debugPrint('❌ Error updating Greg procedures via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Payments (Form Data)
  Future<void> updateGregPayments(GregModel greg) async {
    try {
      final String refundPolicy = greg.refundPolicy.isEmpty
          ? 'no_refund'
          : greg.refundPolicy;
      final Map<String, dynamic> fields = {
        'payment_policy': greg.paymentPolicy,
        'require_payment_proof': greg.requirePaymentProof,
        'refund_policy': refundPolicy,
        'refund_policy_details': greg.refundPolicyDetails ?? '',
        'accepted_payment_methods':
            greg.acceptedPaymentMethods, // raw list for form array
      };

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      debugPrint('❌ Error updating Greg payments via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Document Library (Form Data)
  Future<void> updateGregLibrary(GregModel greg) async {
    try {
      final Map<String, dynamic> fields = {'library': jsonEncode(greg.library)};

      await _apiService.putForm(
        '/employees/greg/business/${greg.id}',
        fields: fields,
      );
    } catch (e) {
      print('Error updating Greg library via Form API: $e');
      rethrow;
    }
  }

  // Activate Greg (Atomic endpoint)
  Future<GregModel?> activateGreg(int businessId) async {
    debugPrint('📡 GregService: ACTIVATE Greg for business $businessId');
    try {
      final response = await _apiService.put(
        '/employees/greg/business/$businessId/activate',
        body: {},
      );

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        return GregModel.fromJson(
          response['data'],
        ).copyWith(businessId: businessId);
      }
      return null;
    } catch (e) {
      debugPrint('❌ GregService: Error activating Greg: $e');
      rethrow;
    }
  }

  // Deactivate Greg (Atomic endpoint)
  Future<GregModel?> deactivateGreg(int businessId) async {
    debugPrint('📡 GregService: DEACTIVATE Greg for business $businessId');
    try {
      final response = await _apiService.put(
        '/employees/greg/business/$businessId/deactivate',
        body: {},
      );

      if (response != null &&
          response['success'] == true &&
          response['data'] != null) {
        return GregModel.fromJson(
          response['data'],
        ).copyWith(businessId: businessId);
      }
      return null;
    } catch (e) {
      debugPrint('❌ GregService: Error deactivating Greg: $e');
      rethrow;
    }
  }
}
