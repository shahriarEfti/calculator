import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../widget/buttons.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userQuestion = '';
  String userAnswer = '';

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'Ans', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userAnswer,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                final text = buttons[index];

                // Clear
                if (text == 'C') {
                  return MyButton(
                    buttonText: text,
                    color: Colors.green,
                    textColor: Colors.white,
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                        userAnswer = '';
                      });
                    },
                  );
                }

                // Delete
                if (text == 'DEL') {
                  return MyButton(
                    buttonText: text,
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonTapped: () {
                      if (userQuestion.isNotEmpty) {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      }
                    },
                  );
                }

                // Equals
                if (text == '=') {
                  return MyButton(
                    buttonText: text,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    buttonTapped: equalPressed,
                  );
                }

                // Ans
                if (text == 'Ans') {
                  return MyButton(
                    buttonText: text,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    buttonTapped: () {
                      setState(() {
                        userQuestion += userAnswer;
                      });
                    },
                  );
                }

                // Normal buttons
                return MyButton(
                  buttonText: text,
                  color: isOperator(text)
                      ? Colors.deepPurple
                      : Colors.deepPurple[50]!,
                  textColor: isOperator(text)
                      ? Colors.white
                      : Colors.deepPurple,
                  buttonTapped: () {
                    setState(() {
                      userQuestion += text;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    return x == '+' || x == '-' || x == 'x' || x == '/' || x == '%';
  }

  void equalPressed() {
    if (userQuestion.isEmpty) return;

    try {
      String finalQuestion = userQuestion.replaceAll('x', '*');
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);

      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        userAnswer = eval.toString();
      });
    } catch (e) {
      setState(() {
        userAnswer = 'Error';
      });
    }
  }
}
