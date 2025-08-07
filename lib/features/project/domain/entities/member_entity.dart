class MemberEntity {
  final int id;
  final String displayName;
  final String avatar;

  const MemberEntity({
    required this.id,
    required this.displayName,
    required this.avatar,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemberEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
