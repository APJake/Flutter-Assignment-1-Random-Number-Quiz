import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_quiz/components/ImageButtons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: SelectNumber(),
    );
  }
}

class SelectNumber extends StatefulWidget {
  SelectNumber({Key? key}) : super(key: key);

  @override
  State<SelectNumber> createState() => _SelectNumberState();
}

class _SelectNumberState extends State<SelectNumber> {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int score = 0;
  int correctAnswer = 0;

  Widget imageButtonList(List<int> images) => Column(
        children: images
            .map((e) => ImageButton(
                correctAnswer: correctAnswer,
                value: e,
                onImageTap: (sc) {
                  setState(() {
                    score += sc;
                  });
                }))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    numbers.shuffle();
    List<int> numberOptions = numbers.sublist(0, 3);
    correctAnswer = numberOptions[0];
    numberOptions.shuffle();

    return Scaffold(
      appBar: AppBar(title: const Text("Select Number")),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Please select number $correctAnswer"),
            imageButtonList(numberOptions),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("Refresh"),
            ),
            Text("Your score is $score")
          ],
        ),
      ),
    );
  }
}
