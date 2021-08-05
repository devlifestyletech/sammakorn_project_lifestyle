import 'package:flutter/material.dart';

import '../../../constance.dart';

class StampButtonGroup extends StatelessWidget {
  final Function pass;

  const StampButtonGroup({
    Key key,
    this.pass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // CancelButton(),
        Center(
          child: ButtonTheme(
            minWidth: size.width * 0.3,
            child: OutlineButton(
              highlightedBorderColor: goldenSecondary,
              child: Text("Cancel", style: TextStyle(color: Colors.white)),
              borderSide: BorderSide(
                color: goldenSecondary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        // StampButton(),
        Center(
          child: ButtonTheme(
            minWidth: size.width * 0.3,
            child: RaisedButton(
              color: goldenSecondary,
              child: Text("Stamp", style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: pass,
            ),
          ),
        )
      ],
    );
  }
}
