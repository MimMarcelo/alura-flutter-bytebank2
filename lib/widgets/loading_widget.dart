
import 'package:flutter/material.dart';

class LoadingWidget{
  static Widget getCircularLoading({String message = "Loading..."}){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(message),
          )
        ],
      ),
    );
  }
}