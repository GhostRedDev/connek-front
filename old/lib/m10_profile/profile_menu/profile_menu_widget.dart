import '/backend/schema/enums/enums.dart';
import '/components/top_menu_option_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_menu_model.dart';
export 'profile_menu_model.dart';

class ProfileMenuWidget extends StatefulWidget {
  const ProfileMenuWidget({super.key});

  @override
  State<ProfileMenuWidget> createState() => _ProfileMenuWidgetState();
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> {
  late ProfileMenuModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileMenuModel());

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
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  wrapWithModel(
                    model: _model.profileModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().profilePage == ProfilePages.profile,
                      icon: Icon(
                        Icons.person,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      name: 'Profile',
                      tapAction: () async {
                        FFAppState().profilePage = ProfilePages.profile;
                        _model.updatePage(() {});
                      },
                    ),
                  ),
                  wrapWithModel(
                    model: _model.mediaModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().profilePage == ProfilePages.media,
                      icon: Icon(
                        Icons.photo,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      name: 'Media',
                      tapAction: () async {
                        FFAppState().profilePage = ProfilePages.media;
                        _model.updatePage(() {});
                      },
                    ),
                  ),
                  if (FFAppState().account.isBusiness)
                    wrapWithModel(
                      model: _model.reviewsModel,
                      updateCallback: () => safeSetState(() {}),
                      child: TopMenuOptionWidget(
                        active:
                            FFAppState().profilePage == ProfilePages.reviews,
                        icon: Icon(
                          Icons.star,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        name: 'Reviews',
                        tapAction: () async {
                          FFAppState().profilePage = ProfilePages.reviews;
                          _model.updatePage(() {});
                        },
                      ),
                    ),
                  wrapWithModel(
                    model: _model.settingsModel,
                    updateCallback: () => safeSetState(() {}),
                    child: TopMenuOptionWidget(
                      active: FFAppState().profilePage == ProfilePages.settings,
                      icon: Icon(
                        Icons.settings,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      name: 'Settings',
                      tapAction: () async {
                        FFAppState().profilePage = ProfilePages.settings;
                        _model.updatePage(() {});
                      },
                    ),
                  ),
                ]
                    .addToStart(const SizedBox(width: 10.0))
                    .addToEnd(const SizedBox(width: 10.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
