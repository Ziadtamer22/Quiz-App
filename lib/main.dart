import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  var score = 0.0;
  var currentQuestion = 0;
  List<double> lastScore = [];
  var s = 0.0;

  List<String> dateTime = [];
  List questions = [
    Question(
      id: 0,
      question: 'What is your favourite color?',
      rightAnswer: 'Red',
      wrongAnswer: ['Green', 'Black', "Yellow"],
    ),
    Question(
      id: 1,
      question: 'What is your hoppy?',
      rightAnswer: 'Codding',
      wrongAnswer: ['Football', 'Basketball', "Tennies"],
    ),
    Question(
      id: 2,
      question: 'What is your favourite club?',
      rightAnswer: 'RealMadrid',
      wrongAnswer: ['Liverpool', 'Man City', "Paris SG"],
    ),
    Question(
      id: 3,
      question: 'What is your insturctor?',
      rightAnswer: 'Eslam',
      wrongAnswer: ['Maxmillain', 'Abdallah Mansour', "Hassen Filah"],
    ),
  ];

  List answers() {
    return [
      questions[currentQuestion].rightAnswer,
      ...questions[currentQuestion].wrongAnswer
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Application',
          style: TextStyle(
            color: Colors.lightBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: currentQuestion == questions.length
            ? [
                Text(
                  'Good Work!, Your Score is:',
                  style: TextStyle(fontSize: 28, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 25),
                Text(
                  '$score',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                buildButton(
                    text: 'Retray Again',
                    onPressed: () {
                      setState(() {
                        currentQuestion = 0;
                        s = score;
                        lastScore.add(s);
                        score = 0.0;
                        DateTime now = new DateTime.now();
                        var formatter = DateFormat.jm();
                        String formattedDate = formatter.format(now);

                        dateTime.add(formattedDate);
                      });
                    })
              ]
            : [
                history(
                    title: 'History',
                    icon: Icons.access_time,
                    last: lastScore,
                    date: dateTime),
                const Spacer(),
                _buildTitleSection(
                    title: 'Question', icon: Icons.question_mark_rounded),
                const Spacer(),
                Text(
                  questions[currentQuestion].question,
                  style: const TextStyle(fontSize: 28, color: Colors.grey),
                ),
                const Spacer(),
                _buildTitleSection(title: 'Answers', icon: Icons.done),
                const Spacer(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: answers().length,
                  itemBuilder: (ctx, i) => buildButton(
                    text: answers()[i],
                    onPressed: () {
                      setState(() {
                        currentQuestion++;
                        if (i == 0) {
                          score += 10;
                        }
                      });
                    },
                  ),
                ),
                const Spacer(flex: 6),
              ],
      ),
    );
  }

  Row _buildTitleSection({required String title, required icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 8),
        Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(255, 96, 244, 4)),
          child: Icon(icon, color: Color.fromARGB(255, 255, 7, 139), size: 35),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ],
    );
  }

  Column history(
      {required String title,
      required icon,
      required List last,
      required List date}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Row(children: [
        const SizedBox(width: 8),
        Container(
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(255, 240, 3, 3)),
          child: Icon(icon, color: Color.fromARGB(255, 6, 40, 236), size: 35),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(fontSize: 24, color: Colors.black),
        ),
      ]),
      Text(
        "$dateTime",
        style: const TextStyle(fontSize: 24, color: Colors.black),
      ),
      const SizedBox(width: 8),
      Text(
        "$lastScore",
        style: const TextStyle(fontSize: 24, color: Colors.black),
      ),
    ]);
  }

  Widget buildButton({required String text, required Function() onPressed}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                    (states) => const EdgeInsets.all(16))),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
}

class Question {
  Question({
    required this.id,
    required this.question,
    required this.rightAnswer,
    required this.wrongAnswer,
  });
  int id;
  String question;
  String rightAnswer;
  List wrongAnswer;
}
