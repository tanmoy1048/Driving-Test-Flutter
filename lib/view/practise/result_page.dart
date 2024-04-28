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
      body: Column(
        children: [
          Text("$correctAnswer/15"),
          Text("Time: ${formattedDurationText(widget.duration)}"),
        ],
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
