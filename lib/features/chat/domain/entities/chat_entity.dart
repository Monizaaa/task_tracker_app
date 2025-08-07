class ChatEntity {
  final int id;
  final String displayName;
  final String avatar;
  final String status;

  const ChatEntity({
    required this.id,
    required this.displayName,
    required this.avatar,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
