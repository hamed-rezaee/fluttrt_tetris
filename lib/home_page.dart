import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tetris/pixel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> _currentBlock;
  Direction _direction;
  List<int> _previousBlocks;

  Timer _gameTimer;

  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    _restart();
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
                      if (component == index) return Pixel(color: Colors.red);

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
                          onPressed: _restart,
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

  List<int> _getBloc() => List.from(blocks[Random().nextInt(blocks.length)]);

  void _restart() {
    _currentBlock =
        _getBloc().map((final int element) => element - 10).toList();
    _direction = Direction.noune;
    _previousBlocks = [];

    _gameTimer?.cancel();

    _gameTimer = Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      if (_checkCollision()) {
        _previousBlocks.addAll(List.from(_currentBlock));

        if (_currentBlock.reduce(min) < 10) {
          gameOver = true;
        }

        if (gameOver) {
          timer.cancel();
        } else {
          _currentBlock = _getBloc();
        }
      } else {
        _moveBlock();
      }

      setState(() {});
    });
  }

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

  bool _checkCollision() {
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
  [4, 14, 24, 25],
  [5, 14, 15, 16, 25],
  [3, 4, 5, 6],
];

enum Direction {
  noune,
  right,
  left,
}
