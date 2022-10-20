import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  final Map<String, dynamic>? doctorMap;
  final String chatRoomId;

  ChatRoom({required this.chatRoomId, this.doctorMap});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  bool isloading = false;
  String name = '';

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser;
    // ignore: deprecated_member_use
    var vari = await FirebaseFirestore.instance
        .collection("Doctors")
        .doc(user!.uid)
        .get();
    if (mounted)
      setState(() {
        if (vari.data() != null) {
          name = vari.data()!['D_Name'].toString();
        }
      });
  }

  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": name,
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
      };
      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter some text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("doctorname"), //doctorMap!['D_Name']
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height / 1.25,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats')
                      .orderBy("time", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: ((context, index) {
                            return Text(snapshot.data?.docs[index]['message']);
                            // return messages(sizep);
                          }));
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Container(
                height: size.height / 10,
                width: size.width,
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 12,
                  width: size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height / 17,
                        width: size.width / 1.3,
                        child: TextField(
                          controller: _message,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send), onPressed: onSendMessage),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
