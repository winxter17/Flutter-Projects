import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoTile extends StatelessWidget {

  //variables
  final String taskname;
  final bool checkValue;
  Function(bool?)? onChanged;
  Function()? deleteTile;

  TodoTile({

    super.key,
    required this.taskname,
    required this.checkValue,
    required this.onChanged,
    required this.deleteTile
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right:24.0, top: 24.0),
      child: Container(
        padding: EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                children: [
                  Checkbox(value: checkValue, onChanged: onChanged),
                  Text(" "+taskname+"  ",
                    style: TextStyle(decoration: checkValue
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
                  )
                ],
              ),
            GestureDetector(child:
            Icon(Icons.delete, color: Colors.red,),
              onTap: deleteTile,
            )
          ],
          
        ),

        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12)
        ),
      ),
    );
  }
}
