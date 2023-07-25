import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:repo_browser/app/assets/app_images.dart';
import 'package:repo_browser/app/common/theming/dimens.dart';
import 'package:repo_browser/app/router/router.gr.dart';
import 'package:repo_browser/app/widgets/markdown_widget.dart';
import 'package:repo_browser/generated/locale_keys.g.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

/// A page that displays repository details.
@RoutePage()
class RepositoryPage extends StatelessWidget {
  final SearchResult searchResult;
  final Repository repository;
  final Color? accentColor;

  const RepositoryPage({
    super.key,
    required this.searchResult,
    required this.repository,
    required this.accentColor,
  });

  /// Navigates to the [RepositoryPage]. The idea is to have a helper
  /// method which preresolves the accentColor to avoid cpu-intensive
  /// calculation when the transition is ongoing.
  static Future<void> show({
    required BuildContext context,
    required SearchResult searchResult,
    required Repository repository,
  }) async {
    if (context.mounted) {
      await context.router.push(RepositoryRoute(
        searchResult: searchResult,
        repository: repository,
        accentColor: Colors.black,
      ));
    }
  }

  static String buildImageTag(String articleId) {
    return 'image_article_$articleId';
  }

  static String buildTitleTag(String articleId) {
    return 'title_article_$articleId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ArticleBody(
          searchResult: searchResult,
          repository: repository,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: accentColor,
        label: Text(LocaleKeys.page_article_homeButton.tr()),
        onPressed: () => context.router.popUntilRoot(),
      ),
    );
  }
}

class ArticleBody extends StatelessWidget {
  final SearchResult searchResult;
  final Repository repository;

  const ArticleBody({
    super.key,
    required this.searchResult,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: ListView(children: [
          Hero(
            tag: RepositoryPage.buildImageTag(repository.id),
            child: Image.network(repository.imageUrl, fit: BoxFit.cover),
          ),
          _Content(
            searchResult: searchResult,
            repository: repository,
          ),
        ]),
      ),
      const Positioned(
        left: 12,
        top: 12,
        child: _BackButton(),
      ),
    ]);
  }
}

class _Content extends StatelessWidget {
  final SearchResult searchResult;
  final Repository repository;

  const _Content({
    required this.searchResult,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.normal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing.big,
          Hero(
            tag: RepositoryPage.buildTitleTag(repository.id),
            child: Text(repository.title, style: Theme.of(context).textTheme.headlineSmall),
          ),
          Spacing.big,
          RepositoryMarkdown(
            body: repository.body,
            onTapRepository: (String repository) => RepositoryPage.show(
              context: context,
              searchResult: searchResult,
              repository: searchResult.getRepository(repository),
            ),
          ),
          const SizedBox(height: 80),
        ],
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
