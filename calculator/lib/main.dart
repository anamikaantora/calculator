import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculator',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SimpleCalculator());
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⊕") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("⊕", 1, Colors.teal),
                      buildButton("÷", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.redAccent),
                      buildButton("8", 1, Colors.teal),
                      buildButton("9", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.redAccent),
                      buildButton("5", 1, Colors.teal),
                      buildButton("6", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("3", 1, Colors.redAccent),
                      buildButton("2", 1, Colors.teal),
                      buildButton("1", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.redAccent),
                      buildButton("0", 1, Colors.teal),
                      buildButton("00", 1, Colors.teal),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.teal),
                    ]),
                    TableRow(children: [
                      buildButton("=", 1, Colors.teal),
                    ])
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
