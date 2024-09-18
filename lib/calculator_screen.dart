import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = '';  
  String result = '';      


  void onButtonPress(String input) {
    setState(() {
      if (input == '=') {
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          result = eval.toString();  
        } catch (e) {
          result = 'Error';  
        }
      } else if (input == 'C') {
        expression = '';  
        result = '';      
      } else {
        expression += input;  
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
         
          Container(
            height: 80,  
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                expression,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
          ),
          
          Container(
            height: 60,  
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              result,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Divider(thickness: 2),
          
          Expanded(
            child: Column(
              children: [
                
                _buildButtonRow(['7', '8', '9', '/']),
                
                _buildButtonRow(['4', '5', '6', '*']),
                
                _buildButtonRow(['1', '2', '3', '-']),
                
                _buildButtonRow(['0', '.', '=', '+']),
                
                _buildButtonRow(['C']),
              ],
            ),
          ),
        ],
      ),
    );
  }

 
  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((label) => _buildButton(label)).toList(),
      ),
    );
  }

  
  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => onButtonPress(label),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20), backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,  
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
