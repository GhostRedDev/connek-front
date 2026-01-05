import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/empty_leads/empty_leads_widget.dart';
import '/m4_new/components/mouse_leads_search2/mouse_leads_search2_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'business_leads_search_mobile_model.dart';
export 'business_leads_search_mobile_model.dart';

class BusinessLeadsSearchMobileWidget extends StatefulWidget {
  const BusinessLeadsSearchMobileWidget({super.key});

  @override
  State<BusinessLeadsSearchMobileWidget> createState() =>
      _BusinessLeadsSearchMobileWidgetState();
}

class _BusinessLeadsSearchMobileWidgetState
    extends State<BusinessLeadsSearchMobileWidget> {
  late BusinessLeadsSearchMobileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessLeadsSearchMobileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.transparent,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(),
              child: Builder(
                builder: (context) {
                  final leads = (_model.filter == 'all'
                          ? FFAppState().businessLeads
                          : FFAppState()
                              .businessLeads
                              .where((e) => e.status == _model.filter)
                              .toList())
                      .toList();
                  if (leads.isEmpty) {
                    return const EmptyLeadsWidget();
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(leads.length, (leadsIndex) {
                      final leadsItem = leads[leadsIndex];
                      return Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: wrapWithModel(
                            model: _model.mouseLeadsSearch02Models.getModel(
                              leadsIndex.toString(),
                              leadsIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: MouseLeadsSearch2Widget(
                              key: Key(
                                'Keyxtv_${leadsIndex.toString()}',
                              ),
                              lead: leadsItem,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
