import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initialization,
        builder: (ctx, snapshot) {
          if (snapshot.hasError) return Text('Error');
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          return ListView.builder(
            itemBuilder: (ctx, idx) => Container(
              padding: EdgeInsets.all(8),
              child: Text('This works...'),
            ),
            itemCount: 10,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('/chats/E0vOYGJGAsXmGSe7wkBx/messages')
              .snapshots()
              .listen(
            (event) {
              event.docs.forEach((element) {
                print(element['text']);
              });
            },
          );
        },
      ),
    );
  }
}
