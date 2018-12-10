class Post {
  final int id;
  final String title;
  final String body;

  const Post({this.id, this.title, this.body});

  @override
  String toString() => """
    { 
      "id": $id,
      "title": "$title",
      "body": "${body.replaceAll(RegExp(r'\n'), '')}"
    }
  """;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          body == other.body;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ body.hashCode;
}
