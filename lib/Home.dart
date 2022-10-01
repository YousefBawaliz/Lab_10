import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:quizapp/answer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoretracker = // doesn't work will fix later
      []; // keep track of selected answer is right or wrong
  int _questionIndex = 0; //choose which question to display
  int _totalScore = 0; //keep track of score
  bool answerIsSelected = false; //gonna be always false before the user selects it and red or green is displayed
  bool endofquiz= false;

  void questionAnswered(bool answerScore){

    setState(() {
      //when answer is selected:
      answerIsSelected = true; 
      //is answer correct ?
      if(answerScore=true){
        _totalScore++;
      }
      //add score tracker
      _scoretracker.add(
        answerScore ? Icon(Icons.check_circle, color: Colors.green,) : Icon(Icons.clear, color: Colors.red,)
      );
      //check if quiz ended
      if(_questionIndex+1 == _questions.length){
        endofquiz= true;
      }
    });
  }

  void _nextQuestion(){
    setState(() {
      _questionIndex++;
      answerIsSelected = false;  //to reset the answered colors
    });
    //at end of quiz
    if (_questionIndex >= _questions.length){
      _resetQuiz();
    }
  }

  void _resetQuiz(){
    setState(() {
      _questionIndex= 0; //go back to the first question
      _totalScore = 0; //reset score
      _scoretracker = []; //reset tracker (this is isn't working now)
      endofquiz = false; // we're back at the start 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QUIZ APP"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                )
              ],
            ),

            ///
            ///Question container
            ///
            Container(
              child: Text(
                _questions[_questionIndex]['question'].toString(),
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              width: double.infinity,
              height: 140,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),

            ///
            ///we use spread operator to iterate over the answers
            ///.map iterates over each of the answers represented by the variable(answer)
            /// (answer) represents the iteration of each element
            ///
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, dynamic>>)
                .map(
              (answer) => Answer(
                answertext: answer['answerText'].toString(),
                answercolor: answerIsSelected ? answer['score']?Colors.green: Colors.red : Colors.white,
                answertap: (){
                  if(answerIsSelected){  //this is to prevent the quiz progressing if i press the same answer again after it is answered 
                    return;
                  }

                  questionAnswered(answer['score']);},
              ),
            ),

            SizedBox(
              height: 25,
            ),

            ElevatedButton(
              
              onPressed: () {
                if(!answerIsSelected){
                  return;
                }
                 _nextQuestion();


              },  
              child: Text(endofquiz ? 'restart quiz' : 'Next question'),
              style: ElevatedButton.styleFrom(),
            ),

            Container(
              padding: EdgeInsets.all(20.0),
              child: Text("${_totalScore.toString()}/${_questions.length}"
              
              ,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'What is the largest active volcano in the world?',
    'answers': [
      {'answerText': 'Mouna Loa', 'score': true},
      {'answerText': 'Mount Vesuvius', 'score': false},
      {'answerText': 'Mount Batur', 'score': false},
    ],
  },
  {
    'question':
        'In which month does the German festival of Oktoberfest mostly take place?',
    'answers': [
      {'answerText': 'January', 'score': false},
      {'answerText': 'October', 'score': false},
      {'answerText': 'September', 'score': true},
    ],
  },
  {
    'question': 'In which museum can you find Leonardo Da Vinci’s Mona Lisa?',
    'answers': [
      {'answerText': 'Le Louvre', 'score': true},
      {'answerText': 'Uffizi Museum', 'score': false},
      {'answerText': 'British Museum', 'score': false},
    ],
  },
  {
    'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': false},
      {'answerText': 'Fried chicken', 'score': true},
      {'answerText': 'Pizza', 'score': false},
    ],
  },
  {
    'question':
        'What is the largest canyon in the world?',
    'answers': [
      {'answerText': 'Grand Canyon, USA', 'score': true},
      {'answerText': 'Verdon Gorge, France', 'score': false},
      {'answerText': 'King’s Canyon, Australia', 'score': false},
    ],
  },
  {
    'question': 'In which country are Panama hats made?',
    'answers': [
      {'answerText': 'Ecuador', 'score': true},
      {'answerText': 'Panama (duh)', 'score': false},
      {'answerText': 'Portugal', 'score': false},
    ],
  },
  {
    'question': 'From which country do French fries originate?',
    'answers': [
      {'answerText': 'Belgium', 'score': true},
      {'answerText': 'France (duh)', 'score': false},
      {'answerText': 'Switzerland', 'score': false},
    ],
  },
  {
    'question': 'Which sea creature has three hearts?',
    'answers': [
      {'answerText': 'Great White Sharks', 'score': false},
      {'answerText': 'Killer Whales', 'score': false},
      {'answerText': 'The Octopus', 'score': true},
    ],
  },
  {
    'question': 'Which European country eats the most chocolate per capita?',
    'answers': [
      {'answerText': 'Belgium', 'score': false},
      {'answerText': 'The Netherlands', 'score': false},
      {'answerText': 'Switzerland', 'score': true},
    ],
  },
];
