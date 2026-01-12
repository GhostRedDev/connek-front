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
      final model = GregModel.fromJson(data);
      // Explicitly set/override businessId to ensure it's preserved
      return model.copyWith(businessId: businessId);
    } catch (e) {
      debugPrint('❌ GregService: Error fetching Greg: $e');
      return null;
    }
  }

  // Update Greg configuration (Generic JSON update if supported)
  Future<void> updateGreg(GregModel greg) async {
    try {
      final Map<String, dynamic> fields = {
        'cancellations': greg.cancellations,
        'allow_rescheduling': greg.allowRescheduling,
        'cancellation_motive': greg.cancellationMotive,
        'procedures': jsonEncode(greg.procedures),
        'procedures_details': greg.proceduresDetails ?? '',
        'post_booking_procedures': greg.postBookingProcedures ?? '',
        'privacy_policy': greg.privacyPolicy,
        'payment_policy': greg.paymentPolicy,
        'accepted_payment_methods': jsonEncode(greg.acceptedPaymentMethods),
        'require_payment_proof': greg.requirePaymentProof,
        'refund_policy': greg.refundPolicy,
        'refund_policy_details': greg.refundPolicyDetails ?? '',
        'escalation_time_minutes': greg.escalationTimeMinutes,
        'cancellation_documents': jsonEncode(greg.cancellationDocuments),
        'blacklist': jsonEncode(greg.blacklist),
        'excluded_phones': jsonEncode(greg.excludedPhones),
        'library': jsonEncode(greg.library),
        'conversation_tone': greg.conversationTone,
        'notifications': greg.notifications,
        'active': greg.active,
        'save_information': greg.saveInformation,
        'ask_for_consent': greg.askForConsent,
        'information_not_to_share': greg.informationNotToShare ?? '',
      };

      await _apiService.putUrlEncoded(
        '/employees/greg/business/${greg.businessId}',
        fields,
      );
    } catch (e) {
      print('Error updating Greg via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Cancellations (Form Data)
  Future<void> updateGregCancellations(GregModel greg) async {
    debugPrint(
      '💾 GregService: updateGregCancellations for businessId: ${greg.businessId}',
    );
    try {
      final Map<String, dynamic> fields = {
        'cancellations': greg.cancellations,
        'allow_rescheduling': greg.allowRescheduling,
        'cancellation_motive': greg.cancellationMotive,
        'escalation_time_minutes': greg.escalationTimeMinutes,
        'cancellation_documents': jsonEncode(greg.cancellationDocuments),
      };

      await _apiService.putUrlEncoded(
        '/employees/greg/business/${greg.businessId}',
        fields,
      );
    } catch (e) {
      print('Error updating Greg cancellations via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Privacy and Excluded Contacts (Form Data)
  Future<void> updateGregPrivacy(GregModel greg) async {
    debugPrint(
      '💾 GregService: updateGregPrivacy for businessId: ${greg.businessId}',
    );
    try {
      final Map<String, dynamic> fields = {
        'privacy_policy': greg.privacyPolicy,
        'save_information': greg.saveInformation,
        'ask_for_consent': greg.askForConsent,
        'information_not_to_share': greg.informationNotToShare ?? '',
        'excluded_phones': jsonEncode(greg.excludedPhones),
        'blacklist': jsonEncode(greg.blacklist),
      };

      await _apiService.putUrlEncoded(
        '/employees/greg/business/${greg.businessId}',
        fields,
      );
    } catch (e) {
      print('Error updating Greg privacy via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Procedures (Form Data)
  Future<void> updateGregProcedures(GregModel greg) async {
    debugPrint(
      '💾 GregService: updateGregProcedures for businessId: ${greg.businessId}',
    );
    try {
      final Map<String, dynamic> fields = {
        'procedures': jsonEncode(greg.procedures),
        'procedures_details': greg.proceduresDetails ?? '',
        'post_booking_procedures': greg.postBookingProcedures ?? '',
        'cancellation_documents': jsonEncode(greg.cancellationDocuments),
      };

      await _apiService.putUrlEncoded(
        '/employees/greg/business/${greg.businessId}',
        fields,
      );
    } catch (e) {
      print('Error updating Greg procedures via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Payments (Form Data)
  Future<void> updateGregPayments(GregModel greg) async {
    debugPrint(
      '💾 GregService: updateGregPayments for businessId: ${greg.businessId}',
    );
    try {
      final Map<String, dynamic> fields = {
        'payment_policy': greg.paymentPolicy,
        'require_payment_proof': greg.requirePaymentProof,
        'refund_policy': greg.refundPolicy,
        'refund_policy_details': greg.refundPolicyDetails ?? '',
        'accepted_payment_methods': jsonEncode(greg.acceptedPaymentMethods),
      };

      await _apiService.putUrlEncoded(
        '/employees/greg/business/${greg.businessId}',
        fields,
      );
    } catch (e) {
      print('Error updating Greg payments via API: $e');
      rethrow;
    }
  }

  // Update specifically Greg Document Library (Form Data)
  Future<void> updateGregLibrary(GregModel greg) async {
    debugPrint(
      '💾 GregService: updateGregLibrary for businessId: ${greg.businessId}',
    );
    try {
      final Map<String, dynamic> fields = {
        // The brief says "library" must be a JSON string.
        'library': jsonEncode(greg.library),
      };

      await _apiService.putUrlEncoded(
        '/employees/greg/business/${greg.businessId}',
        fields,
      );
    } catch (e) {
      print('Error updating Greg library via API: $e');
      rethrow;
    }
  }
}
