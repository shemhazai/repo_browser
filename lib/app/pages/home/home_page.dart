import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_browser/app/assets/app_images.dart';
import 'package:repo_browser/app/common/theming/dimens.dart';
import 'package:repo_browser/app/di/di.dart';
import 'package:repo_browser/app/pages/article/article_page.dart';
import 'package:repo_browser/app/pages/home/home_bloc.dart';
import 'package:repo_browser/app/pages/home/home_state.dart';
import 'package:repo_browser/generated/locale_keys.g.dart';
import 'package:repo_browser/model/article/entity/article.dart';

/// An initial page of the application, allows to search for articles.
@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inject<HomeBloc>(),
      child: const Scaffold(
        body: SafeArea(
          child: HomeBody(),
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacing.big,
        const _Header(),
        Spacing.normal,
        const _SearchField(),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Expanded(
              child: state.when(
                empty: () => const _Empty(),
                loading: () => const _Loading(),
                noResults: () => const _NoResults(),
                error: (error) => _Error(error: error),
                content: (searchResult, headlines) => _Content(searchResult: searchResult, headlines: headlines),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.small,
      child: Row(children: [
        Expanded(
          child: Text(
            LocaleKeys.page_home_title.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Image.asset(
          AppImages.icUserAvatar48,
          width: 48,
          height: 48,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ]),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return Padding(
      padding: Insets.normal,
      child: TextField(
        onChanged: bloc.search,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          filled: true,
          hintText: LocaleKeys.page_home_search.tr(),
          prefixIcon: Image.asset(
            AppImages.icSearch24,
            width: 24,
            height: 24,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          contentPadding: Insets.smaller,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _NoResults extends StatelessWidget {
  const _NoResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.page_home_noResults.tr(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _Error extends StatelessWidget {
  final Object error;

  const _Error({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocaleKeys.page_home_error.tr(args: [error.toString()]),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final SearchResult searchResult;
  final List<HomeArticleHeadline> headlines;

  const _Content({
    required this.searchResult,
    required this.headlines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Insets.normal.copyWith(bottom: 0),
          child: Text(
            LocaleKeys.page_home_results.tr(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Spacing.tiny,
        Expanded(
          child: ListView.builder(
            padding: Insets.small,
            itemCount: headlines.length,
            itemBuilder: (BuildContext context, int index) {
              final HomeArticleHeadline headline = headlines[index];
              return _ArticleHeadlineWidget(
                headline: headline,
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  ArticlePage.show(
                    context: context,
                    searchResult: searchResult,
                    article: headline.article,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ArticleHeadlineWidget extends StatelessWidget {
  final HomeArticleHeadline headline;
  final VoidCallback? onPressed;

  const _ArticleHeadlineWidget({
    required this.headline,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const Color foregroundColor = Colors.white;
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: Insets.tiny,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: SizedBox(
          height: 100,
          child: Stack(children: [
            Positioned.fill(
              child: Hero(
                tag: ArticlePage.buildImageTag(headline.article.id),
                child: Image.network(
                  headline.article.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Hero(
                tag: ArticlePage.buildTitleTag(headline.article.id),
                child: Text(
                  headline.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: foregroundColor),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Image.asset(
                AppImages.icChevronRight24,
                width: 24,
                height: 24,
                color: foregroundColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
