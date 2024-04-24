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
                return Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // BannerAds(),
                    if (viewModel.questions.isNotEmpty)
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
                                    title: Text(
                                        viewModel.questions[index].question),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                    if (viewModel.questions.isEmpty)
                      const Flexible(
                        child: Text("Favorite list is Empty"),
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
