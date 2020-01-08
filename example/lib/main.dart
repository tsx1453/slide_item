import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slide_item/slide_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Item {
  Color color;
  int index;

  Item(this.color, this.index);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> colors;

  @override
  void initState() {
    super.initState();
    Random random = Random();
    colors = List.generate(
        30,
        (index) => Item(
            Color.fromARGB(255, random.nextInt(255), random.nextInt(255),
                random.nextInt(255)),
            index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SlideConfiguration(
        config: SlideConfig(
            slideOpenAnimDuration: Duration(milliseconds: 200),
            slideCloseAnimDuration: Duration(milliseconds: 400),
            deleteStep1AnimDuration: Duration(milliseconds: 250),
            deleteStep2AnimDuration: Duration(milliseconds: 300),
            supportElasticity: true,
            closeOpenedItemOnTouch: true,
            slideProportion: 0.2,
            actionOpenThreshold: 0.3,
            backgroundColor: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (_, index) => Builder(
              builder: (_) {
                print('debug -> build at builder $index');
                return SlideItem(
                  slidable: index % 5 != 0,
                  indexInList: index,
                  child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.person_outline),
                              Text('index ${colors[index].index}')
                            ],
                          ),
                          Container(
                            height: (colors[index].index % 6 + 3) * 14.0,
                            color: colors[index].color,
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      print('debug -> click at item ${colors[index].index}');
                    },
                  ),
                  actions: <SlideAction>[
                    if (index % 2 == 0)
                      SlideAction(
                          actionWidget: Container(
                            child: Icon(Icons.gamepad),
                            color: Colors.purple,
                          ),
                          tapCallback: (_) {
                            print('debug -> click at gamepad ${_.indexInList}');
                            _.close();
                          }),
                    SlideAction(
                        actionWidget: Container(
                          child: Icon(Icons.delete),
                          color: Colors.blue,
                        ),
                        tapCallback: (_) {
                          print('debug -> click at delete ${_.indexInList}');
                          _.delete().then((_) {
                            print('debug -> ${colors[index].index} removed');
                            setState(() {
                              colors.removeAt(index);
                            });
                          });
                        },
                        isDeleteButton: true),
                    if (index % 3 == 0)
                      SlideAction(
                          actionWidget: Container(
                            child: Icon(Icons.directions),
                            color: Colors.orange,
                          ),
                          tapCallback: (_) {
                            print(
                                'debug -> click at directions ${_.indexInList}');
                            _.close();
                          }),
                  ],
                );
              },
            ),
            itemCount: colors.length,
          ),
        ),
      ),
    );
  }
}
