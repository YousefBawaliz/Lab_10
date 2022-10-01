import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  


final String answertext; // get the text of the answer
final Color answercolor;
final VoidCallback? answertap;

Answer({required this.answertext, required this.answercolor, required this.answertap});
  @override
  Widget build(BuildContext context) {

    //inkwell gets you tap funcionalty over what u wrapped it over
    return InkWell(
              onTap: answertap,
              child: Container(
                child: Text(answertext),
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: answercolor,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            );
  }
}