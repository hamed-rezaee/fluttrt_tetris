import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/pixel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Direction _direction = Direction.noune;
  List<int> _currentBlock = blocks[Random().nextInt(blocks.length)];
  List<int> _previousBlocks = [];

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(milliseconds: 300), (_) {
      _moveBlock();

      if (_checkCollosion()) {
        _previousBlocks.addAll(_currentBlock);

        _currentBlock = _getBloc();
      }

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
                    for (final int component in _currentBlock)
                      if (component == index) return Pixel(color: Colors.white);

                    for (final int component in _previousBlocks)
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
                          onPressed: () => _direction = Direction.left,
                        ),
                        RaisedButton(
                          child: Icon(Icons.arrow_right),
                          onPressed: () => _direction = Direction.right,
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

  List<int> _getBloc() => blocks[Random().nextInt(blocks.length)];

  void _moveBlock() {
    switch (_direction) {
      case Direction.noune:
        for (int i = 0; i < _currentBlock.length; i++) {
          _currentBlock[i] += 10;
        }

        break;
      case Direction.left:
        for (int i = 0; i < _currentBlock.length; i++) {
          _currentBlock[i] -= 1;

          _direction = Direction.noune;
        }

        break;
      case Direction.right:
        for (int i = 0; i < _currentBlock.length; i++) {
          _currentBlock[i] += 1;

          _direction = Direction.noune;
        }

        break;
    }
  }

  bool _checkCollosion() {
    if (_currentBlock.reduce(max) + 10 > 140) {
      return true;
    }

    for (final int component in _currentBlock) {
      if (_previousBlocks.contains(component + 10)) {
        return true;
      }
    }

    return false;
  }
}

final List<List<int>> blocks = [
  [4, 5, 14, 15],
  [5, 15, 25, 26],
  [5, 14, 15, 16, 25],
  [3, 4, 5, 6],
];

enum Direction {
  noune,
  right,
  left,
}
