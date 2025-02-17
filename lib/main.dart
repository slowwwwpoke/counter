import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  int _incrementValue = 1;
  final TextEditingController _controller = TextEditingController();

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  void _setIncrementValue(String value) {
    final int? newValue = int.tryParse(value);
    if (newValue != null && newValue > 0) {
      setState(() {
        _incrementValue = newValue;
      });
    }
  }

  void _increment() {
    setState(() {
      _counter += _incrementValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: 50.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Set Increment Value",
                border: OutlineInputBorder(),
              ),
              onChanged: _setIncrementValue,
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _increment,
                child: Text("Increment"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _decrement,
                child: Text("Decrement"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _reset,
                child: Text("Reset"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
