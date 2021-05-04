import 'package:flutter/material.dart';
import 'package:greatplacesapp/models/place.dart';
import '../widgets/images_input.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  PlaceLocation _pickedLocation;

  final _titleController = TextEditingController();
  File _pickedImage;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      //showDialogue('error')
      return; //no continue //add exception/.use form // use error message
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              //scrollable
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  //expanded takes all the height it can get
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                    //widget defined in widget folder
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            onPressed: _savePlace,
            icon: Icon(Icons.add),
            label: Text('add place'),
            elevation: 0,
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, //put button at stap no margin
            color: Theme.of(context).accentColor, //color of button
          )
        ],
      ),
    );
  }
}
