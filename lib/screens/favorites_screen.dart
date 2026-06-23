import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_provider.dart';

class FavoritesScreen
    extends StatelessWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final provider =
        Provider.of<FavoriteProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Favorites"),
      ),
      body: provider.favorites.isEmpty
          ? const Center(
              child: Text(
                "No favorites yet",
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                itemCount:
                    provider.favorites.length,
                itemBuilder:
                    (_, index) {

                  final id =
                      provider.favorites[
                          index];

                  return Dismissible(
                    key: Key(id),
                    onDismissed:
                        (_) {
                      provider
                          .toggleFavorite(
                        id,
                      );
                    },
                    child: ListTile(
                      leading:
                          const Icon(
                        Icons.favorite,
                      ),
                      title:
                          Text(id),
                    ),
                  );
                },
              ),
            ),
    );
  }
}