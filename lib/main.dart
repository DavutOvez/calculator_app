import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CalculatorPage());
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _output = "0";
  String _currentNumber = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";
  bool _clearOnNextInput = false;

  void _buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      _currentNumber = "";
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
      _clearOnNextInput = false;
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
      if (_currentNumber.isNotEmpty) {
        _num1 = double.parse(_currentNumber);
        _operand = buttonText;
        _clearOnNextInput = true;
      }
    } else if (buttonText == ".") {
      if (!_currentNumber.contains(".")) {
        _currentNumber += buttonText;
      }
    } else if (buttonText == "=") {
      if (_currentNumber.isNotEmpty && _operand.isNotEmpty) {
        _num2 = double.parse(_currentNumber);

        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        }
        if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        }
        if (_operand == "x") {
          _output = (_num1 * _num2).toString();
        }
        if (_operand == "/") {
          if (_num2 != 0) {
            _output = (_num1 / _num2).toString();
          } else {
            _output = "Error";
          }
        }

        if (_output != "Error") {
          _num1 = double.parse(_output);
        }

        _operand = "";
        _clearOnNextInput = true;
      }
    } else {
      if (_clearOnNextInput) {
        _currentNumber = buttonText;
        _clearOnNextInput = false;
      } else {
        if (_currentNumber == "0" && buttonText != ".") {
          _currentNumber = buttonText;
        } else {
          _currentNumber += buttonText;
        }
      }
    }

    setState(() {
      if (buttonText != "=" && buttonText != "CLEAR") {
        _output = _currentNumber.isEmpty ? "0" : _currentNumber;
      }

      if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }
    });
  }

  Widget buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              alignment: Alignment.bottomRight,
              color: Colors.black,
              child: Text(
                _output,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(height: 1.0, color: Colors.red[700]),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("7", Colors.grey[850]!),
                  buildButton("8", Colors.grey[850]!),
                  buildButton("9", Colors.grey[850]!),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.grey[850]!),
                  buildButton("5", Colors.grey[850]!),
                  buildButton("6", Colors.grey[850]!),
                  buildButton("x", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.grey[850]!),
                  buildButton("2", Colors.grey[850]!),
                  buildButton("3", Colors.grey[850]!),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton(".", Colors.grey[850]!),
                  buildButton("0", Colors.grey[850]!),
                  buildButton("00", Colors.grey[850]!),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("CLEAR", Colors.redAccent),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}