import 'package:freezed_annotation/freezed_annotation.dart';

part 'issue.freezed.dart';
part 'issue.g.dart';

@freezed
class Issue with _$Issue {
  const factory Issue({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'user') required IssueAuthor user,
  }) = _Issue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}

@freezed
class IssueAuthor with _$IssueAuthor {
  const factory IssueAuthor({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'login') required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
  }) = _IssueAuthor;

  factory IssueAuthor.fromJson(Map<String, dynamic> json) => _$IssueAuthorFromJson(json);
}
