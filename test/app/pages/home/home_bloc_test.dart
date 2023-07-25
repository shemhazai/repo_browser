import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:repo_browser/app/pages/home/home_bloc.dart';
import 'package:repo_browser/app/pages/home/home_state.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/git_use_case.dart';

class MockGitRepositoryUseCase extends Mock implements GitRepositoryUseCase {}

const Repository repository = Repository(
  id: '1234',
  title: 'Repository',
  imageUrl: 'https://www.wp.pl/img.png',
  body: 'Body',
);

final HomeRepositoryHeadline homeHeadline = HomeRepositoryHeadline(
  id: repository.id,
  title: repository.title,
  repository: repository,
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
      act: (HomeBloc bloc) => bloc.search('spacecraft'),
      expect: () => [
        const HomeState.loading(),
        HomeState.content(
          searchResult: const SearchResult(
            totalCount: 1,
            items: [repository],
          ),
          headlines: [homeHeadline],
        ),
      ],
    );

    blocTest(
      'emits empty when query is empty',
      build: () => HomeBloc(useCase),
      act: (HomeBloc bloc) => bloc.search(''),
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
      act: (HomeBloc bloc) => bloc.search('spacecraft'),
      expect: () => [
        const HomeState.loading(),
        const HomeState.noResults(),
      ],
    );
  });
}
