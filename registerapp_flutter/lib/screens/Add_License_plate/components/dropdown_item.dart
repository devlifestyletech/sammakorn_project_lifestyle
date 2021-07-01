import 'package:flutter/material.dart';

import '../../../constance.dart';

class DropdownItem extends StatelessWidget {
  const DropdownItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String _chosenValue = "Visitor";

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 10),
            child: Text("Type",
                style: TextStyle(
                    color: goldenSecondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
          Center(
            child: Container(
              width: size.width * 0.8,
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: DropdownButton(
                isExpanded: true,
                value: _chosenValue,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                icon: Icon(Icons.expand_more, color: Colors.black),
                underline: Divider(color: Colors.transparent),
                items: [
                  'Visitor',
                  'Whitelist',
                  'Blacklist',
                ].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text("\t\t\t$value"),
                  );
                }).toList(),
                onChanged: (String value) {
                  _chosenValue = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
