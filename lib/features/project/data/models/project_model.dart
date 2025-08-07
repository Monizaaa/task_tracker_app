import 'package:task_tracker_app/features/project/data/models/member_model.dart';
import 'package:task_tracker_app/features/project/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required super.id,
    required super.name,
    required super.description,
    required super.createdAt,
    required super.createdBy,
    super.updatedAt,
    super.updatedBy,
    required super.tasks,
    required super.statusDone,
    required super.members,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as int,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'] as String)
              : null,
      updatedBy: json['updated_by'] as int?,
      tasks: json['tasks'] as int,
      statusDone: json['status_done'] as int,
      members:
          (json['members'] as List<dynamic>)
              .map(
                (memberJson) =>
                    MemberModel.fromJson(memberJson as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}
