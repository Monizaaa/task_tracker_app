import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_tracker_app/features/auth/data/models/signin_response_model.dart';

import '../../../../core/errors/server_exception.dart';
import '../models/user_model.dart';
import '../../../../core/api/api_client.dart';

abstract class AuthRemoteDataSource {
  Future<SigninResponseModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  });

  Future<UserModel> getProfile();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient = Get.find<ApiClient>();

  @override
  Future<SigninResponseModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('${_apiClient.baseUrl}/auth/login');
    final response = await _apiClient.client.post(
      uri,
      headers: _apiClient.defaultHeaders,
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return SigninResponseModel(
        token: responseBody['token'],
        user: UserModel.fromJson(responseBody['user']),
      );
    } else {
      final errorBody = json.decode(response.body);
      throw ServerException(message: errorBody['message'] ?? 'Login Failed');
    }
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final uri = Uri.parse('${_apiClient.baseUrl}/auth/register');
    final response = await _apiClient.client.post(
      uri,
      headers: _apiClient.defaultHeaders,
      body: json.encode({
        'email': email,
        'password': password,
        'displayName': displayName,
      }),
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      return UserModel.fromJson(responseBody['user']);
    } else {
      final errorBody = json.decode(response.body);
      throw ServerException(
        message: errorBody['message'] ?? 'Registration Failed',
      );
    }
  }

  @override
  Future<UserModel> getProfile() async {
    final uri = Uri.parse('${_apiClient.baseUrl}/auth/verify');
    final response = await _apiClient.client.get(
      uri,
      headers: _apiClient.defaultHeaders,
    );

    if (response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      return UserModel.fromJson(responseBody['user']);
    } else {
      final errorBody = json.decode(response.body);
      throw ServerException(
        message: errorBody['message'] ?? 'Registration Failed',
      );
    }
  }
}
