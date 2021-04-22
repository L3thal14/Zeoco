import 'package:ZEOCO/ZeocoApp/apptheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
    color: FinalAppTheme.nearlyDarkBlue, //change your color here
  ),
          title: Text(
            "LeaderBoard",
            style: TextStyle(color: FinalAppTheme.nearlyDarkBlue),
          ),
          backgroundColor: FinalAppTheme.background,
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection("leaderboard")
              .orderBy('carbonfootprint')
              .limit(10)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              return new ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  padding: const EdgeInsets.only(top: 5.0),
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    return new Container(
                        height: 80,
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: ListTile(
                            title: Text(
                              '${ds['username']}'.replaceAll('null', ''),
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              ds['carbonfootprint'.replaceAll('null', '')]
                                  .toStringAsFixed(2),
                              style: TextStyle(fontSize: 15),
                            ),
                            leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    '${ds['photo']}'.replaceAll('null', ''))),
                          ),
                        ));
                  });
            }
            return Text('Hello');
          },
        ));
  }
}
