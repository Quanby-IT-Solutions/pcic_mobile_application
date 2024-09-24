import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/utils/components/chat_list_container/chat_list_container_widget.dart';
import '/utils/components/connectivity/connectivity_widget.dart';
import '/utils/components/user_chats/user_chats_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'chats_model.dart';
export 'chats_model.dart';

class ChatsWidget extends StatefulWidget {
  const ChatsWidget({super.key});

  @override
  State<ChatsWidget> createState() => _ChatsWidgetState();
}

class _ChatsWidgetState extends State<ChatsWidget> {
  late ChatsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.updateUserLogs(
        context,
      );
      _model.messageQuery = await ChatsTable().queryRows(
        queryFn: (q) => q,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).alternate,
          floatingActionButton: Visibility(
            visible: FFAppState().ONLINE,
            child: FloatingActionButton.extended(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.5,
                          child: const UserChatsWidget(),
                        ),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              backgroundColor: FlutterFlowTheme.of(context).accent1,
              elevation: 8.0,
              label: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.edit_rounded,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'ks6c14gr' /* Compose */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).info,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ].divide(const SizedBox(width: 10.0)),
              ),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).accent1,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.message_rounded,
                                      color: FlutterFlowTheme.of(context).info,
                                      size: 30.0,
                                    ),
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: Text(
                                        FFLocalizations.of(context).getText(
                                          'pue7zwxs' /* Messages */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .headlineMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              fontSize: 28.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 20.0)),
                                ),
                              ),
                            ),
                            wrapWithModel(
                              model: _model.connectivityModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const ConnectivityWidget(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Stack(
                      children: [
                        if (FFAppState().ONLINE)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20.0, 20.0, 20.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '0ovitz68' /* Conversations */,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 15,
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 15.0, 0.0, 0.0),
                                        child: Container(
                                          decoration: const BoxDecoration(),
                                          child: FutureBuilder<ApiCallResponse>(
                                            future: (_model
                                                        .apiRequestCompleter ??=
                                                    Completer<ApiCallResponse>()
                                                      ..complete(
                                                          GetUserLastConversationsCall
                                                              .call(
                                                        pUserId: currentUserUid,
                                                      )))
                                                .future,
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return Center(
                                                  child: SizedBox(
                                                    width: 100.0,
                                                    height: 100.0,
                                                    child: SpinKitRipple(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      size: 100.0,
                                                    ),
                                                  ),
                                                );
                                              }
                                              final listViewGetUserLastConversationsResponse =
                                                  snapshot.data!;

                                              return RefreshIndicator(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                strokeWidth: 2.0,
                                                onRefresh: () async {
                                                  safeSetState(() => _model
                                                          .apiRequestCompleter =
                                                      null);
                                                  await _model
                                                      .waitForApiRequestCompleted();
                                                },
                                                child: ListView(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 20.0),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  children: [
                                                    wrapWithModel(
                                                      model: _model
                                                          .chatListContainerModel,
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          ChatListContainerWidget(
                                                        chatId:
                                                            GetUserLastConversationsCall
                                                                    .chatId(
                                                          listViewGetUserLastConversationsResponse
                                                              .jsonBody,
                                                        )!
                                                                .first,
                                                        userId: currentUserUid,
                                                      ),
                                                    ),
                                                  ].divide(
                                                      const SizedBox(height: 20.0)),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (!FFAppState().ONLINE)
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'i2p6e78d' /* You are offline. */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
