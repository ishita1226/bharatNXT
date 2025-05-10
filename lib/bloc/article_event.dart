part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class FetchArticles extends ArticleEvent {}

class SearchArticles extends ArticleEvent {
  final String query;
  const SearchArticles(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleFavorite extends ArticleEvent {
  final int articleId;
  const ToggleFavorite(this.articleId);

  @override
  List<Object> get props => [articleId];
}