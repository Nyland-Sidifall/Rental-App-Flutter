import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';

class create_posting_page extends StatefulWidget {
  static final String routeName = '/createPostingPageRoute';
  final Posting posting;

  create_posting_page({this.posting, Key key}) : super(key: key);

  @override
  _create_posting_page_state createState() => _create_posting_page_state();
}

class _create_posting_page_state extends State<create_posting_page> {
  final List<String> _houseTypes = [
    'Detatched House',
    'Apartment',
    'Condo',
    'Town House',
  ];

  TextEditingController _nameController;
  TextEditingController _priceController;
  TextEditingController _descriptionController;
  TextEditingController _addressController;
  TextEditingController _cityController;
  TextEditingController _countryController;
  TextEditingController _amenitiesController;

  String _houseType;
  Map<String,int> _beds;
  Map<String,int> _bathrooms;
  List<AssetImage> _images;

  void _setUpInitialValues(){
    if(widget.posting ==null){
      _nameController = TextEditingController(text: "");
      _priceController = TextEditingController(text: "");
      _descriptionController = TextEditingController(text: "");
      _addressController = TextEditingController(text: "");
      _cityController = TextEditingController(text: "");
      _countryController = TextEditingController(text: "");
      _amenitiesController = TextEditingController(text: "");
      _beds = {
        'small' : 0,
        'medium' : 0,
        'large' : 0
      };
      _bathrooms = {
        'full' : 0,
        'half' : 0,
      };
      _images = [];
    }else{
      _nameController = TextEditingController(text: widget.posting.name);
      _priceController = TextEditingController(text: widget.posting.price.toString());
      _descriptionController = TextEditingController(text: widget.posting.description);
      _addressController = TextEditingController(text: widget.posting.address);
      _cityController = TextEditingController(text: widget.posting.city);
      _countryController = TextEditingController(text: widget.posting.country);
      _amenitiesController = TextEditingController(text: widget.posting.getAmenititesString());
      _beds = widget.posting.beds;
      _bathrooms = widget.posting.bathrooms;
      _images = widget.posting.displayImages;
    }
    setState(() {

    });
  }

  @override
  void initState() {
    _setUpInitialValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Create a Posting'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Post to Market",
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: "Posting Name"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _nameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: DropdownButton(
                          items: _houseTypes.map((type) {
                            return DropdownMenuItem(
                                value: type,
                                child: Text(
                                  type,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ));
                          }).toList(),
                          onChanged: (value) {},
                          isExpanded: true,
                          value: _houseType,
                          hint: Text(
                            "Select a home type",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(labelText: "Price"),
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                                keyboardType: TextInputType.number,
                                controller: _priceController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, bottom: 10.0),
                              child: Text(
                                "\$ / night",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Description"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _descriptionController,
                          maxLines: 3,
                          minLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Address"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _addressController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "City"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _cityController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Country"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _countryController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Beds',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Column(
                            children: <Widget>[
                              facilities_widget(
                                type: 'Twin/Single',
                                startValue: _beds['small'],
                              ),
                              facilities_widget(
                                type: 'Double',
                                startValue: _beds['medium'],
                              ),
                              facilities_widget(
                                type: 'Queen/King',
                                startValue: _beds['large'],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Bathrooms',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                        child: Column(
                          children: <Widget>[
                            facilities_widget(
                              type: 'Full',
                              startValue: _bathrooms['full'],
                            ),
                            facilities_widget(
                              type: 'Half',
                              startValue: _bathrooms['half'],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Amenitites, (coma separated)"),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _amenitiesController,
                          maxLines: 3,
                          minLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Photos',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: _images.length+1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 25,
                              crossAxisSpacing: 25,
                              childAspectRatio: 3 / 2,
                            ),
                            itemBuilder: (context, index) {
                              if (index == _images.length) {
                                return Container(
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                );
                              }
                              return MaterialButton(
                                onPressed: () {},
                                child: Image(
                                  image: _images[index],
                                  fit: BoxFit.fill,
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class facilities_widget extends StatefulWidget {
  final String type;
  final int startValue;

  facilities_widget({Key key, this.type, this.startValue}) : super(key: key);

  @override
  _facilities_widget_state createState() => _facilities_widget_state();
}

class _facilities_widget_state extends State<facilities_widget> {
  int _value;

  @override
  void initState() {
    this._value = widget.startValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.type,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {},
            ),
            Text(
              this._value.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
