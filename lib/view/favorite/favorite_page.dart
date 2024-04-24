import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_viewmodel.dart';

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
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return FutureBuilder(
            future: viewModel.isInitCompleted,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (viewModel.questions
                        .every((element) => element.favorite != 1)
                    // .any((element) => element.favorite != 1)
                    ) {
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
                          itemCount: viewModel.questions.length,
                          itemBuilder: (context, index) {
                            if (viewModel.questions[index].favorite == 1) {
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(index.toString()),
                                  ),
                                  title:
                                      Text(viewModel.questions[index].question),
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
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
