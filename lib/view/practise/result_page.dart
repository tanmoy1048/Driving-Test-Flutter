import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../database/model/question_model.dart';
import 'practise_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    super.key,
    required this.duration,
    required this.questions,
    required this.choosedAnswersList,
  });
  final Duration duration;
  final List<QuestionModel> questions;
  final List<ChoosedAnswers> choosedAnswersList;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int correctAnswer = 0;
  @override
  void initState() {
    super.initState();

    for (var item in widget.choosedAnswersList) {
      if (item.isCorrect ?? false) {
        correctAnswer = correctAnswer + 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Quiz Result",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontFamily: "Nunito"),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/result_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   "Quiz Result",
              //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              //       fontWeight: FontWeight.bold, fontFamily: "Nunito"),
              // ),
              Container(
                height: 200,
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Image.asset(
                  "assets/images/winner.png",
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                "Congratulations!",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold, fontFamily: "Nunito"),
              ),
              SizedBox(height: 20),
              Text(
                "YOUR SCORE",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.normal,
                      //fontFamily: "Nunito",
                      color: Theme.of(context).hintColor,
                    ),
              ),
              Text(
                "$correctAnswer / 15",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold, fontFamily: "Nunito"),
              ),
              Text(
                "Time: ${formattedDurationText(widget.duration)}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.normal,
                      //fontFamily: "Nunito",
                      color: Theme.of(context).hintColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
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
