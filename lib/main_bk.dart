import 'dart:math';

import 'package:flutter/material.dart';

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
      home: MyQuizPage(),
    );
  }
}

class MyQuizPage extends StatefulWidget {
  MyQuizPage({Key? key}) : super(key: key);

  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  var isDataInit = false;
  var numberOfChoices = 3;
  var multipleChoices = [];
  var correctAnswer = -1;
  var choicedAnswer = -1;
  var answerState = 0;
  var totalPoints = 0;

  String getImageUrl(key) {
    return "images/$key.png";
  }

  void refresher() {
    answerState = 0;
    multipleChoices = [];
    var random = Random();
    var randomNumber = random.nextInt(9) + 1;
    correctAnswer = randomNumber;
    multipleChoices.add(correctAnswer);
    while (multipleChoices.length < numberOfChoices) {
      randomNumber = random.nextInt(9) + 1;
      if (!multipleChoices.contains(randomNumber)) {
        multipleChoices.add(randomNumber);
      }
    }
    multipleChoices = multipleChoices..shuffle();
  }

  void initUI() {
    if (!isDataInit) {
      totalPoints = 0;
      refresher();
    }
    isDataInit = true;
  }

  List<Widget> getImageWidgets() {
    List<Widget> widgets = [];
    for (var num in multipleChoices) {
      widgets.add(
        const SizedBox(
          width: 10,
          height: 30,
        ),
      );
      widgets.add(InkWell(
        onTap: () {
          if (answerState == 0) {
            setState(() {
              if (num == correctAnswer) {
                totalPoints += 10;
                answerState++;
              }
              answerState++;
            });
          }
        }, // Handle your callback.
        child: Ink(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$num.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    initUI();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assignment-1 Random Quizer"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Please select $correctAnswer",
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                ),
              ),
            ),
            ...getImageWidgets(),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Text(
              answerState == 2
                  ? "Your answer is correct"
                  : answerState == 1
                      ? "Your answer is not correct"
                      : "",
              style: TextStyle(
                color: answerState == 2 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            OutlinedButton(
              onPressed: (() {
                refresher();
                setState(() {});
              }),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.deepOrange,
                  width: 2,
                ),
              ),
              child: const Text(
                "NEXT",
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
              height: 10,
            ),
            Text(
              "Score: $totalPoints",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
