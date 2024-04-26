import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../details/details_page_favorite.dart';
import '../home/home_viewmodel.dart';
import 'favorite_viewmodel.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: Consumer<FavoriteViewModel>(
        builder: (context, viewModel, child) {
          return FutureBuilder(
            future: viewModel.isInitCompleted,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (viewModel.favQuestions.isEmpty) {
                  return const Center(
                    child: Text(
                      "Favorite list is Empty",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BannerAds(),

                    Flexible(
                      child: Scrollbar(
                        thumbVisibility: false,
                        child: ListView.builder(
                          itemCount: viewModel.favQuestions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (ctx) => DetailsPageFavorite(
                                          initIndex: index,
                                          favQuestions: viewModel.favQuestions,
                                        ),
                                      ),
                                    )
                                        .then((value) {
                                      viewModel.getData();
                                      context.read<HomeViewModel>().getData();
                                    });
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.redAccent,
                                    child: Text("${index + 1}"),
                                  ),
                                  title: Text(
                                      viewModel.favQuestions[index].question),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
