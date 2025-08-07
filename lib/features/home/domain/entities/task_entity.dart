class TaskEntity {
  final int id;
  final String projectName;
  final String taskName;
  final String time;
  final double status;

  const TaskEntity({
    required this.id,
    required this.projectName,
    required this.taskName,
    required this.time,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
