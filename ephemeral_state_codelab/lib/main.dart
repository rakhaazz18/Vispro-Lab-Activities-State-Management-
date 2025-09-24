import 'package:flutter/material.dart';

void main() => runApp(MyEphemeralApp());

class MyEphemeralApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ephemeral State Codelab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Local State Management'),
          centerTitle: true,
        ),
        body: CounterWidget(),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Counter Value:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: _counter == 0 ? Colors.grey : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _counter > 0 ? _decrementCounter : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _counter > 0 ? Colors.red : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.remove, size: 18),
                    SizedBox(width: 4),
                    Text('Decrement', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 18),
                    SizedBox(width: 4),
                    Text('Increment', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Text(
              _counter == 0
                  ? 'Counter is at minimum value (0)'
                  : 'Counter can be decremented',
              style: TextStyle(
                fontSize: 14,
                color: _counter == 0 ? Colors.orange : Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
