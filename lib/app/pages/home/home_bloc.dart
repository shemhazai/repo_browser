import 'package:repo_browser/app/common/bloc/base_cubit.dart';
import 'package:repo_browser/app/pages/home/home_page.dart';
import 'package:repo_browser/app/pages/home/home_state.dart';
import 'package:repo_browser/model/article/article_use_case.dart';
import 'package:repo_browser/model/article/entity/article.dart';
import 'package:repo_browser/model/article/exception/article_exceptions.dart';

/// State management for the [HomePage].
class HomeBloc extends BaseCubit<HomeState> {
  final ArticleUseCase _useCase;

  HomeBloc(this._useCase) : super(const HomeState.empty());

  Future<void> search(String text) async {
    try {
      if (text.isEmpty) {
        emit(const HomeState.empty());
        return;
      }

      emit(const HomeState.loading());

      final data = await _useCase.searchArticles(text);
      final articles = _mapArticles(data);
      if (articles.isEmpty) {
        emit(const HomeState.noResults());
      } else {
        emit(HomeState.content(searchResult: data, headlines: articles));
      }
    } on SearchArticleNoResultsException {
      emit(const HomeState.noResults());
    } on SearchArticleInvalidQueryException catch (error) {
      emit(HomeState.error(error));
    }
  }

  List<HomeArticleHeadline> _mapArticles(SearchResult result) {
    return result.pages.map((e) {
      return HomeArticleHeadline(
        id: e.id,
        title: e.title,
        article: result.getArticle(e.itemId),
      );
    }).toList();
  }
}
