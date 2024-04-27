import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/answer_tile.dart';
import '../../service/const.dart';
import '../favorite/favorite_viewmodel.dart';
import '../home/home_viewmodel.dart';

class DetailsPageHome extends StatefulWidget {
  const DetailsPageHome({super.key, required this.initIndex});
  final int initIndex;

  @override
  State<DetailsPageHome> createState() => _DetailsPageHomeState();
}

class _DetailsPageHomeState extends State<DetailsPageHome> {
  int _choosedAnswer = 0;
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initIndex;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Question ${currentIndex + 1} out of ${viewModel.questions.length}",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).hintColor)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              viewModel
                  .favoriteAction(
                id: viewModel.questions[currentIndex].id,
                isFav: viewModel.questions[currentIndex].favorite == 1
                    ? false
                    : true,
                index: currentIndex,
              )
                  .then((value) {
                context.read<FavoriteViewModel>().getData();
              });
            },
            icon: Icon(
              viewModel.questions[currentIndex].favorite == 1
                  ? Icons.favorite
                  : Icons.favorite_outline,
              color: viewModel.questions[currentIndex].favorite == 1
                  ? Colors.red
                  : null,
            ),
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
                      viewModel.questions[currentIndex].question,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                    ),
                  ),
                  if (viewModel.questions[currentIndex].image != 0)
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                      constraints:
                          BoxConstraints.loose(Size(double.maxFinite, 260)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        "assets/images/${Strings.questionImages[viewModel.questions[currentIndex].image - 1]}.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10),
            answerTile(
              1,
              viewModel.questions[currentIndex].answer1,
              viewModel.questions[currentIndex].answer,
              _choosedAnswer,
              _choosedAnswer == 0
                  ? () {
                      setState(() {
                        _choosedAnswer = 1;
                      });
                    }
                  : null,
            ),
            answerTile(
              2,
              viewModel.questions[currentIndex].answer2,
              viewModel.questions[currentIndex].answer,
              _choosedAnswer,
              _choosedAnswer == 0
                  ? () {
                      setState(() {
                        _choosedAnswer = 2;
                      });
                    }
                  : null,
            ),
            answerTile(
              3,
              viewModel.questions[currentIndex].answer3,
              viewModel.questions[currentIndex].answer,
              _choosedAnswer,
              _choosedAnswer == 0
                  ? () {
                      setState(() {
                        _choosedAnswer = 3;
                      });
                    }
                  : null,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (currentIndex != 0)
              IconButton(
                onPressed: () {
                  setState(() {});
                  _choosedAnswer = 0;
                  currentIndex = currentIndex != 0 ? currentIndex - 1 : 0;
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
              ),
            if (currentIndex == 0) SizedBox(),
            ElevatedButton(
              onPressed: _choosedAnswer == 0
                  ? () {
                      setState(() {
                        _choosedAnswer =
                            viewModel.questions[currentIndex].answer;
                      });
                    }
                  : null,
              child: Text("Show Answer"),
            ),
            if (currentIndex != (viewModel.questions.length - 1))
              IconButton(
                onPressed: () {
                  setState(() {});
                  _choosedAnswer = 0;
                  currentIndex =
                      currentIndex != (viewModel.questions.length - 1)
                          ? currentIndex + 1
                          : (viewModel.questions.length - 1);
                },
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            if (currentIndex == (viewModel.questions.length - 1)) SizedBox(),
          ],
        ),
      ),
    );
  }

  // static const List<Widget> icons = [
  //   Icon(
  //     Icons.check_circle_outline,
  //     color: Colors.green,
  //   ),
  //   Icon(
  //     Icons.cancel_outlined,
  //     color: Colors.red,
  //   ),
  //   Icon(
  //     Icons.circle_outlined,
  //   ),
  // ];

  // Widget answerTile(int answerindex, String answer, int correctAnswer) {
  //   return Card(
  //     clipBehavior: Clip.hardEdge,
  //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  //     child: ListTile(
  //       leading: _choosedAnswer == 0 || _choosedAnswer > 3
  //           ? icons[2]
  //           : _choosedAnswer == answerindex && _choosedAnswer == correctAnswer
  //               ? icons[0]
  //               : _choosedAnswer == answerindex &&
  //                       _choosedAnswer != correctAnswer
  //                   ? icons[1]
  //                   : _choosedAnswer != correctAnswer &&
  //                           answerindex == correctAnswer
  //                       ? icons[0]
  //                       : icons[2],
  //       title: Text(answer),
  //       onTap: _choosedAnswer == 0
  //           ? () {
  //               setState(() {
  //                 _choosedAnswer = answerindex;
  //               });
  //             }
  //           : null,
  //     ),
  //   );
  // }
}
