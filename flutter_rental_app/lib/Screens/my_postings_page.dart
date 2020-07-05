import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Screens/create_posting_page.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';



class my_postings_page extends StatefulWidget {
  my_postings_page({Key key}) : super(key: key);

  @override
  _my_postings_page_state createState() => _my_postings_page_state();
}

class _my_postings_page_state extends State<my_postings_page> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ListView.builder(
        itemCount: AppConstants.currentUser.myPostings.length+1,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.fromLTRB(25,0,25,25),
              child: InkResponse(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => create_posting_page(
                          posting: (index == AppConstants.currentUser.myPostings.length) ?
                          null : AppConstants.currentUser.myPostings[index],
                        ),
                      )
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                    child: index == AppConstants.currentUser.myPostings.length ?
                    create_posting_list_tile() :
                    my_posting_list_tile(posting: AppConstants.currentUser.myPostings[index],)
                ),
              ),
            );
          }
      ),
    );
  }

}
