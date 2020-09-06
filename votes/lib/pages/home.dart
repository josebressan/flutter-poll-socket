import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:votes/models/poll.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Poll> polls = [
    Poll(id: '1', name: 'Jose', votes: 2),
    Poll(id: '2', name: 'Jocelyn', votes: 4),
    Poll(id: '3', name: 'Emily', votes: 3),
    Poll(id: '4', name: 'Owen', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('Who will wash the dishes today?', style: TextStyle( color: Colors.black87),),
        backgroundColor: Colors.white,
        ),
      body: ListView.builder(
        itemCount: polls.length,
        itemBuilder: (context,  i) => _pollTile(polls[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewPoll
      ),
     );   
  }

  Widget _pollTile(Poll poll) {
    return Dismissible(
          key: Key(poll.id),
          direction: DismissDirection.startToEnd,
          onDismissed: ( direction ) {
            print('direction: $direction');
            print('id: ${ poll.id }');
          },
          background: Container(
            padding: EdgeInsets.only(left: 8.0),
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Delete Poll Option', style: TextStyle(color: Colors.white),),
            ),
          ),
          child: ListTile(
          leading: CircleAvatar(
            child: Text(poll.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(poll.name),
          trailing: Text('${poll.votes}', style: TextStyle(fontSize: 20,)),
          onTap: () {
            print(poll.name);
          },
          ),
    );
  }

  addNewPoll() {

    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: ( context ) {
            return AlertDialog(
              title: Text('New Poll Option'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Add'),
                  textColor: Colors.blue,
                  elevation: 5,
                  onPressed: () => addPollToList(textController.text)                
                  )
              ],
            );
        }
        );
    }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ) {
        return CupertinoAlertDialog(
              title: Text('New Poll Option'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: () => addPollToList(textController.text)     
                  ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context)
                  ),                  
              ],
        );
      }
    );
  }

void addPollToList (String name) {
  if (name.length > 1){
    //Podemos Agregar
    this.polls.add( new Poll(
      id: DateTime.now().toString(),
      name: name,
      votes: 0,
    ));
    setState(() {});
  }

  Navigator.pop(context);
}

}
