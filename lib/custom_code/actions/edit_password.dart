// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

Future<bool> editPassword(String oldPassword, String newPassword) async {
  bool isVerified = await verifyPassword(oldPassword);
  if (isVerified) {
    String updateResult = await updatePassword(newPassword);
    if (updateResult.contains('successfully')) {
      // Password updated successfully
      return true;
    } else {
      // Update failed
      print(updateResult);
      return false;
    }
  } else {
    // Verification failed
    return false;
  }
}
