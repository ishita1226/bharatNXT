import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/article_bloc.dart';
import '../widgets/article_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ArticleError) {
            return Center(child: Text(state.message));
          } else if (state is ArticleLoaded) {
            final favoriteArticles = state.articles
                .where((article) => state.favorites.contains(article.id))
                .toList();
            if (favoriteArticles.isEmpty) {
              return const Center(child: Text('No favorite articles'));
            }
            return ListView.builder(
              itemCount: favoriteArticles.length,
              itemBuilder: (context, index) {
                final article = favoriteArticles[index];
                return ArticleCard(
                  article: article,
                  isFavorite: true,
                  onFavoriteToggle: () {
                    context
                        .read<ArticleBloc>()
                        .add(ToggleFavorite(article.id));
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}