import 'package:flutter/material.dart';
import 'package:flutter_app1/main.dart';
import 'package:flutter_app1/model/note.dart';
import 'package:flutter_app1/note_provider.dart';
import 'package:flutter_app1/util/const.dart';
import 'package:flutter_app1/util/dbmanager.dart';

import 'package:flutter_app1/widget/text_form.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>NoteProvider(),
      child: NoteScreenWidget(),
    );
  }
}


class NoteScreenWidget extends StatefulWidget {
  @override
  _NoteScreenStateWidget createState() => _NoteScreenStateWidget();
}

class _NoteScreenStateWidget extends State<NoteScreenWidget> {
//  List<Note> arrNote;
  bool checked = false;
//  DbManager _dbManager = DbManager();
  final _scaffordState = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
      Provider.of<NoteProvider>(context,listen: false).getAllListNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffordState,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xffFFDBDB),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today's list",
                  style: TextStyle(
                      color: Constants.backgroundMain,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff65FFDBDB),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    FutureBuilder(
//                      future: _dbManager.getAllListNote(),
//                      builder: (BuildContext context, AsyncSnapshot snapshot) {
//                        if (snapshot.hasData) {
//                          arrNote = snapshot.data;
//                          return ListView.separated(
//                            shrinkWrap: true,
//                            physics: NeverScrollableScrollPhysics(),
//                            itemCount: arrNote.length,
//                            itemBuilder: (_, index) {
//                              Note note = arrNote[index];
//                              return Dismissible(
//                                child: ListTile(
//                                  onTap: () {},
//                                  leading: Icon(
//                                    Icons.add,
//                                    color: Colors.black,
//                                  ),
//                                  subtitle: Text(note.date),
//                                  title: TextForm(note.title),
//                                ),
//                                key: Key(UniqueKey().toString()),
//                                background: Container(
//
//                                  decoration: BoxDecoration(
//                                    color: Colors.red,
//                                    borderRadius: BorderRadius.circular(5),
//                                  ),
//                                  alignment: Alignment.center,
//                                  child: Center(
//                                    child: Icon(
//                                      Icons.delete,
//                                      size: 30,
//                                      color: Colors.white,
//                                    ),
//                                  ),
//                                ),
//                                onDismissed: (di) {
//                                  setState(() {
//                                    alertDialog(context, _dbManager, note);
//                                  });
//                                },
//                              );
//                            },
//                            separatorBuilder:
//                                (BuildContext context, int index) => Divider(
//                              height: 10,
//                              indent: 20,
//                              endIndent: 20,
//                              color: Colors.grey,
//                              thickness: .3,
//                            ),
//                          );
//                        }
//                        return CircularProgressIndicator();
//                      },
//                    ),

                  Consumer<NoteProvider>(
                    builder: (BuildContext context, NoteProvider value, Widget child) {
                      return  ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.arr.length,
                        itemBuilder: (_, index) {
                          return Dismissible(
                            child: ListTile(
                              onTap: () {

                              },
                              leading: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              subtitle: Text(value.arr[index].date),
                              title: TextForm(value.arr[index].title),
                            ),
                            key: Key(UniqueKey().toString()),
                            background: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Center(
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (di) {
                             setState(() {
                               alertDialog(context, value.arr[index].id);
                             });
                            },
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) => Divider(
                          height: 10,
                          indent: 20,
                          endIndent: 20,
                          color: Colors.grey,
                          thickness: .3,
                        ),
                      );
                    },
                  )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  alertDialog(BuildContext context, int id ) async {
    final delete = Provider.of<NoteProvider>(context,listen: false);
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(75),
                    bottomLeft: Radius.circular(75),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.network(
                          'http://thebeacontheatreva.com/wp-content/uploads/2019/02/warning-sign-lg-1024x1024.png'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          TextForm("Warning!"),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Are you sure delete todo? "),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: FlatButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: Constants.backgroundMain,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    onPressed: () async {
                                      delete.deleteNote(id);
                                      Navigator.of(context).pop();
                                    },
                                    color: Constants.backgroundMain,
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
