

import 'package:flutter/material.dart';
import 'package:flutter_app1/constant/router_path.dart';
import 'package:flutter_app1/model/note.dart';
import 'package:flutter_app1/note_provider.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:flutter_app1/util/dbmanager.dart';
import 'package:flutter_app1/widget/text_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>NoteProvider(),
      child: NewTaskScreenWidget(),
    );
  }
}


class NewTaskScreenWidget extends StatefulWidget {
  @override
  _NewTaskScreenStateWidget createState() => _NewTaskScreenStateWidget();
}

class _NewTaskScreenStateWidget extends State<NewTaskScreenWidget> {
  final _fromState = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  final _priorityController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final dateFormat = DateFormat('dd-MM-yyyy');
  DbManager _dbManager = DbManager();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Constants.backgroundMain),
        //change icon color drawer
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "New task ".toUpperCase(),
          style: TextStyle(color: Constants.backgroundMain,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Constants.backgroundApp,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xffFFDBDB),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Write here....",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Color(0xff65FFDBDB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Consumer<NoteProvider>(
                builder: (BuildContext context, NoteProvider value, Widget child) {
                  return Form(
                    key: _fromState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextForm("Prority"),

                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff243B6B),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: _priorityController,
                            validator: (val)=>val.isNotEmpty ? null : "Priority should not be empty",
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextForm("Complete by "),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xff243B6B),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            validator: (val)=>val.isNotEmpty ? null : "Date should not be empty",
                            keyboardType: TextInputType.datetime,
                            controller: _dateTimeController,
                            onTap: () => _selectDate(context),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        backgroundColor: Constants.backgroundMain,
        onPressed: () => addNote(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateTimeController.value =
            TextEditingValue(text: dateFormat.format(picked));
      });
  }

  addNote() {
    if(_fromState.currentState.validate()){
      Provider.of<NoteProvider>(context,listen: false).addNote(_priorityController.text, _dateTimeController.text);
      Navigator.of(context).pushNamed(DashBoardRoute);
      _scaffold.currentState.showSnackBar(SnackBar(content: Text("Successful"),));
    }
  }
}
