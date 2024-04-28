import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../common/function/alert_dialog.dart';
import '../../common/widgets/banner_ads.dart';
import '../../service/const.dart';
import '../details/details_page_home.dart';
import '../practise/practise_page.dart';
import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFabVisible = true;
  InterstitialAd? _interstitialAd;

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

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
                      BannerAds(),
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
              onPressed: () async {
                await showMyDialog(
                    context: context,
                    barrierDismissible: true,
                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                    title: Text("Practise"),
                    body: Text(
                        "You have to answer 15 question. There is no time limit but there is a timer to track the time you have taken. Goodluck."),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          loadAd();
                          Navigator.of(context)
                            ..pop()
                            ..push(
                              MaterialPageRoute(
                                builder: (ctx) => PractiseQuestionPage(
                                  randomQuestionIndex: randomNumber(),
                                  questionsAll:
                                      context.read<HomeViewModel>().questions,
                                ),
                              ),
                            ).then((value) => _interstitialAd?.show());
                        },
                        child: Text("Start"),
                      ),
                    ]);
              },
              icon: const Icon(Icons.edit_note),
              label: const Text("Practise"),
            )
          : null,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }

  List<int> randomNumber() {
    final random = Random();
    final Set<int> uniqueNumbers = {};

    while (uniqueNumbers.length < 15) {
      uniqueNumbers.add(random.nextInt(169) + 1);
    }

    return uniqueNumbers.toList();
  }

  void loadAd() {
    InterstitialAd.load(
        adUnitId: Strings.getInterstitialAdIdAndroid(),
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');

            _interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }
}
