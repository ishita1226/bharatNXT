import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../models/article.dart';
import '../services/api_service.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ApiService apiService;
  final Box<int> favoritesBox;

  ArticleBloc(this.apiService, this.favoritesBox) : super(ArticleInitial()) {
    on<FetchArticles>(_onFetchArticles);
    on<SearchArticles>(_onSearchArticles);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onFetchArticles(
      FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticleLoading());
    try {
      final articles = await apiService.fetchArticles();
      final favorites = favoritesBox.values.toList();
      emit(ArticleLoaded(
        articles: articles,
        filteredArticles: articles,
        favorites: favorites,
      ));
    } catch (e) {
      emit(ArticleError(message: e.toString()));
    }
  }

  void _onSearchArticles(SearchArticles event, Emitter<ArticleState> emit) {
    if (state is ArticleLoaded) {
      final currentState = state as ArticleLoaded;
      final query = event.query.toLowerCase();
      final filteredArticles = query.isEmpty
          ? currentState.articles
          : currentState.articles.where((article) {
              return article.title.toLowerCase().contains(query) ||
                  article.body.toLowerCase().contains(query);
            }).toList();
      emit(currentState.copyWith(filteredArticles: filteredArticles));
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<ArticleState> emit) {
    if (state is ArticleLoaded) {
      final currentState = state as ArticleLoaded;
      final updatedFavorites = List<int>.from(currentState.favorites);
      if (updatedFavorites.contains(event.articleId)) {
        updatedFavorites.remove(event.articleId);
        favoritesBox.delete(event.articleId);
      } else {
        updatedFavorites.add(event.articleId);
        favoritesBox.put(event.articleId, event.articleId);
      }
      emit(currentState.copyWith(favorites: updatedFavorites));
    }
  }
}