import 'package:flutter/material.dart';
import 'package:tictactoe/boardtile.dart';
import 'package:tictactoe/tilestate.dart';
//ignore_for_file:prefer_const_constructors

void main()
{
  runApp(Myapp());
}
class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  var _boardstate= List.filled(9, Tilestate.Empty);
  var _currenturn= Tilestate.Cross;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: Scaffold(

        body: Center(
          child: Stack(
              children:[
                Image.asset('images/1.png'),
                _boardtile()

              ]),
        ),
      ),
    );
  }
 Widget _boardtile(){
    return Builder(builder: (context){
      final boarddimention= MediaQuery.of(context).size.width;
      final tiledimention= boarddimention/3;
      return Container(
        width: boarddimention,
        height: boarddimention,
        child: Column(
          children: chunk(_boardstate, 3).asMap().entries.map((entry){
            final chunkIndex = entry.key;
            final tileStateChunk = entry.value;
            return Row(
                children: tileStateChunk.asMap().entries.map((innerEntry){
              final innerIndex = innerEntry.key;
              final tileState = innerEntry.value;
              final tileIndex = (chunkIndex * 3) + innerIndex;
              return BoardTile(
                tilestate: tileState,
                dimention: tiledimention,
                onpressed: (){_updateTileforindex(tileIndex);},
              );
            }).toList(),
            );

      }).toList()));
    });
 }
 void _updateTileforindex(int selectedindx){
    if(_boardstate[selectedindx]==Tilestate.Empty)
      {
        setState(() {
            _boardstate[selectedindx]=_currenturn;
            _currenturn= _currenturn == Tilestate.Cross?Tilestate.Circle:Tilestate.Cross;
        });
        final winner = _findwinner();
        if(winner!=null)
          {
            print("Winner is $winner");
            _showWinnerDialog(winner);
          }
      }

}
Tilestate ?_findwinner(){
var winnerformatch=(a,b,c){
   if(_boardstate[a]!=Tilestate.Empty)
     {
       if((_boardstate[a]==_boardstate[b])&&(_boardstate[b]==_boardstate[c])){
         return _boardstate[a];
       }
     }
   return null;
};
final checks = [
  winnerformatch(0,1,2),
winnerformatch(3,4,5),
winnerformatch(6,7,8),
winnerformatch(0,3,6),
winnerformatch(1,4,7),
  winnerformatch(2,5,8),
  winnerformatch(0,4,8),
  winnerformatch(2,4,6),

];
Tilestate? winner;
for(int i=0;i<checks.length;i++)
  {
    if(checks[i]!=null)
      {
        winner=checks[i];
        break;
      }
  }
return winner;
}
  void _showWinnerDialog(Tilestate tileState) {
    final context = navigatorKey.currentState!.overlay!.context;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Winner'),
            content: Image.asset(
                tileState == Tilestate.Cross ? 'images/x.png' : 'images/o.png'),
            actions: [
              FlatButton(
                  onPressed: () {
                    _resetGame();
                    Navigator.of(context).pop();
                  },
                  child: Text('New Game'))
            ],
          );
        });
  }
  void _resetGame() {
    setState(() {
      _boardstate = List.filled(9, Tilestate.Empty);
      _currenturn = Tilestate.Cross;
    });
  }
}
