import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_browser/app/assets/app_images.dart';
import 'package:repo_browser/app/common/theming/dimens.dart';
import 'package:repo_browser/app/di/di.dart';
import 'package:repo_browser/app/pages/repository/repository_bloc.dart';
import 'package:repo_browser/app/pages/repository/repository_state.dart';
import 'package:repo_browser/app/widgets/issue_widget.dart';
import 'package:repo_browser/generated/locale_keys.g.dart';
import 'package:repo_browser/model/git/entity/issue.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

/// A page that displays repository details.
@RoutePage()
class RepositoryPage extends StatelessWidget {
  final Repository repository;
  final Color? accentColor;

  const RepositoryPage({
    super.key,
    required this.repository,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inject<RepositoryBloc>()..loadData(repository),
      child: Scaffold(
        body: SafeArea(
          child: RepositoryBody(
            repository: repository,
            accentColor: accentColor,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: accentColor,
          label: Text(LocaleKeys.page_repository_homeButton.tr()),
          onPressed: () => context.router.popUntilRoot(),
        ),
      ),
    );
  }

  static String buildImageTag(String repository) {
    return 'image_repository_$repository';
  }

  static String buildTitleTag(String repository) {
    return 'title_repository_$repository';
  }
}

class RepositoryBody extends StatelessWidget {
  final Repository repository;
  final Color? accentColor;

  const RepositoryBody({
    super.key,
    required this.repository,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ListView(
            children: [
              Hero(
                tag: RepositoryPage.buildImageTag(repository.id.toString()),
                child: Image.network(repository.owner.avatarUrl, fit: BoxFit.cover),
              ),
              _Content(repository: repository),
            ],
          ),
        ),
        const Positioned(
          left: 12,
          top: 12,
          child: _BackButton(),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final Repository repository;

  const _Content({required this.repository});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.normal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing.big,
          Hero(
            tag: RepositoryPage.buildTitleTag(repository.id.toString()),
            child: Text(
              repository.owner.login + '/' + repository.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Spacing.big,
          const _Issues(),
        ],
      ),
    );
  }
}

class _Issues extends StatelessWidget {
  const _Issues();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryBloc, RepositoryState>(
      builder: (context, state) {
        return state.when(
          loading: () => const _IssuesLoading(),
          content: (issues) => _IssuesList(issues: issues),
          noResults: () => const _IssuesEmpty(),
          error: (error) => _IssuesError(error: error),
        );
      },
    );
  }
}

class _IssuesLoading extends StatelessWidget {
  const _IssuesLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _IssuesList extends StatelessWidget {
  final List<Issue> issues;

  const _IssuesList({required this.issues});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.page_repository_issues.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Spacing.smaller,
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: issues.length,
          itemBuilder: (context, index) => IssueWidget(issue: issues[index]),
          prototypeItem: issues.isEmpty ? null : IssueWidget(issue: issues.first),
        ),
      ],
    );
  }
}

class _IssuesEmpty extends StatelessWidget {
  const _IssuesEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.page_repository_noResults.tr(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _IssuesError extends StatelessWidget {
  final Object error;

  const _IssuesError({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Insets.normal,
        child: Text(
          LocaleKeys.page_repository_error.tr(args: [error.toString()]),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        child: Padding(
          padding: Insets.smaller,
          child: Image.asset(
            AppImages.icChevronLeft24,
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
