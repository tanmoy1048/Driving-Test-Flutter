import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../common/function/alert_dialog.dart';
import '../../common/widgets/answer_tile.dart';
import '../../database/model/question_model.dart';
import '../../service/const.dart';
import '../favorite/favorite_viewmodel.dart';
import 'result_page.dart';

class PractiseQuestionPage extends StatefulWidget {
  const PractiseQuestionPage(
      {super.key,
      required this.questionsAll,
      required this.randomQuestionIndex});

  final List<QuestionModel> questionsAll;
  final List<int> randomQuestionIndex;

  @override
  State<PractiseQuestionPage> createState() => _PractiseQuestionPageState();
}

class _PractiseQuestionPageState extends State<PractiseQuestionPage> {
  bool finishClicked = false;
  int currentIndex = 0;
  List<QuestionModel> questionPage = [];
  List<ChoosedAnswers> choosedAnswersList = List.filled(
    15,
    ChoosedAnswers(choosedIndex: 0, isCorrect: null, correctIndex: null),
  ); // Update this if question number changed from 15.

  late Stopwatch stopwatch;
  late Timer t;
  bool canPop = false;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();

    t = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      print("update");
      setState(() {});
    });

    for (int element in widget.randomQuestionIndex) {
      questionPage.add(widget.questionsAll[element]);
    }
    stopwatch.start();
  }

  @override
  void dispose() {
    if (t.isActive) t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final viewModel = context.watch<FavoriteViewModel>();
    return PopScope(
      canPop: canPop,
      onPopInvoked: (b) {
        //print("b ======== $b");
        if (!b) {
          showMyDialog(
              context: context,
              title: const Text("Return to homepage"),
              body: const Text(
                  "Are you sure? Current practise will be cancelled if returned."),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No"),
                ),
                ElevatedButton(
                  onPressed: () {
                    canPop = true;
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: const Text("Yes"),
                ),
              ],
              actionsAlignment: MainAxisAlignment.spaceEvenly);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: LayoutBuilder(builder: (context, constrains) {
                      //  print("constrains ${constrains.maxWidth}");
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                        ),
                        height: 6,
                        margin: EdgeInsets.only(
                            right: constrains.maxWidth -
                                ((constrains.maxWidth * (currentIndex + 1)) /
                                    widget.randomQuestionIndex.length)),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${currentIndex + 1}/${questionPage.length}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).hintColor),
                ),
              ],
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(returnFormattedText()),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20),
                      child: Text(
                        questionPage[currentIndex].question,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Nunito"),
                      ),
                    ),
                    if (questionPage[currentIndex].image != 0)
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 15),
                        constraints: BoxConstraints.loose(
                            const Size(double.maxFinite, 260)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          "assets/images/${Strings.questionImages[questionPage[currentIndex].image - 1]}.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              answerTile(
                1,
                questionPage[currentIndex].answer1,
                questionPage[currentIndex].answer,
                choosedAnswersList[currentIndex].choosedIndex,
                choosedAnswersList[currentIndex].choosedIndex == 0
                    ? () {
                        choosedAnswersList[currentIndex] = ChoosedAnswers(
                          choosedIndex: 1,
                          correctIndex: questionPage[currentIndex].answer,
                          isCorrect: questionPage[currentIndex].answer == 1,
                        );
                        setState(() {});
                      }
                    : null,
              ),
              answerTile(
                2,
                questionPage[currentIndex].answer2,
                questionPage[currentIndex].answer,
                choosedAnswersList[currentIndex].choosedIndex,
                choosedAnswersList[currentIndex].choosedIndex == 0
                    ? () {
                        choosedAnswersList[currentIndex] = ChoosedAnswers(
                          choosedIndex: 2,
                          correctIndex: questionPage[currentIndex].answer,
                          isCorrect: questionPage[currentIndex].answer == 2,
                        );
                        setState(() {});
                      }
                    : null,
              ),
              answerTile(
                3,
                questionPage[currentIndex].answer3,
                questionPage[currentIndex].answer,
                choosedAnswersList[currentIndex].choosedIndex,
                choosedAnswersList[currentIndex].choosedIndex == 0
                    ? () {
                        setState(() {
                          choosedAnswersList[currentIndex] = ChoosedAnswers(
                            choosedIndex: 3,
                            correctIndex: questionPage[currentIndex].answer,
                            isCorrect: questionPage[currentIndex].answer == 3,
                          );
                        });
                      }
                    : null,
              ),
            ],
          ),
        ),
        bottomNavigationBar: finishClicked == true
            ? SizedBox(
                width: double.infinity,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        currentIndex = currentIndex != 0 ? currentIndex - 1 : 0;
                        setState(() {});
                      },
                      child: Icon(Icons.arrow_back_ios_rounded),
                    ),
                    SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        currentIndex = currentIndex != (questionPage.length - 1)
                            ? currentIndex + 1
                            : (questionPage.length - 1);
                        setState(() {});
                      },
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              )
            : choosedAnswersList[currentIndex].choosedIndex == 0
                ? null
                : SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: choosedAnswersList[currentIndex]
                                      .choosedIndex !=
                                  0
                              ? () {
                                  if (currentIndex + 1 == questionPage.length) {
                                    finishClicked = true;
                                    setState(() {});
                                    stopwatch.stop();
                                    int correctAnswer = 0;
                                    for (var item in choosedAnswersList) {
                                      if (item.isCorrect ?? false) {
                                        correctAnswer = correctAnswer + 1;
                                      }
                                    }
                                    showMyDialog(
                                      context: context,
                                      contentPadding: EdgeInsets.zero,
                                      body: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/bg.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        padding: EdgeInsets.all(15),
                                        child: SingleChildScrollView(
                                          child: Flex(
                                            direction: Axis.vertical,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "Quiz Result",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "Nunito"),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Container(
                                                height: 110,
                                                width: 100,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                child: Image.asset(
                                                  "assets/images/winner.png",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                "Congratulations!",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Nunito"),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "YOUR SCORE",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      //fontFamily: "Nunito",
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                              ),
                                              Text(
                                                "$correctAnswer / 15",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "Nunito"),
                                              ),
                                              Text(
                                                "Time: ${formattedDurationText(stopwatch.elapsed)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      //fontFamily: "Nunito",
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Show Answers"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            canPop = true;
                                            Navigator.of(context)
                                              ..pop()
                                              ..pop();
                                          },
                                          child: Text("Home"),
                                        ),
                                      ],
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                    );

                                    // Navigator.of(context)
                                    //     .pushReplacement(MaterialPageRoute(
                                    //   builder: (ctx) => ResultPage(
                                    //     duration: stopwatch.elapsed,
                                    //     questions: questionPage,
                                    //     choosedAnswersList: choosedAnswersList,
                                    //   ),
                                    // ));
                                  } else {
                                    setState(() {
                                      // _choosedAnswer = 0;
                                      currentIndex = currentIndex !=
                                              (questionPage.length - 1)
                                          ? currentIndex + 1
                                          : (questionPage.length - 1);
                                    });
                                  }
                                }
                              : null,
                          child: Text(currentIndex + 1 == questionPage.length
                              ? "Finish"
                              : "Next Question"),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  String returnFormattedText() {
    var duration = stopwatch.elapsed;

    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    String formatted;
    if (hours == 0) {
      formatted =
          "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else {
      formatted =
          "${hours.toString()}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }

    return formatted; // Return the formatted string
  }

  String formattedDurationText(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    String formatted;
    if (hours == 0) {
      formatted =
          "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} Min";
    } else {
      formatted =
          "${hours.toString()}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} Hr";
    }

    return formatted; // Return the formatted string
  }
}

class ChoosedAnswers {
  final int choosedIndex;
  final bool? isCorrect;
  final int? correctIndex;

  ChoosedAnswers(
      {required this.choosedIndex,
      required this.isCorrect,
      required this.correctIndex});
}
