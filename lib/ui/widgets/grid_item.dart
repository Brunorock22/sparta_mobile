import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  Widget image;
  String title;
  Function function;

  GridItem(this.image, this.title, this.function);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: function,
        child: Container(
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
                      style: TextStyle(color: Colors.black38, fontFamily: 'Montserrat'),                        textAlign: TextAlign.center)),
            ],
          ),
            height: double.infinity,
            width: 150,
            margin:
                const EdgeInsets.only(bottom: 15, right: 15, left: 15, top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            )));
  }
}
