import 'package:flutter/material.dart';

typedef ImageButtonOnTap = void Function(int score);

class ImageButton extends StatelessWidget {
  int correctAnswer = 0;
  int value = 0;
  ImageButtonOnTap onImageTap;

  ImageButton(
      {Key? key,
      required this.correctAnswer,
      required this.value,
      required this.onImageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var tappedValue = value;
        var snackColor = Colors.red;
        var snackMessage = "Incorrect";
        var score = 0;
        if (tappedValue == correctAnswer) {
          snackMessage = "Correct";
          snackColor = Colors.green;
          score = 10;
        }
        final snackBar = SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: snackColor,
          content: Text(snackMessage),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        onImageTap(score);
      },
      child: Ink(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/$value.png"),
        )),
      ),
    );
  }
}
