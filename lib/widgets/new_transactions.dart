import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addtransaction;

  NewTransactions(this.addtransaction);

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titlecontroller = TextEditingController();

  final pricecontoller = TextEditingController();
  DateTime PickedDate;

  @override
  void submitdata() {
    if(pricecontoller == null){
      return ;
    }
    final enteredtitle = titlecontroller.text;
    final enteredprice = double.parse(pricecontoller.text);
    if (enteredtitle.isEmpty || enteredprice <= 0 || PickedDate == null) {
      return;
    }
    widget.addtransaction(enteredtitle, enteredprice, PickedDate  );
    Navigator.of(context).pop();
  }

  void presentdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((selecteddate) {
      if (selecteddate == null) {
        return;
      }
      setState(() {
        PickedDate = selecteddate;
      });
    });
    print('...');
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titlecontroller,
                onSubmitted: (_) => submitdata,
                // onChanged: (values){
                // titleinput = values;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'price'),
                controller: pricecontoller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitdata,
                // onChanged: (values)=> priceinput = values,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        PickedDate == null
                            ? 'no date chosen'
                            : 'PickedDate : ${DateFormat.yMd().format(PickedDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.deepOrange,
                      onPressed: presentdatepicker,
                      child: Text(
                        'Choose  Date',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(150),
                  shape: BoxShape.circle,
                ),
                child: RaisedButton(
                    onPressed: submitdata,
                    color: Colors.black87,
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(
                          color: Colors.purpleAccent, fontFamily: 'OpenSans'),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
