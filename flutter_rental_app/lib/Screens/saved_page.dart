import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Views/grid_widgets.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';


class saved_page extends StatefulWidget {

  saved_page({Key key}) : super(key: key);

  @override
  _saved_page_state createState() => _saved_page_state();
}

class _saved_page_state extends State<saved_page> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 3/4,
        ),
        itemBuilder: (context, index) {
          return Stack(
              children: [
                posting_grid_tile(),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.clear,color: Colors.black,),
                      ),
                    ),
                  ),
                ),
          ]
          );
        },
      ),
    );
  }
}
