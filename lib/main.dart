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
  final int _maxValue = 100;
  final TextEditingController _controller = TextEditingController();
  String _message = "";
  List<int> _counterHistory = [];

  Color _getCounterColor() {
    if (_counter == 0) {
      return Colors.red;
    } else if (_counter > 50) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _counterHistory.add(_counter);
        _message = "";
      }
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
      _counterHistory.add(_counter);
      _message = "";
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
      if (_counter + _incrementValue <= _maxValue) {
        _counter += _incrementValue;
        _counterHistory.add(_counter);
        _message = "";
      } else {
        _counter = _maxValue;
        _message = "Maximum limit reached!";
      }
    });
  }

  void _undo() {
    setState(() {
      if (_counterHistory.isNotEmpty) {
        _counterHistory.removeLast();
        if (_counterHistory.isNotEmpty) {
          _counter = _counterHistory.last;
        } else {
          _counter = 0;
        }
      }
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
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: 50.0, color: _getCounterColor()),
              ),
            ),
          ),
          if (_message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _message,
                style: TextStyle(color: Colors.red, fontSize: 16.0),
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
            max: _maxValue.toDouble(),
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: Colors.green,
            inactiveColor: Colors.lightGreen,
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
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _undo,
                child: Text("Undo"),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text("Counter History:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: _counterHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${_counterHistory[index]}", style: TextStyle(fontSize: 16)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
