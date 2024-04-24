import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_viewmodel.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.initIndex});
  final int initIndex;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 15.0,
            //     bottom: 0,
            //     left: 10,
            //     right: 10,
            //   ),
            //   child: Text(
            //     "Question ${currentIndex + 1} out of ${viewModel.questions.length}",
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context)
            //         .textTheme
            //         .titleMedium
            //         ?.copyWith(color: Theme.of(context).hintColor),
            //   ),
            // ),
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
                        "assets/images/i_${viewModel.questions[currentIndex].id}.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 10),
            answerTile(1, viewModel.questions[currentIndex].answer1,
                viewModel.questions[currentIndex].answer),
            answerTile(2, viewModel.questions[currentIndex].answer2,
                viewModel.questions[currentIndex].answer),
            answerTile(3, viewModel.questions[currentIndex].answer3,
                viewModel.questions[currentIndex].answer),
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
              onPressed: () {
                setState(() {
                  _choosedAnswer = viewModel.questions[currentIndex].answer;
                });
              },
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

  static const List<Widget> icons = [
    Icon(
      Icons.check_circle_outline,
      color: Colors.green,
    ),
    Icon(
      Icons.cancel_outlined,
      color: Colors.red,
    ),
    Icon(
      Icons.circle_outlined,
    ),
  ];

  Widget answerTile(int answerId, String answer, int correctAnswer) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: _choosedAnswer == 0 || _choosedAnswer > 3
            ? icons[2]
            : _choosedAnswer == answerId && _choosedAnswer == correctAnswer
                ? icons[0]
                : icons[2],
        title: Text(answer),
      ),
    );
  }
}
