import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'switch_booking_model.dart';
export 'switch_booking_model.dart';

class SwitchBookingWidget extends StatefulWidget {
  const SwitchBookingWidget({
    super.key,
    bool? parameter1,
    required this.changue,
  }) : parameter1 = parameter1 ?? false;

  final bool parameter1;
  final Future Function()? changue;

  @override
  State<SwitchBookingWidget> createState() => _SwitchBookingWidgetState();
}

class _SwitchBookingWidgetState extends State<SwitchBookingWidget> {
  late SwitchBookingModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SwitchBookingModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(-1.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          await widget.changue?.call();
        },
        child: Container(
          width: 60.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: valueOrDefault<Color>(
              widget.parameter1 == true
                  ? const Color(0x3300D73B)
                  : FlutterFlowTheme.of(context).customColor45,
              FlutterFlowTheme.of(context).customColor45,
            ),
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: valueOrDefault<Color>(
                widget.parameter1 == true
                    ? const Color(0x3300D73B)
                    : FlutterFlowTheme.of(context).customColor45,
                FlutterFlowTheme.of(context).customColor45,
              ),
              width: 1.0,
            ),
          ),
          child: Align(
            alignment: AlignmentDirectional(
                valueOrDefault<double>(
                  widget.parameter1 == true ? 1.0 : -1.0,
                  0.0,
                ),
                0.0),
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: valueOrDefault<Color>(
                  widget.parameter1 == true ? const Color(0xFF00D73B) : Colors.white,
                  FlutterFlowTheme.of(context).customColor45,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0x00F8EEEE),
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
