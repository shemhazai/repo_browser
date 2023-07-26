import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'items') required List<Repository> items,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);
}

@freezed
class Repository with _$Repository {
  const factory Repository({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'owner') required RepositoryOwner owner,
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);
}

@freezed
class RepositoryOwner with _$RepositoryOwner {
  const factory RepositoryOwner({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'login') required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
  }) = _RepositoryOwner;

  factory RepositoryOwner.fromJson(Map<String, dynamic> json) => _$RepositoryOwnerFromJson(json);
}
