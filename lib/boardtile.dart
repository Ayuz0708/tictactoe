import 'package:flutter/material.dart';
import 'package:tictactoe/tilestate.dart';
class BoardTile extends StatelessWidget {
  final Tilestate tilestate;
  final double dimention;
  final VoidCallback onpressed;
  const BoardTile({Key? key, required this.dimention,required this.onpressed,required this.tilestate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimention,
      height: dimention,
      child: FlatButton(
        onPressed: onpressed,
        child: _widgetForTileState(),
      ),
    );
  }
  Widget _widgetForTileState() {
    Widget widget;

    switch (tilestate) {
      case Tilestate.Empty:
        {
          widget = Container();
        }
        break;

      case Tilestate.Cross:
        {
          widget = Image.asset('images/x.png');
        }
        break;

      case Tilestate.Circle:
        {
          widget = Image.asset('images/o.png');
        }
        break;
    }

    return widget;
  }
}
