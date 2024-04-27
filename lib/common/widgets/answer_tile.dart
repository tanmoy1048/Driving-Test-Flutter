import 'package:flutter/material.dart';

const List<Widget> icons = [
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

Widget answerTile(int answerindex, String answer, int correctAnswer,
    int _choosedAnswer, void Function()? onTap) {
  return Card(
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: ListTile(
      leading: _choosedAnswer == 0 || _choosedAnswer > 3
          ? icons[2]
          : _choosedAnswer == answerindex && _choosedAnswer == correctAnswer
              ? icons[0]
              : _choosedAnswer == answerindex && _choosedAnswer != correctAnswer
                  ? icons[1]
                  : _choosedAnswer != correctAnswer &&
                          answerindex == correctAnswer
                      ? icons[0]
                      : icons[2],
      title: Text(answer),
      onTap: onTap,
    ),
  );
}
