import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoDatabase{
  List TodoList=[];

  //refer box
final _mybox = Hive.box("mybox");

// when someone opens app for first time
void initializeList(){
  TodoList=[["<--Mark done",false],["Delete task-->",false]];
}
//load data to database
void loadData(){
  TodoList= _mybox.get("todolist");
}
//update database
void updateDatabase(){
  _mybox.put("todolist", TodoList);
}

}