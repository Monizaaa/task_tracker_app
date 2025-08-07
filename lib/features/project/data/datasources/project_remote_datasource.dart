import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_tracker_app/features/project/data/models/project_model.dart';
import 'package:task_tracker_app/features/project/domain/entities/project_entity.dart';

import '../../../../core/errors/server_exception.dart';
import '../../../../core/api/api_client.dart';

abstract class ProjectRemoteDataSource {
  Future<List<ProjectEntity>> searchProjects({String? keyword});
}

class ProjectRemoteDataSourceImpl implements ProjectRemoteDataSource {
  final ApiClient _apiClient = Get.find<ApiClient>();

  @override
  Future<List<ProjectEntity>> searchProjects({String? keyword}) async {
    final uri = Uri.parse('${_apiClient.baseUrl}/projects').replace(
      queryParameters:
          (keyword != null && keyword.isNotEmpty) ? {'q': keyword} : null,
    );
    final response = await _apiClient.client.get(
      uri,
      headers: _apiClient.defaultHeaders,
    );

    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body)['items'];
      return items.map((data) => ProjectModel.fromJson(data)).toList();
    } else {
      final errorBody = json.decode(response.body);
      throw ServerException(
        message: errorBody['message'] ?? 'Search Projects Failed',
      );
    }
  }
}
