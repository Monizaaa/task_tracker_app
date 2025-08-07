import 'package:flutter/foundation.dart';
import 'package:task_tracker_app/features/project/domain/entities/member_entity.dart';

class ProjectEntity {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final int createdBy;
  final DateTime? updatedAt;
  final int? updatedBy;
  final int tasks;
  final int statusDone;
  final List<MemberEntity> members;

  ProjectEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
    this.updatedBy,
    required this.tasks,
    required this.statusDone,
    required this.members,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          createdAt == other.createdAt &&
          createdBy == other.createdBy &&
          updatedAt == other.updatedAt &&
          updatedBy == other.updatedBy &&
          tasks == other.tasks &&
          statusDone == other.statusDone &&
          listEquals(members, other.members);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
