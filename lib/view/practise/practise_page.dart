import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/function/alert_dialog.dart';
import '../../common/widgets/answer_tile.dart';
import '../../database/model/question_model.dart';
import '../../service/const.dart';
import '../favorite/favorite_viewmodel.dart';

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
  int _choosedAnswer = 0;
  int currentIndex = 0;
  List<QuestionModel> questionPage = [];
  List<ChoosedAnswers> choosedAnswersList = List.filled(
    15,
    ChoosedAnswers(choosedIndex: null, isCorrect: null, correctIndex: null),
  ); // Update this if question number changed from 15.

  late Stopwatch stopwatch;
  late Timer t;

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
    final viewModel = context.watch<FavoriteViewModel>();
    return Scaffold(
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
              _choosedAnswer,
              _choosedAnswer == 0
                  ? () {
                      choosedAnswersList[currentIndex] = ChoosedAnswers(
                        choosedIndex: 1,
                        correctIndex: questionPage[currentIndex].answer,
                        isCorrect: questionPage[currentIndex].answer == 1,
                      );
                      setState(() {
                        _choosedAnswer = 1;
                      });
                    }
                  : null,
            ),
            answerTile(
              2,
              questionPage[currentIndex].answer2,
              questionPage[currentIndex].answer,
              _choosedAnswer,
              _choosedAnswer == 0
                  ? () {
                      choosedAnswersList[currentIndex] = ChoosedAnswers(
                        choosedIndex: 2,
                        correctIndex: questionPage[currentIndex].answer,
                        isCorrect: questionPage[currentIndex].answer == 2,
                      );
                      setState(() {
                        _choosedAnswer = 2;
                      });
                    }
                  : null,
            ),
            answerTile(
              3,
              questionPage[currentIndex].answer3,
              questionPage[currentIndex].answer,
              _choosedAnswer,
              _choosedAnswer == 0
                  ? () {
                      setState(() {
                        choosedAnswersList[currentIndex] = ChoosedAnswers(
                          choosedIndex: 3,
                          correctIndex: questionPage[currentIndex].answer,
                          isCorrect: questionPage[currentIndex].answer == 3,
                        );
                        _choosedAnswer = 3;
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _choosedAnswer == 0
          ? null
          : SizedBox(
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // if (currentIndex != 0)
                  //   IconButton(
                  //     onPressed: () {
                  //       setState(() {});
                  //       _choosedAnswer = 0;
                  //       currentIndex = currentIndex != 0 ? currentIndex - 1 : 0;
                  //     },
                  //     icon: const Icon(Icons.arrow_back_ios_rounded),
                  //   ),
                  // if (currentIndex == 0) const SizedBox(),
                  ElevatedButton(
                    onPressed: _choosedAnswer != 0
                        ? () {
                            if (currentIndex + 1 == questionPage.length) {
                              print("finish");
                              choosedAnswersList.forEach((element) {
                                print(element.choosedIndex);
                                print(element.correctIndex);
                                print(element.isCorrect);
                              });
                            } else {
                              setState(() {
                                _choosedAnswer = 0;
                                currentIndex =
                                    currentIndex != (questionPage.length - 1)
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
                  // if (currentIndex != (questionPage.length - 1))
                  //   IconButton(
                  //     onPressed: () {
                  //       setState(() {});
                  //       _choosedAnswer = 0;
                  //       currentIndex = currentIndex != (questionPage.length - 1)
                  //           ? currentIndex + 1
                  //           : (questionPage.length - 1);
                  //     },
                  //     icon: const Icon(Icons.arrow_forward_ios_rounded),
                  //   ),
                  // if (currentIndex == (questionPage.length - 1)) const SizedBox(),
                ],
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
}

class ChoosedAnswers {
  final int? choosedIndex;
  final bool? isCorrect;
  final int? correctIndex;

  ChoosedAnswers(
      {required this.choosedIndex,
      required this.isCorrect,
      required this.correctIndex});
}
