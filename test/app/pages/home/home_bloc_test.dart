import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:repo_browser/app/pages/home/home_bloc.dart';
import 'package:repo_browser/app/pages/home/home_state.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/git_use_case.dart';

class MockGitRepositoryUseCase extends Mock implements GitRepositoryUseCase {}

const Repository repository = Repository(
  id: 1234,
  name: 'Repository',
  owner: RepositoryOwner(
    id: 5678,
    login: 'user',
    avatarUrl: 'https://www.wp.pl/img.png',
  ),
);

void main() {
  group('HomeBloc', () {
    final MockGitRepositoryUseCase useCase = MockGitRepositoryUseCase();

    tearDown(() {
      reset(useCase);
    });

    blocTest(
      'emits loading and content after search',
      build: () {
        when(useCase.searchRepositories('spacecraft')).thenAnswer((_) async => const SearchResult(
              totalCount: 1,
              items: [repository],
            ));

        return HomeBloc(useCase);
      },
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.search('spacecraft')),
      expect: () => [
        const HomeState.loading(),
        const HomeState.content(
          searchResult: SearchResult(
            totalCount: 1,
            items: [repository],
          ),
        ),
      ],
    );

    blocTest(
      'emits empty when query is empty',
      build: () => HomeBloc(useCase),
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.search('')),
      expect: () => [const HomeState.empty()],
    );

    blocTest(
      'emits no results',
      build: () {
        when(useCase.searchRepositories('spacecraft')).thenAnswer((_) async => const SearchResult(
              totalCount: 0,
              items: [],
            ));

        return HomeBloc(useCase);
      },
      act: (HomeBloc bloc) => bloc.add(const HomeEvent.search('spacecraft')),
      expect: () => [
        const HomeState.loading(),
        const HomeState.noResults(),
      ],
    );
  });
}
