import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Screens/create_posting_page.dart';
import 'package:flutterrentalapp/Views/list_widgets.dart';



class postings_page extends StatefulWidget {
  postings_page({Key key}) : super(key: key);

  @override
  _postings_page_state createState() => _postings_page_state();
}

class _postings_page_state extends State<postings_page> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ListView.builder(
        itemCount: 3,
          itemBuilder: (context,index){

            return Padding(
              padding: const EdgeInsets.fromLTRB(25,0,25,25),
              child: InkResponse(
                onTap: (){
                  Navigator.pushNamed(
                      context,
                      create_posting_page.routeName
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
                    child: index == 2 ? create_posting_list_tile() : my_posting_list_tile()
                ),
              ),
            );
          }
      ),
    );
  }

}
