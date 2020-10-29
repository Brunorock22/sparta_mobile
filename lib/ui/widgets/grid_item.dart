import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  Widget image;
  String title;
  Function function;

  GridItem(this.image, this.title, this.function);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(
            color: Colors.grey,
            width: 0.5,
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                image,
                SizedBox(
                  height: 12,
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 30,
                      minWidth: 0,
                    ),
                    child: Text(title,
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
