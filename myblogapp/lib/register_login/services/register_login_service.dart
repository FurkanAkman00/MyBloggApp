import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/UserModel.dart';

abstract class IRegisterLoginService {
  final String registerPath = "register";
  final String loginPath = "login";
  final Dio _dio;
  IRegisterLoginService(this._dio);
  Future<String?> registerUser(User user);
  Future<String?> loginUser(String email, String password);
}

class RegsiterLoginService extends IRegisterLoginService {
  RegsiterLoginService(super._dio);

  @override
  Future<String?> registerUser(User user) async {
    final response = await _dio.post(registerPath, data: user.toJson());
    if (response.statusCode == HttpStatus.created) {
      return response.data["token"];
    } else {
      return null;
    }
  }

  @override
  Future<String?> loginUser(String email, String password) async {
    final result = await _dio
        .post(loginPath, data: {"email": email, "password": password});
    if (result.statusCode == HttpStatus.ok) {
      return result.data["token"];
    } else {
      return null;
    }
  }
}
