import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'empty_space_model.dart';
export 'empty_space_model.dart';

class EmptySpaceWidget extends StatefulWidget {
  const EmptySpaceWidget({
    super.key,
    int? heightPx,
  }) : heightPx = heightPx ?? 90;

  final int heightPx;

  @override
  State<EmptySpaceWidget> createState() => _EmptySpaceWidgetState();
}

class _EmptySpaceWidgetState extends State<EmptySpaceWidget> {
  late EmptySpaceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptySpaceModel());

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
