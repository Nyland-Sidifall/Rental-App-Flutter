import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterrentalapp/Models/AppConstants.dart';
import 'package:flutterrentalapp/Models/posting_objects.dart';
import 'package:flutterrentalapp/Screens/guest_home_page.dart';
import 'package:flutterrentalapp/Screens/host_home_page.dart';
import 'package:flutterrentalapp/Screens/my_postings_page.dart';
import 'package:flutterrentalapp/Views/text_widgets.dart';
import 'package:image_picker/image_picker.dart';

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

  final _formKey = GlobalKey<FormState>();

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
  List<MemoryImage> _images;

  void _selectImage(int index) async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if(imageFile != null){
      MemoryImage newImage = MemoryImage(imageFile.readAsBytesSync());
      if(index < 0){
        _images.add(newImage);
      }else{
        _images[index] = newImage;
      }
      setState(() {});
    }

  }

  void _savePosting(){
    if(!_formKey.currentState.validate()){return;}
    if(_houseType == null ){return;}
    if(_images.isEmpty){return;}
    Posting posting = Posting();
    posting.name = _nameController.text;
    posting.price = double.parse(_priceController.text);
    posting.description = _descriptionController.text;
    posting.address = _addressController.text;
    posting.city = _cityController.text;
    posting.country = _countryController.text;
    posting.amenities = _amenitiesController.text.split(",");
    posting.type = _houseType;
    posting.beds = _beds;
    posting.bathrooms = _bathrooms;
    posting.displayImages = _images;
    posting.host = AppConstants.currentUser.createContactFromUser();
    posting.setImageNames();
      if(widget.posting == null){
        posting.rating = 2.5;
        posting.bookings = [];
        posting.reviews = [];
        posting.addPostingInfoToFirestore().whenComplete((){
          posting.addImagesToFirestore().whenComplete((){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => host_home_page(index: 1,),
              ),
            );
          });
        });
      } else {
        posting.rating = widget.posting.rating;
        posting.bookings = widget.posting.bookings;
        posting.reviews = widget.posting.reviews;
        posting.id = widget.posting.id;
        for(int i = 0; i < AppConstants.currentUser.myPostings.length; i++){
          if(AppConstants.currentUser.myPostings[i].id == posting.id){
            AppConstants.currentUser.myPostings[i] = posting;
            break;
          }
        }
        posting.updatePostingInfoToFirestore().whenComplete((){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => host_home_page(index: 1,),
            ),
          );
        });
      }
  }

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
      _houseType = widget.posting.type;
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
            onPressed: _savePosting,
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
                  key: _formKey,
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
                          validator: (text){
                            if(text.isEmpty){
                              return "please enter a valid name";
                            }
                            return null;
                          },
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
                          onChanged: (value) {
                            this._houseType = value;
                            setState(() {});
                          },
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
                                validator: (text){
                                  if(text.isEmpty){
                                    return "please enter a valid price";
                                  }
                                  return null;
                                },
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
                          validator: (text){
                            if(text.isEmpty){
                              return "please enter a valid description";
                            }
                            return null;
                          },
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
                          validator: (text){
                            if(text.isEmpty){
                              return "please enter a valid address";
                            }
                            return null;
                          },
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
                          validator: (text){
                            if(text.isEmpty){
                              return "please enter a valid city";
                            }
                            return null;
                          },
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
                          validator: (text){
                            if(text.isEmpty){
                              return "please enter a valid country";
                            }
                            return null;
                          },
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
                                decreaseValue: (){
                                  this._beds['small']--;
                                  if(this._beds['small']<0){
                                    this._beds['small'] = 0;
                                  }
                                  print(this._beds['small']);
                                },
                                increaseValue: (){
                                  this._beds['small']++;
                                  print(this._beds['small']);
                                },
                              ),
                              facilities_widget(
                                type: 'Double',
                                startValue: _beds['medium'],
                                decreaseValue: (){
                                  this._beds['medium']--;
                                  if(this._beds['medium']<0){
                                    this._beds['medium'] = 0;
                                  }
                                },
                                increaseValue: (){
                                  this._beds['medium']++;
                                },
                              ),
                              facilities_widget(
                                type: 'Queen/King',
                                startValue: _beds['large'],
                                decreaseValue: (){
                                  this._beds['large']--;
                                  if(this._beds['large']<0){
                                    this._beds['large'] = 0;
                                  }
                                },
                                increaseValue: (){
                                  this._beds['large']++;
                                },
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
                              decreaseValue: (){
                                this._bathrooms['full']--;
                                if(this._bathrooms['full']<0){
                                  this._bathrooms['full'] = 0;
                                }
                              },
                              increaseValue: (){
                                this._bathrooms['full']++;
                              },
                            ),
                            facilities_widget(
                              type: 'Half',
                              startValue: _bathrooms['half'],
                              decreaseValue: (){
                                this._bathrooms['half']--;
                                if(this._bathrooms['half']<0){
                                  this._bathrooms['half'] = 0;
                                }
                              },
                              increaseValue: (){
                                this._bathrooms['half']++;
                              },
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
                          validator: (text){
                            if(text.isEmpty){
                              return "please enter valid amenities (comma separated)";
                            }
                            return null;
                          },
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
                                    onPressed: () {
                                      _selectImage(-1);
                                    },
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
  final Function decreaseValue;
  final Function increaseValue;


  facilities_widget({Key key, this.type, this.startValue, this.decreaseValue, this.increaseValue}) : super(key: key);

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
              onPressed: () {
                widget.decreaseValue();
                this._value--;
                if(this._value < 0){
                  this._value = 0;
                }
                setState(() {

                });
              },
            ),
            Text(
              this._value.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                widget.increaseValue();
                this._value++;
                setState(() {});
              },
            ),
          ],
        ),
      ],
    );
  }
}
