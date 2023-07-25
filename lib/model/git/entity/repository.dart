import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const SearchResult._();

  const factory SearchResult({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'items') required List<Repository> items,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

  Repository getRepository(String id) {
    return items.firstWhere((e) => e.id == id);
  }
}

@freezed
class Repository with _$Repository {
  const factory Repository({
    required String id,
    required String title,
    required String imageUrl,
    required String body,
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);
}
