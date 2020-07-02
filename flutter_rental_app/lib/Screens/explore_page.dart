import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/data.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Screens/view_posting_page.dart';
import 'package:flutterrentalapp/Views/grid_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class explore_page extends StatefulWidget {



  explore_page({Key key}) : super(key: key);

  @override
  _explore_page_state createState() => _explore_page_state();
}

class _explore_page_state extends State<explore_page> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom:50.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(5.0)),
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection('postings').snapshots(),
              builder: (context,snapshots){
                switch (snapshots.connectionState){
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    return GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshots.data.documents.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 3/4,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snapshot = snapshots.data.documents[index];
                        Posting currentPosting = Posting(id: snapshot.documentID);
                        currentPosting.getPostingInfoFromSnapshot(snapshot);
                        return InkResponse(
                          enableFeedback: true,
                          child: posting_grid_tile(posting: currentPosting),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => view_posting_page(posting: currentPosting),
                              ),
                            );
                          },
                        );
                      },
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
