import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> gridPiece = ["", "", "", "", "", "", "", "", ""];
  bool playerTurn = true; //true is x, false is o
  int xWins = 0;
  int oWins = 0;
  String previousWinner = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe",
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Player O"),
                      Text(oWins.toString())
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Player X"),
                      Text(xWins.toString())
                    ],
                  ),
                )
              ],
            )),
          ),
          Expanded(
            flex: 4,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      isTapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black)),
                      ),
                      child: Center(
                        child: Text(gridPiece[index],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50)),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(previousWinner),
            ],
          )))
        ],
      ),
    );
  }

//isTapped() is called as a result of an individual box being tapped
// it determines whether to put X or O
// bool playerturn is true for X, false for O
//also prevents a box from changing between X and O
  void isTapped(int index) {
    setState(() {
      if (gridPiece[index] != "") {
        //do nothing
      } else if (playerTurn) {
        gridPiece[index] = "X";
        playerTurn = false;
      } else {
        gridPiece[index] = "O";
        playerTurn = true;
      }
    });
    gameLogic();
  }

//gameLogic() checks if there is a winner
// adds it to the scoreboard when found, and resets gameBoard
//8 possible ways to win that must be checked
  void gameLogic() {
    if (gridPiece[0] == gridPiece[1] &&
        gridPiece[1] == gridPiece[2] &&
        gridPiece[0] != "") {
      scoreBoardUpdate(gridPiece[0]);
    } else if (gridPiece[3] == gridPiece[4] &&
        gridPiece[4] == gridPiece[5] &&
        gridPiece[3] != "") {
      scoreBoardUpdate(gridPiece[3]);
    } else if (gridPiece[6] == gridPiece[7] &&
        gridPiece[7] == gridPiece[8] &&
        gridPiece[6] != "") {
      scoreBoardUpdate(gridPiece[6]);
    } else if (gridPiece[0] == gridPiece[3] &&
        gridPiece[3] == gridPiece[6] &&
        gridPiece[0] != "") {
      scoreBoardUpdate(gridPiece[0]);
    } else if (gridPiece[1] == gridPiece[4] &&
        gridPiece[4] == gridPiece[7] &&
        gridPiece[1] != "") {
      scoreBoardUpdate(gridPiece[1]);
    } else if (gridPiece[2] == gridPiece[5] &&
        gridPiece[5] == gridPiece[8] &&
        gridPiece[2] != "") {
      scoreBoardUpdate(gridPiece[2]);
    } else if (gridPiece[0] == gridPiece[4] &&
        gridPiece[4] == gridPiece[8] &&
        gridPiece[0] != "") {
      scoreBoardUpdate(gridPiece[0]);
    } else if (gridPiece[2] == gridPiece[4] &&
        gridPiece[4] == gridPiece[6] &&
        gridPiece[2] != "") {
      scoreBoardUpdate(gridPiece[2]);
    } else {
      //checks for draw
      int count = 0;
      for (int i = 0; i <= 8; i++) {
        if (gridPiece[i] != "") {
          count++;
        }
      }
      if (count == 9) {
        //true means its a draw
        setState(() {
          previousWinner = "Previous match was a draw";
          resetBoard();
        });
      } 
    }
  }

  //updates the scoreboard + displays winner of previous match + resetsBoard
  void scoreBoardUpdate(String temp) {
    setState(() {
      if (temp == "X")
        xWins++;
      else
        oWins++;
      previousWinner =
          "Player " + "$temp" + " is the winner of the previous match";
    });
    resetBoard();
  }

  void resetBoard() {
    setState(() {
      gridPiece = ["", "", "", "", "", "", "", "", ""];
    });
  }
}
