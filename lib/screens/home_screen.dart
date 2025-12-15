import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widget/buttons.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onThemeChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
  });

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
      appBar: AppBar(

        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: widget.onThemeChanged,
          ),
        ],
      ),
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

                if (text == 'DEL') {
                  return MyButton(
                    buttonText: text,
                    color: Colors.red,
                    textColor: Colors.white,
                    buttonTapped: () {
                      if (userQuestion.isNotEmpty) {
                        setState(() {
                          userQuestion =
                              userQuestion.substring(0, userQuestion.length - 1);
                        });
                      }
                    },
                  );
                }

                if (text == '=') {
                  return MyButton(
                    buttonText: text,
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    buttonTapped: equalPressed,
                  );
                }

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

                return MyButton(
                  buttonText: text,
                  color: isOperator(text)
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade50,
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
      double eval = exp.evaluate(EvaluationType.REAL, ContextModel());

      setState(() {
        userAnswer = eval.toString();
      });
    } catch (_) {
      setState(() {
        userAnswer = 'Error';
      });
    }
  }
}
