import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

part 'issue.freezed.dart';
part 'issue.g.dart';

@freezed
class Issue with _$Issue {
  const factory Issue({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'user') required RepositoryOwner user,
  }) = _Issue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}
