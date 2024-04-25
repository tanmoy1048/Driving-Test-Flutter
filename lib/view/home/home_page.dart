import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../details/details_page_home.dart';
import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFabVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questions"),
      ),
      body: Container(
        child: Consumer<HomeViewModel>(
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
                      Flexible(
                        child: NotificationListener<UserScrollNotification>(
                          onNotification: (notification) {
                            if (notification.direction ==
                                ScrollDirection.forward) {
                              if (!isFabVisible) {
                                setState(() {
                                  isFabVisible = true;
                                });
                              }
                            } else if (notification.direction ==
                                ScrollDirection.reverse) {
                              if (isFabVisible) {
                                setState(() {
                                  isFabVisible = false;
                                });
                              }
                            }
                            return true;
                          },
                          child: Scrollbar(
                            thumbVisibility: false,
                            child: ListView.builder(
                              itemCount: viewModel.questions.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Card(
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => DetailsPageHome(
                                                initIndex: index),
                                          ),
                                        );
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: viewModel
                                                    .questions[index]
                                                    .favorite ==
                                                1
                                            ? Colors.redAccent
                                            : null,
                                        child: Text(
                                          viewModel.questions[index].id
                                              .toString(),
                                        ),
                                      ),
                                      title: Text(
                                          viewModel.questions[index].question),
                                    ),
                                  ),
                                );
                              },
                            ),
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
      ),
      floatingActionButton: isFabVisible
          ? FloatingActionButton.extended(
              heroTag: "fab",
              onPressed: () {},
              icon: const Icon(Icons.edit_note),
              label: const Text("Practise"),
            )
          : null,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
