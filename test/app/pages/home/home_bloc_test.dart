import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:repo_browser/app/pages/home/home_bloc.dart';
import 'package:repo_browser/app/pages/home/home_state.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/git_use_case.dart';

class _MockGitRepositoryUseCase extends Mock implements GitRepositoryUseCase {
  @override
  Future<RepositoriesSearchResult> searchRepositories(String query) async {
    if (query == 'spacecraft') return _result;
    if (query == 'error') throw _exception;

    return _emptyResult;
  }
}

const Repository _repository = Repository(
  id: 1234,
  name: 'Repository',
  owner: RepositoryOwner(
    id: 5678,
    login: 'user',
    avatarUrl: 'https://www.wp.pl/img.png',
  ),
);

const RepositoriesSearchResult _emptyResult = RepositoriesSearchResult(totalCount: 0, items: []);
const RepositoriesSearchResult _result = RepositoriesSearchResult(totalCount: 1, items: [_repository]);

final Exception _exception = Exception('error');

void main() {
  group(HomeBloc, () {
    blocTest<HomeBloc, HomeState>(
      'emits loading and content after search',
      build: () => HomeBloc(_MockGitRepositoryUseCase()),
      act: (bloc) => bloc.add(const HomeEvent.search('spacecraft')),
      expect: () => [
        const HomeState.loading(),
        const HomeState.content(searchResult: _result),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits empty when query is empty',
      build: () => HomeBloc(_MockGitRepositoryUseCase()),
      act: (bloc) => bloc.add(const HomeEvent.search('')),
      expect: () => [const HomeState.empty()],
    );

    blocTest<HomeBloc, HomeState>(
      'emits no results',
      build: () => HomeBloc(_MockGitRepositoryUseCase()),
      act: (bloc) => bloc.add(const HomeEvent.search('no_results')),
      expect: () => [
        const HomeState.loading(),
        const HomeState.noResults(),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits error',
      build: () => HomeBloc(_MockGitRepositoryUseCase()),
      act: (bloc) => bloc.add(const HomeEvent.search('error')),
      expect: () => [
        const HomeState.loading(),
        HomeState.error(_exception),
      ],
    );
  });
}
