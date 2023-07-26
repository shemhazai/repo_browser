import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:repo_browser/app/pages/repository/repository_bloc.dart';
import 'package:repo_browser/app/pages/repository/repository_state.dart';
import 'package:repo_browser/model/git/entity/issue.dart';
import 'package:repo_browser/model/git/entity/repository.dart';
import 'package:repo_browser/model/git/git_use_case.dart';

class _MockGitRepositoryUseCase extends Mock implements GitRepositoryUseCase {
  @override
  Future<List<Issue>> searchIssues(String user, String repo) async {
    if (user == 'error') throw _exception;
    if (user == _issue.user.login && repo == _repository.name) return [_issue];

    return const [];
  }
}

final Repository _repository = Repository(
  id: 1234,
  name: 'Repository',
  owner: RepositoryOwner(
    id: _issue.user.id,
    login: _issue.user.login,
    avatarUrl: _issue.user.avatarUrl,
  ),
);

const Repository _anotherRepository = Repository(
  id: 9876,
  name: 'another_repository',
  owner: RepositoryOwner(
    id: 1,
    login: 'another_user',
    avatarUrl: 'https://www.wp.pl/img.png',
  ),
);

const Repository _errorRepository = Repository(
  id: 9876,
  name: 'error',
  owner: RepositoryOwner(
    id: 1,
    login: 'error',
    avatarUrl: 'https://www.wp.pl/img.png',
  ),
);

const Issue _issue = Issue(
  id: 5678,
  title: 'Issue',
  user: RepositoryOwner(
    id: 90,
    login: 'login',
    avatarUrl: 'htttps://image.com',
  ),
);

final Exception _exception = Exception('error');

void main() {
  group(RepositoryBloc, () {
    blocTest<RepositoryBloc, RepositoryState>(
      'emits loading and content after search',
      build: () => RepositoryBloc(_MockGitRepositoryUseCase()),
      act: (bloc) => bloc.loadData(_repository),
      expect: () => [
        const RepositoryState.loading(),
        const RepositoryState.content(issues: [_issue]),
      ],
    );

    blocTest<RepositoryBloc, RepositoryState>(
      'emits no results',
      build: () => RepositoryBloc(_MockGitRepositoryUseCase()),
      act: (bloc) => bloc.loadData(_anotherRepository),
      expect: () => [
        const RepositoryState.loading(),
        const RepositoryState.noResults(),
      ],
    );

    blocTest<RepositoryBloc, RepositoryState>(
      'emits error',
      build: () => RepositoryBloc(_MockGitRepositoryUseCase()),
      act: (bloc) => bloc.loadData(_errorRepository),
      expect: () => [
        const RepositoryState.loading(),
        RepositoryState.error(_exception),
      ],
    );
  });
}
