import 'dart:async';
import 'package:bharat_nxt_assignment/bloc/article_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/article_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(FetchArticles());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<ArticleBloc>().add(SearchArticles(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ArticleBloc>().add(FetchArticles());
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search Articles',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            Expanded(
              child: BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ArticleError) {
                    return Center(child: Text(state.message));
                  } else if (state is ArticleLoaded) {
                    if (state.filteredArticles.isEmpty) {
                      return const Center(child: Text('No articles found'));
                    }
                    return ListView.builder(
                      itemCount: state.filteredArticles.length,
                      itemBuilder: (context, index) {
                        final article = state.filteredArticles[index];
                        final isFavorite = state.favorites.contains(article.id);
                        return ArticleCard(
                          article: article,
                          isFavorite: isFavorite,
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
            ),
          ],
        ),
      ),
    );
  }
}