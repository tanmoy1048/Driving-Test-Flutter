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
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initIndex;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 0,
                left: 10,
                right: 10,
              ),
              child: Text(
                "Question ${currentIndex + 1} out of ${viewModel.questions.length}",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Text(
                viewModel.questions[currentIndex].question,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold, fontFamily: "Nunito"),
              ),
            ),
            if (viewModel.questions[currentIndex].image != 0)
              Image.asset(
                "assets/images/i_${viewModel.questions[currentIndex].image}.png",
                fit: BoxFit.contain,
              ),
          ],
        ),
      ),
    );
  }
}
