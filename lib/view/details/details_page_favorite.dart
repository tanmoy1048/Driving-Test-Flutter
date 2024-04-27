import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/answer_tile.dart';
import '../../database/model/question_model.dart';
import '../../service/const.dart';
import '../favorite/favorite_viewmodel.dart';

class DetailsPageFavorite extends StatefulWidget {
  const DetailsPageFavorite(
      {super.key, required this.initIndex, required this.favQuestions});
  final int initIndex;
  final List<QuestionModel> favQuestions;

  @override
  State<DetailsPageFavorite> createState() => _DetailsPageFavoriteState();
}

class _DetailsPageFavoriteState extends State<DetailsPageFavorite> {
  int _choosedAnswer = 0;
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initIndex;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoriteViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Question ${currentIndex + 1} out of ${widget.favQuestions.length}",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).hintColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              viewModel
                  .favoriteAction(
                id: widget.favQuestions[currentIndex].id,
                isFav: widget.favQuestions[currentIndex].favorite == 1
                    ? false
                    : true,
                index: currentIndex,
              )
                  .then((value) {
                Navigator.of(context).pop();
              });
            },
            icon: Icon(
              widget.favQuestions[currentIndex].favorite == 1
                  ? Icons.favorite
                  : Icons.favorite_outline,
              color: widget.favQuestions[currentIndex].favorite == 1
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
                      widget.favQuestions[currentIndex].question,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Nunito"),
                    ),
                  ),
                  if (widget.favQuestions[currentIndex].image != 0)
                    Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 15),
                      constraints: BoxConstraints.loose(
                          const Size(double.maxFinite, 260)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        "assets/images/${Strings.questionImages[widget.favQuestions[currentIndex].image - 1]}.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            answerTile(
              1,
              widget.favQuestions[currentIndex].answer1,
              widget.favQuestions[currentIndex].answer,
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
              widget.favQuestions[currentIndex].answer2,
              widget.favQuestions[currentIndex].answer,
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
              widget.favQuestions[currentIndex].answer3,
              widget.favQuestions[currentIndex].answer,
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
      bottomNavigationBar: SizedBox(
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
                icon: const Icon(Icons.arrow_back_ios_rounded),
              ),
            if (currentIndex == 0) const SizedBox(),
            ElevatedButton(
              onPressed: _choosedAnswer == 0
                  ? () {
                      setState(() {
                        _choosedAnswer =
                            widget.favQuestions[currentIndex].answer;
                      });
                    }
                  : null,
              child: const Text("Show Answer"),
            ),
            if (currentIndex != (widget.favQuestions.length - 1))
              IconButton(
                onPressed: () {
                  setState(() {});
                  _choosedAnswer = 0;
                  currentIndex =
                      currentIndex != (widget.favQuestions.length - 1)
                          ? currentIndex + 1
                          : (widget.favQuestions.length - 1);
                },
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            if (currentIndex == (widget.favQuestions.length - 1))
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
