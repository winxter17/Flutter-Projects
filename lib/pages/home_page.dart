import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/todo_tile.dart';

import '../util/create_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //refer box
  final _mybox = Hive.box("mybox");
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState

    //check for first usage
    if (_mybox.get("todolist")==null ){
      db.initializeList();
    }
    else{
      db.loadData();
    }
    super.initState();
  }

  //controller
  final _controller =TextEditingController();
  
  //onchange for checkbox
  void checkboxChanged(bool? value, int index){
    setState(() {
      db.TodoList[index][1]=!db.TodoList[index][1];
      if (db.TodoList[index][1]==true){
        List l1 = db.TodoList[index];
        db.TodoList.removeAt(index);
        db.TodoList.add(l1);
      }
    });
    db.updateDatabase();
  }
  //delete tile
  void deletet(int index){
    setState(() {
      db.TodoList.removeAt(index);
    });
    db.updateDatabase();
  }
  //save new task
  void saveNewTask(){
    setState(() {
      db.TodoList.add([_controller.text,false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateDatabase();
  }
  //new task creation
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(controller: _controller,
      onSave: saveNewTask,
        onCancel:()=> {Navigator.of(context).pop(),
          _controller.clear()},
      );
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Center(child: Text("TO DO")),
        backgroundColor: Colors.yellow,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[700],
        onPressed: createNewTask,
      ),
      body: ListView.builder(
        itemCount: db.TodoList.length,
        itemBuilder: (context, index){
          return TodoTile(taskname: db.TodoList[index][0],
              checkValue: db.TodoList[index][1],
              onChanged: (value)=> checkboxChanged(value, index),
            deleteTile: ()=>deletet(index),
          );
        },
      )
    );
  }
}
