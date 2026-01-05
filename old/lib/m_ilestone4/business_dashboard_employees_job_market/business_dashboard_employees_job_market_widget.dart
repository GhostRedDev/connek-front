import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/employee_hire_web/employee_hire_web_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'business_dashboard_employees_job_market_model.dart';
export 'business_dashboard_employees_job_market_model.dart';

class BusinessDashboardEmployeesJobMarketWidget extends StatefulWidget {
  const BusinessDashboardEmployeesJobMarketWidget({super.key});

  @override
  State<BusinessDashboardEmployeesJobMarketWidget> createState() =>
      _BusinessDashboardEmployeesJobMarketWidgetState();
}

class _BusinessDashboardEmployeesJobMarketWidgetState
    extends State<BusinessDashboardEmployeesJobMarketWidget> {
  late BusinessDashboardEmployeesJobMarketModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model =
        createModel(context, () => BusinessDashboardEmployeesJobMarketModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Job Market',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primary,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w800,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                ),
              ],
            ),
            Align(
              alignment: const AlignmentDirectional(-1.0, 0.0),
              child: FutureBuilder<List<EmployeesRow>>(
                future: EmployeesTable().queryRows(
                  queryFn: (q) => q,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: SpinKitRipple(
                          color: FlutterFlowTheme.of(context).primary,
                          size: 50.0,
                        ),
                      ),
                    );
                  }
                  List<EmployeesRow> wrapEmployeesRowList = snapshot.data!;

                  return Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children:
                        List.generate(wrapEmployeesRowList.length, (wrapIndex) {
                      final wrapEmployeesRow = wrapEmployeesRowList[wrapIndex];
                      return Container(
                        width: 380.0,
                        height: 450.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryAlpha30,
                        ),
                        child: EmployeeHireWebWidget(
                          key: Key(
                              'Keyi7o_${wrapIndex}_of_${wrapEmployeesRowList.length}'),
                          id: wrapEmployeesRow.id.toString(),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ].divide(const SizedBox(height: 5.0)),
        ),
      ),
    );
  }
}
