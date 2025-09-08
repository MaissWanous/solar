import 'package:udemy_flutter/models/reset_password_model.dart';
 import 'package:udemy_flutter/services/reset_password_api.dart';

class ResetPasswordController {
  final ResetPasswordApi api = ResetPasswordApi();

  Future<ResetPasswordResponse> changePassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) {
    return api.resetPassword(
        oldPassword: oldPassword, newPassword: newPassword);
  }
}
