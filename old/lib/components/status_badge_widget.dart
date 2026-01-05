import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components3/request_cancelled/request_cancelled_widget.dart';
import '/mile_stone3/components3/request_completed/request_completed_widget.dart';
import '/mile_stone3/components3/request_on_hold/request_on_hold_widget.dart';
import 'package:flutter/material.dart';
import 'status_badge_model.dart';
export 'status_badge_model.dart';

class StatusBadgeWidget extends StatefulWidget {
  const StatusBadgeWidget({
    super.key,
    required this.status,
  });

  final String? status;

  @override
  State<StatusBadgeWidget> createState() => _StatusBadgeWidgetState();
}

class _StatusBadgeWidgetState extends State<StatusBadgeWidget> {
  late StatusBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatusBadgeModel());

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
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.status == 'completed')
            wrapWithModel(
              model: _model.requestCompletedModel,
              updateCallback: () => safeSetState(() {}),
              child: const RequestCompletedWidget(),
            ),
          if (widget.status == 'pending')
            wrapWithModel(
              model: _model.requestOnHoldModel,
              updateCallback: () => safeSetState(() {}),
              child: const RequestOnHoldWidget(),
            ),
          if (widget.status == 'cancelled')
            wrapWithModel(
              model: _model.requestCancelledModel,
              updateCallback: () => safeSetState(() {}),
              child: const RequestCancelledWidget(),
            ),
        ],
      ),
    );
  }
}
