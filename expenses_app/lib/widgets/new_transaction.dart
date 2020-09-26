import 'package:flutter/material.dart';


class NewTransanction extends StatefulWidget {
  
  final Function addTx;
   
  NewTransanction(this.addTx);

  @override
  _NewTransanctionState createState() => _NewTransanctionState();
}

class _NewTransanctionState extends State<NewTransanction> {
  final titleController = TextEditingController();

  final amountConttoller = TextEditingController();

  void submitData()
  {
      final enteredTitle = titleController.text;
      final enteredAmount = double.parse(amountConttoller.text);
      if(enteredTitle.isEmpty || enteredAmount<=0){
        return;
      }

      widget.addTx(enteredTitle,enteredAmount);

      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                  //onChanged: (val) {
                  //  titleInput = val;
                 // },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountConttoller,
                  keyboardType: TextInputType.number,
                  //We get the argument onsubmitted by default but we don't use it for our data
                  onSubmitted: (_) => submitData(),
                  //onChanged: (val) => amountInput = val,
                  ),
                FlatButton(
                  child:Text('Add Transaction'),
                  textColor: Colors.purple,
                  onPressed: submitData,
                  ),  
              ],
            ),
          ),
        ); 
  }
}