import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _result = '';
      } else if (value == '=') {
        try {
          _result = _evaluateExpression(_input);
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _input += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp =
          p.parse(expression.replaceAll('x', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm).toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              color: Colors.blueGrey[50],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _input,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _result,
                    style: TextStyle(fontSize: 24, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Expanded(
            flex: 2,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                final buttons = [
                  '7',
                  '8',
                  '9',
                  '÷',
                  '4',
                  '5',
                  '6',
                  'x',
                  '1',
                  '2',
                  '3',
                  '-',
                  'C',
                  '0',
                  '=',
                  '+',
                ];
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.blueGrey),
                      ),
                    ),
                    onPressed: () => _onButtonPressed(buttons[index]),
                    child: Text(
                      buttons[index],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
