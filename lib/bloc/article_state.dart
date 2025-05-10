// part of 'article_bloc.dart';

// abstract class ArticleState extends Equatable {
//   const ArticleState();

//   @override
//   List<Object> get props => [];
// }

// class ArticleInitial extends ArticleState {}

// class ArticleLoading extends ArticleState {}

// class ArticleLoaded extends ArticleState {
//   final List<Article> articles;
//   final List<Article> filteredArticles;
//   final List<int> favorites;

//   const ArticleLoaded( {
//     required this.articles,
//     required this.filteredArticles,
//     required Editable,
//     required this.favorites,
//   });

//   ArticleLoaded copyWith({
//     List<Article>? articles,
//     List<Article>? filteredArticles,
//     List<int>? favorites,
//   }) {
//     return ArticleLoaded(
//       articles: articles ?? this.articles,
//       filteredArticles: filteredArticles ?? this.filteredArticles,
//       favorites: favorites ?? this.favorites,
//     );
//   }

//   @override
//   List<Object> get props => [articles, filteredArticles, favorites];
// }

// class ArticleError extends ArticleState {
//   final String message;
//   const ArticleError({required this.message});

//   @override
//   List<Object> get props => [message];
// }


part of 'article_bloc.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;
  final List<Article> filteredArticles;
  final List<int> favorites;

  const ArticleLoaded({
    required this.articles,
    required this.filteredArticles,
    required this.favorites,
  });

  ArticleLoaded copyWith({
    List<Article>? articles,
    List<Article>? filteredArticles,
    List<int>? favorites,
  }) {
    return ArticleLoaded(
      articles: articles ?? this.articles,
      filteredArticles: filteredArticles ?? this.filteredArticles,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object> get props => [articles, filteredArticles, favorites];
}

class ArticleError extends ArticleState {
  final String message;
  const ArticleError({required this.message});

  @override
  List<Object> get props => [message];
}