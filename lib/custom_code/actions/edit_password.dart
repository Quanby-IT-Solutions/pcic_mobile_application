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

Future<bool> editPassword(String oldPassword, String newPassword) async {
  // First, verify the old password
  bool isOldPasswordCorrect = await verifyPassword(oldPassword);

  if (!isOldPasswordCorrect) {
    print('Old password is incorrect');
    return false;
  }

  // If old password is correct, proceed to update the password
  try {
    final user = SupaFlow.client.auth.currentUser;
    if (user == null) {
      print('User is not authenticated');
      return false;
    }

    final response = await SupaFlow.client.auth.updateUser(
      UserAttributes(
        password: newPassword,
      ),
    );

    if (response.user != null) {
      print('Password updated successfully');
      return true;
    } else {
      print('Update failed: Unknown error');
      return false;
    }
  } catch (e) {
    print('Error updating password: $e');
    return false;
  }
}
