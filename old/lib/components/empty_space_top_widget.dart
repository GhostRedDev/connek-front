import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'empty_space_top_model.dart';
export 'empty_space_top_model.dart';

class EmptySpaceTopWidget extends StatefulWidget {
  const EmptySpaceTopWidget({
    super.key,
    int? heightPx,
  }) : heightPx = heightPx ?? 140;

  final int heightPx;

  @override
  State<EmptySpaceTopWidget> createState() => _EmptySpaceTopWidgetState();
}

class _EmptySpaceTopWidgetState extends State<EmptySpaceTopWidget> {
  late EmptySpaceTopModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptySpaceTopModel());

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
      width: double.infinity,
      height: widget.heightPx.toDouble(),
      decoration: const BoxDecoration(),
    );
  }
}
