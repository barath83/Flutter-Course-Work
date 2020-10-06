import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransanction extends StatefulWidget {
  
  final Function addTx;
   
  NewTransanction(this.addTx);

  @override
  _NewTransanctionState createState() => _NewTransanctionState();
}

class _NewTransanctionState extends State<NewTransanction> {

  final _titleController = TextEditingController();
  final  _amountConttoller = TextEditingController();
  DateTime _selectedDate;

  void _submitData()
  {
      if(_amountConttoller.text.isEmpty){
        return;
      }
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountConttoller.text);
      if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate == null){
        return;
      }

      widget.addTx(enteredTitle,enteredAmount,_selectedDate);

      Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now()).then((pickedDate) {
        if(pickedDate == null){
          return;
        }

        setState(() {
          _selectedDate = pickedDate;
        });
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                top:10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom+10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                    //onChanged: (val) {
                    //  titleInput = val;
                   // },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountConttoller,
                    keyboardType: TextInputType.number,
                    //We get the argument onsubmitted by default but we don't use it for our data
                    onSubmitted: (_) => _submitData(),
                    //onChanged: (val) => amountInput = val,
                    ),
                    Container(
                    height : 70,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                            _selectedDate == null ?'No Date Chosen.': 'Selected Date : ${DateFormat.yMMMd().format(_selectedDate)}'),
                        ), 
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            ),
                            ),
                          onPressed: _presentDatePicker,
                          ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child:Text('Add Transaction'),
                    color: Theme.of(context).primaryColor,
                    onPressed: _submitData,
                    textColor: Colors.white,
                    ),  
                ],
              ),
            ),
          ),
    ); 
  }
}