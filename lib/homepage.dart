import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int filledBox = 0;
  int Xscore = 0;
  int Oscore = 0;
  int tieCounter = 0;
  List Board = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];  //game Board
  bool Xturn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("ScoreBoard",style:TextStyle(fontSize: 30,color:Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("X  :   ${Xscore}",style:TextStyle(fontSize: 25,color: Colors.white)),
                        Text("O  :  ${Oscore}",style:TextStyle(fontSize: 25,color:Colors.white))
                      ],
                    ),
                    Text("Tie      : ${tieCounter}",style:TextStyle(fontSize: 25,color: Colors.white))
                  ],
                )
            ),
            Expanded(
              flex:2,
              child: Padding(
                padding:EdgeInsets.all(10),
                child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context,int index) {
                  return GestureDetector(
                    onTap: () {
                      playerTurn(index);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border:Border.all(color:Colors.white)
                        ),
                        alignment: Alignment.center,
                        child:Text(Board[index],style:TextStyle(color:Colors.white,fontSize: 35))
                      //child:Text(index.toString(),style:TextStyle(color:Colors.white))
                    ),
                  );
                },itemCount: 9,
                ),
              ),
            ),
            Expanded(
              child:  TextButton(onPressed: () {
                reset();
              }, child: Text("Reset")),

            )
          ],
        )
    );
  }

  void playerTurn(int index) {
    setState(() {
      if(Xturn && Board[index]==''){
        Board[index] = 'X';
        Xturn = false;
        filledBox++;

      }else if(Board[index] == '' && !Xturn){
        Board[index] = 'O';
        Xturn = true;
        filledBox++;
      }
    });
    checkWinner();
  }
  // Winning logic
  void checkWinner(){
    if(Board[0] == Board[1] && Board[0] == Board[2] && Board[0]!=''){
      showDialogBox(Board[0]);
    }
    if(Board[3] ==Board[4] && Board[3] == Board[5] && Board[3]!=''){
      showDialogBox(Board[3]);
    }
    if(Board[6] ==Board[7] && Board[6] == Board[8] && Board[6]!=''){
      showDialogBox(Board[6]);
    }
    if(Board[0] ==Board[3] && Board[0] == Board[6] && Board[0]!=''){
      showDialogBox(Board[0]);
    }
    if(Board[1] ==Board[4] && Board[1] == Board[7] && Board[1]!=''){
      showDialogBox(Board[1]);
    }
    if(Board[2] ==Board[5] && Board[2] == Board[8] && Board[2]!=''){
      showDialogBox(Board[2]);
    }
    if(Board[0] ==Board[4] && Board[0] == Board[8] && Board[0]!=''){
      showDialogBox(Board[0]);
    }
    if(Board[2] ==Board[4] && Board[2] == Board[6] && Board[2]!=''){
      showDialogBox(Board[3]);
    }
    else if(filledBox > 8){
      tie();
    }
  }

  void showDialogBox(String winner,) {
    showDialog(context:context, builder:(BuildContext context){
      return AlertDialog(
        title:Text('Winner '+ winner),
        actions: [
          TextButton(onPressed: () {
            reset();
            Navigator.of(context).pop();
          }, child: Text("Reset"))
        ],
      );
    }
    );
    if(winner == 'X'){
      Xscore++;
    }else {
      Oscore++;
    }
    }


  void tie() {
    showDialog(context:context, builder:(BuildContext context){
      return AlertDialog(
        title:Text('It is a Tie'),
        actions: [
          TextButton(onPressed: () {
            reset();
            Navigator.of(context).pop();
          }, child: Text("Reset"))
        ],
      );
    }
    );
  }

  void reset() {
    setState(() {
      for(int i = 0;i<9;i++){
        Board[i] ='';
      }
      tieCounter++;
      filledBox = 0;
    });
  }
}

