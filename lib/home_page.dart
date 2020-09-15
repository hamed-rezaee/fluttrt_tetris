import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/pixel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> currentBlock = blocks[0];

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 5000), (_) {
      currentBlock = _getBloc();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: 140,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    for (final int component in currentBlock)
                      if (component == index) return Pixel(color: Colors.white);

                    return Pixel(color: Colors.grey[900]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        RaisedButton(
                          child: Icon(Icons.settings_backup_restore),
                          onPressed: () {},
                        ),
                        RaisedButton(
                          child: Icon(Icons.arrow_left),
                          onPressed: () {},
                        ),
                        RaisedButton(
                          child: Icon(Icons.arrow_right),
                          onPressed: () {},
                        ),
                        RaisedButton(
                          child: Icon(Icons.rotate_left),
                          onPressed: () {},
                        ),
                        RaisedButton(
                          child: Icon(Icons.rotate_right),
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  List<int> _getBloc() => blocks[Random().nextInt(4)];
}

final List<List<int>> blocks = [
  [4, 5, 14, 15],
  [4, 14, 24, 25],
  [4, 13, 14, 15, 24],
  [3, 4, 5, 6],
];
