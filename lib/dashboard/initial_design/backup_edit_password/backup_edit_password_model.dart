import '/flutter_flow/flutter_flow_util.dart';
import '/utils/components/connectivity/connectivity_widget.dart';
import 'backup_edit_password_widget.dart' show BackupEditPasswordWidget;
import 'package:flutter/material.dart';

class BackupEditPasswordModel
    extends FlutterFlowModel<BackupEditPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Model for connectivity component.
  late ConnectivityModel connectivityModel;
  // State field(s) for old_password widget.
  FocusNode? oldPasswordFocusNode;
  TextEditingController? oldPasswordTextController;
  late bool oldPasswordVisibility;
  String? Function(BuildContext, String?)? oldPasswordTextControllerValidator;
  // State field(s) for new_password widget.
  FocusNode? newPasswordFocusNode;
  TextEditingController? newPasswordTextController;
  late bool newPasswordVisibility;
  String? Function(BuildContext, String?)? newPasswordTextControllerValidator;
  // State field(s) for confirm_new_password widget.
  FocusNode? confirmNewPasswordFocusNode;
  TextEditingController? confirmNewPasswordTextController;
  late bool confirmNewPasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmNewPasswordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    connectivityModel = createModel(context, () => ConnectivityModel());
    oldPasswordVisibility = false;
    newPasswordVisibility = false;
    confirmNewPasswordVisibility = false;
  }

  @override
  void dispose() {
    connectivityModel.dispose();
    oldPasswordFocusNode?.dispose();
    oldPasswordTextController?.dispose();

    newPasswordFocusNode?.dispose();
    newPasswordTextController?.dispose();

    confirmNewPasswordFocusNode?.dispose();
    confirmNewPasswordTextController?.dispose();
  }
}
