import '/backend/supabase/supabase.dart';
import '/components/back_button_widget.dart';
import '/components/lead_card_info_page_widget.dart';
import '/components/lead_quote_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic_bars/mobile_app_bar/mobile_app_bar_widget.dart';
import '/generic_bars/mobile_nav_bar/mobile_nav_bar_widget.dart';
import '/index.dart';
import 'business_lead_detail_widget.dart' show BusinessLeadDetailWidget;
import 'package:flutter/material.dart';

class BusinessLeadDetailModel
    extends FlutterFlowModel<BusinessLeadDetailWidget> {
  ///  Local state fields for this page.

  String pageSelected = 'overview';

  String leadsFilter = 'all';

  List<int> stepsLead = [0];
  void addToStepsLead(int item) => stepsLead.add(item);
  void removeFromStepsLead(int item) => stepsLead.remove(item);
  void removeAtIndexFromStepsLead(int index) => stepsLead.removeAt(index);
  void insertAtIndexInStepsLead(int index, int item) =>
      stepsLead.insert(index, item);
  void updateStepsLeadAtIndex(int index, Function(int) updateFn) =>
      stepsLead[index] = updateFn(stepsLead[index]);

  QuoteRow? quoteData;

  BookingsRow? booking;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in BusinessLeadDetail widget.
  List<QuoteRow>? quoteDataOutput;
  // Model for mobileAppBar component.
  late MobileAppBarModel mobileAppBarModel;
  // Model for backButton component.
  late BackButtonModel backButtonModel;
  // Model for LeadCardInfoPage component.
  late LeadCardInfoPageModel leadCardInfoPageModel;
  // Model for LeadQuote component.
  late LeadQuoteModel leadQuoteModel;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<LeadsRow>? leadDeletion;
  // Model for mobileNavBar component.
  late MobileNavBarModel mobileNavBarModel;

  @override
  void initState(BuildContext context) {
    mobileAppBarModel = createModel(context, () => MobileAppBarModel());
    backButtonModel = createModel(context, () => BackButtonModel());
    leadCardInfoPageModel = createModel(context, () => LeadCardInfoPageModel());
    leadQuoteModel = createModel(context, () => LeadQuoteModel());
    mobileNavBarModel = createModel(context, () => MobileNavBarModel());
  }

  @override
  void dispose() {
    mobileAppBarModel.dispose();
    backButtonModel.dispose();
    leadCardInfoPageModel.dispose();
    leadQuoteModel.dispose();
    mobileNavBarModel.dispose();
  }
}
