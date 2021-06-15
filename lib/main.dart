import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  List<String> values = ["11", "22"];
  String value = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Screen 1'),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => ScreenList(values: values),
        "/home": (context) => MyHomePage(values: values),
        // "/screen3": (context) => Screen3(value: value),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.values}) : super(key: key);

  String value = "";
  List<String> values;

  @override
  _MyHomePageState createState() => _MyHomePageState(this.values);
}

class _MyHomePageState extends State<MyHomePage> {
  String value = "";
  List<String> values;
  Map<dynamic, dynamic> data = {};
  TextEditingController textEditingController = TextEditingController();

  _MyHomePageState(this.values);

  @override
  Widget build(BuildContext context) {
    int currentIndex = -1;

    if (ModalRoute.of(context)!.settings.arguments != null) {
      data =
          ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
      textEditingController = TextEditingController()
        ..text = data["data"].toString();
      currentIndex = data["index"];
    }

    print(value);

    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: textEditingController,
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
                    if (currentIndex != -1) {
                      this.values[currentIndex] = value;
                    } else {
                      values.add(value);
                    }
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

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty('data', data));
  //   properties.add(DiagnosticsProperty('data', data));
  // }
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
          padding: EdgeInsets.all(12),
          itemCount: this.values.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/home",
                    arguments: {"index": index, "data": this.values[index]});
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => MyHomePage(values: this.values)));
              },
              child: ListTile(
                title: Text(values[index]),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            this.values.removeAt(index);
                          });
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //         MyHomePage(values: this.values)));
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyHomePage(
                      values: this.values,
                    )));
          },
          child: Icon(CupertinoIcons.add_circled)),
    );
  }
}
