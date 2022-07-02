import 'package:flutter/material.dart';
import 'package:tic_tae_toe/constants/color.dart';
import 'package:tic_tae_toe/models/game_logic.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastValue = 'X';
  bool gameOver = false;
  int turn = 0; // to check the draw
  String result = "";
  List<int> scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
  Game game = Game();
  @override
  void initState() {
    // implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board);
  }

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "It's ${lastValue} turn".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: Game.boardLength ~/ 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(
                Game.boardLength,
                (index) => InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                          if (game.board![index].isEmpty) {
                            setState(() {
                              game.board![index] = lastValue;
                              turn++;
                              gameOver = game.checkWinner(
                                  lastValue, index, scoreBoard, 3);
                              if (gameOver) {
                                result = "$lastValue wins";
                              } else if (!gameOver && turn == 9) {
                                result = "Draw";
                                gameOver = true;
                              }
                              if (lastValue == "X")
                                lastValue = "O";
                              else
                                lastValue = "X";
                            });
                          }
                        },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == 'X'
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 64,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            result,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                MainColor.secondaryColor,
              ),
            ),
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                gameOver = false;
                turn = 0;
                result = "";
                scoreBoard = [0, 0, 0, 0, 0, 0, 0, 0];
              });
            },
            icon: Icon(Icons.replay),
            label: Text('Restart'),
          ),
        ],
      ),
    );
  }
}
