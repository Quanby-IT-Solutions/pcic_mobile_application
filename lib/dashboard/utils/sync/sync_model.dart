import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sync_widget.dart' show SyncWidget;
import 'package:flutter/material.dart';

class SyncModel extends FlutterFlowModel<SyncWidget> {
  ///  Local state fields for this page.

  int? limit = 0;

  int? iteration = 0;

  bool isSync = false;

  bool startSync = false;

  bool isSynced = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (Retrieve Region Code by Region ID)] action in Container widget.
  List<RetrieveRegionCodeByRegionIDRow>? regionCode;
  // Stores action output result for [Custom Action - syncFromFTP] action in Container widget.
  bool? isSyced;
  // Stores action output result for [Custom Action - syncOnlineTaskAndPpirToOffline] action in Container widget.
  String? syncMessage;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
