import '/components/client_card_widget.dart';
import '/components/empty_space_top_widget.dart';
import '/components/empty_space_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/generic/content_header/content_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_clients_model.dart';
export 'business_clients_model.dart';

class BusinessClientsWidget extends StatefulWidget {
  const BusinessClientsWidget({super.key});

  @override
  State<BusinessClientsWidget> createState() => _BusinessClientsWidgetState();
}

class _BusinessClientsWidgetState extends State<BusinessClientsWidget> {
  late BusinessClientsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessClientsModel());

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
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wrapWithModel(
                model: _model.emptySpaceTopModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptySpaceTopWidget(),
              ),
              wrapWithModel(
                model: _model.contentHeaderModel,
                updateCallback: () => safeSetState(() {}),
                child: const ContentHeaderWidget(
                  title: '¡Hi, Gabriel!',
                  subtitle:
                      'See how your business is moving from the overview.',
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent1,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Warren Buffet: \"Delight your client.\"',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FontStyle.italic,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      final clients = FFAppState().businessClients.toList();

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:
                              List.generate(clients.length, (clientsIndex) {
                            final clientsItem = clients[clientsIndex];
                            return wrapWithModel(
                              model: _model.clientCardModels.getModel(
                                clientsIndex.toString(),
                                clientsIndex,
                              ),
                              updateCallback: () => safeSetState(() {}),
                              child: ClientCardWidget(
                                key: Key(
                                  'Keyf2m_${clientsIndex.toString()}',
                                ),
                                client: clientsItem,
                              ),
                            );
                          }).divide(const SizedBox(height: 15.0)),
                        ),
                      );
                    },
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.emptySpaceModel,
                updateCallback: () => safeSetState(() {}),
                child: const EmptySpaceWidget(),
              ),
            ].divide(const SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
