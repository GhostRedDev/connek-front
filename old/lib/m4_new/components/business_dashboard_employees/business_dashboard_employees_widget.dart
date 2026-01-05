import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/m4_new/components/employee_card/employee_card_widget.dart';
import 'package:flutter/material.dart';
import 'business_dashboard_employees_model.dart';
export 'business_dashboard_employees_model.dart';

class BusinessDashboardEmployeesWidget extends StatefulWidget {
  const BusinessDashboardEmployeesWidget({super.key});

  @override
  State<BusinessDashboardEmployeesWidget> createState() =>
      _BusinessDashboardEmployeesWidgetState();
}

class _BusinessDashboardEmployeesWidgetState
    extends State<BusinessDashboardEmployeesWidget> {
  late BusinessDashboardEmployeesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessDashboardEmployeesModel());

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
      constraints: const BoxConstraints(
        maxHeight: 435.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? (() {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return true;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return true;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return true;
                } else {
                  return false;
                }
              }()
                ? Colors.transparent
                : const Color(0x66EEEEEE))
            : const Color(0x004F87C9),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: () {
            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
              return false;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
              return false;
            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
              return false;
            } else {
              return true;
            }
          }()
              ? FlutterFlowTheme.of(context).green400
              : Colors.transparent,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
            valueOrDefault<double>(
              () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return false;
                } else {
                  return true;
                }
              }()
                  ? 10.0
                  : 0.0,
              0.0,
            ),
            10.0,
            valueOrDefault<double>(
              () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return false;
                } else {
                  return true;
                }
              }()
                  ? 10.0
                  : 0.0,
              0.0,
            ),
            valueOrDefault<double>(
              () {
                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointMedium) {
                  return false;
                } else if (MediaQuery.sizeOf(context).width <
                    kBreakpointLarge) {
                  return false;
                } else {
                  return true;
                }
              }()
                  ? 10.0
                  : 0.0,
              0.0,
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    valueOrDefault<double>(
                      () {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointMedium) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointLarge) {
                          return true;
                        } else {
                          return false;
                        }
                      }()
                          ? 10.0
                          : 0.0,
                      0.0,
                    ),
                    valueOrDefault<double>(
                      () {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointMedium) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointLarge) {
                          return true;
                        } else {
                          return false;
                        }
                      }()
                          ? 10.0
                          : 0.0,
                      0.0,
                    ),
                    valueOrDefault<double>(
                      () {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointMedium) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointLarge) {
                          return true;
                        } else {
                          return false;
                        }
                      }()
                          ? 10.0
                          : 0.0,
                      0.0,
                    ),
                    valueOrDefault<double>(
                      () {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointMedium) {
                          return true;
                        } else if (MediaQuery.sizeOf(context).width <
                            kBreakpointLarge) {
                          return true;
                        } else {
                          return false;
                        }
                      }()
                          ? 10.0
                          : 0.0,
                      0.0,
                    )),
                child: Wrap(
                  spacing: 15.0,
                  runSpacing: 15.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: [
                    wrapWithModel(
                      model: _model.employeeCardModel,
                      updateCallback: () => safeSetState(() {}),
                      child: const EmployeeCardWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ].divide(const SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
