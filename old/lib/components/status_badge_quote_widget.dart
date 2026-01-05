import '/flutter_flow/flutter_flow_util.dart';
import '/mile_stone3/components3/request_cancelled/request_cancelled_widget.dart';
import '/mile_stone3/components3/request_completed/request_completed_widget.dart';
import '/mile_stone3/components3/request_on_hold/request_on_hold_widget.dart';
import 'package:flutter/material.dart';
import 'status_badge_quote_model.dart';
export 'status_badge_quote_model.dart';

class StatusBadgeQuoteWidget extends StatefulWidget {
  const StatusBadgeQuoteWidget({
    super.key,
    required this.status,
  });

  final String? status;

  @override
  State<StatusBadgeQuoteWidget> createState() => _StatusBadgeQuoteWidgetState();
}

class _StatusBadgeQuoteWidgetState extends State<StatusBadgeQuoteWidget> {
  late StatusBadgeQuoteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatusBadgeQuoteModel());

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
          if (widget.status == 'accepted')
            wrapWithModel(
              model: _model.requestCompletedModel,
              updateCallback: () => safeSetState(() {}),
              child: const RequestCompletedWidget(
                text: 'Accepted',
              ),
            ),
          if (widget.status == 'pending')
            wrapWithModel(
              model: _model.requestOnHoldModel,
              updateCallback: () => safeSetState(() {}),
              child: const RequestOnHoldWidget(),
            ),
          if (widget.status == 'declined')
            wrapWithModel(
              model: _model.requestCancelledModel,
              updateCallback: () => safeSetState(() {}),
              child: const RequestCancelledWidget(
                text: 'Declined',
              ),
            ),
        ],
      ),
    );
  }
}
