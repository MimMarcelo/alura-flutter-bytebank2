
import 'package:flutter/material.dart';

class LoadingWidget{
  static Widget getCircularLoading(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text("Loading data")
        ],
      ),
    );
  }
}