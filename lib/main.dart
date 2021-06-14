import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Screen 1'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String value = "";
    List<String> values = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (text) {
                  value = text;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextButton(
                  onPressed: () {
                    values.add(value);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScreenList(values: values)));
                  },
                  child: Text("Switch")),
              SizedBox(
                height: 8,
              ),
              // ScreenList(values: values)
            ],
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  // const Screen2({Key? key}) : super(key: key);
  String value;
  Screen2({required this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen2"),
      ),
      body: Center(
        child: Text("$value"),
      ),
    );
  }
}

class Screen3 extends StatefulWidget {
  // const Screen2({Key? key}) : super(key: key);
  String value;
  Screen3({required this.value});

  @override
  _Screen3State createState() => _Screen3State(value);
}

class _Screen3State extends State<Screen3> {
  String value;
  _Screen3State(this.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen3"),
      ),
      body: Center(
        child: Text("$value"),
      ),
    );
  }
}

class ScreenList extends StatefulWidget {
  // const Screen2({Key? key}) : super(key: key);
  List<String> values;
  ScreenList({required this.values});

  @override
  _ScreenListState createState() => _ScreenListState(values);
}

class _ScreenListState extends State<ScreenList> {
  List<String> values;
  _ScreenListState(this.values);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Screen List"),
        ),
        body: ListView.builder(
            itemCount: this.values.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(values[index]),
              );
            }));
  }
}
