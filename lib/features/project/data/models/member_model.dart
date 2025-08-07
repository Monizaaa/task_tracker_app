import 'package:task_tracker_app/features/project/domain/entities/member_entity.dart';

class MemberModel extends MemberEntity {
  const MemberModel({
    required super.id,
    required super.displayName,
    required super.avatar,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] as int,
      displayName: json['display_name'] as String,
      avatar: json['avatar'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'display_name': displayName, 'avatar': avatar};
  }
}
