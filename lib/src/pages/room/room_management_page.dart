import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mini/src/configs/api.dart';
import 'package:mini/src/configs/app_route.dart';
import 'package:mini/src/pages/model/Renalroom_model.dart';

import 'package:mini/src/services/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RoomManagementPage extends StatefulWidget {
  @override
  _RoomManagementPageState createState() => _RoomManagementPageState();
}

class _RoomManagementPageState extends State<RoomManagementPage> {
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  bool _editMode;
  Rentalroom _Room;
  @override
  void initState() {
    _editMode = false;
    _Room = Rentalroom();
    super.initState();
  }

  callback(File image) {
    _image = image;
  }

  @override
  Widget build(BuildContext context) {
    Object argument = ModalRoute.of(context).settings.arguments;
    if(argument is Rentalroom){
      _Room = argument;
      _editMode = true;
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: _buildIdInput(),
                      flex: 1,
                    ),
                    SizedBox(width: 12.0),
                    Flexible(
                      child: _buildNameInput(),
                      flex: 2,
                    )
                  ],
                ),
                SizedBox(height: 12.0),
                 _buildDetallInput(),
                SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: _buildPriceInput(),
                      flex: 1,
                    ),
                    SizedBox(width: 12.0),

                  ],
                ),
                SizedBox(height: 12.0),
                _buildImageInput(),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                ProductImage(callback, image: _Room.picture),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration inputStyle({String label}) => InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepPurpleAccent,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
      ),
    ),
    labelText: label,
  );
  TextFormField _buildIdInput() => TextFormField(
    enabled: !_editMode,
    initialValue: _Room.rentalroomId ?? "",
    decoration: inputStyle(label: "ID"),
    onSaved: (String value) {
      _Room.rentalroomId = value;
    },
  );
  TextFormField _buildNameInput() => TextFormField(
    initialValue: _Room.rentalroomName ?? "",
    decoration: inputStyle(label: "Name"),
    onSaved: (String value) {
      _Room.rentalroomName = value;
    },
  );
  TextFormField _buildDetallInput() => TextFormField(
    initialValue: _Room.rentalroomPhone ?? "",
    decoration: inputStyle(label: "Detall"),
    onSaved: (String value) {
      _Room.rentalroomPhone = value;
    },
  );
  TextFormField _buildPriceInput() => TextFormField(
    initialValue: _Room.rentalroomPrice == null ? '0': _Room.rentalroomPrice.toString(),
    decoration: inputStyle(label: "Price"),
    keyboardType: TextInputType.number,
    onSaved: (String value) {
      _Room.rentalroomPrice = value;
    },
  );

  TextFormField _buildImageInput() => TextFormField(
    initialValue: _Room.picture ?? "",
    decoration: inputStyle(label: "Image"),
    keyboardType: TextInputType.number,
    onSaved: (String value) {
      _Room.picture = value;
    },
  );
  AppBar _buildAppBar() => AppBar(
    centerTitle: false,
    title: Text(_editMode ? 'Edit room' : 'Add room'),
    actions: [
      TextButton(
        onPressed: () async {
          _formKey.currentState.save();
          FocusScope.of(context).requestFocus(FocusNode());
          if (_editMode) {
            try{
              final message = await NetworkService().editRentalroomDio(_image, _Room);
              if (message == 'Edit Successfully') {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.roomRoute, (route) => false);
              }
            }catch(ex){
              Flushbar(
                title: "Edit",
                titleColor: Colors.green,
                backgroundColor: Colors.black38,
                icon: Icon(
                  Icons.save,
                  color: Colors.green,
                ),
                message: "Edit Successfully !!",
                duration: Duration(seconds: 5),
              )..show(context);
            }
          } else {
            Flushbar(
              title: "Edit",
              titleColor: Colors.red,
              backgroundColor: Colors.black38,
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              message: "Edit Failed!!",
              duration: Duration(seconds: 5),
            )..show(context);
            try {
              Navigator.pop(context);
              final message = await NetworkService().addRentalroomDio(_image, _Room);
              if (message == 'Add Successfully') {
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.roomRoute, (route) => false);
              }
              else {
                Flushbar(
                  title: "Add",
                  titleColor: Colors.green,
                  backgroundColor: Colors.black38,
                  icon: Icon(
                    Icons.save,
                    color: Colors.green,
                  ),
                  message: "Add Successfully !!",
                  duration: Duration(seconds: 5),
                )..show(context);
              }
            } catch (ex) {
              Flushbar(
                title: "Add",
                titleColor: Colors.red,
                backgroundColor: Colors.black38,
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                message: "Add Failed!!",
                duration: Duration(seconds: 5),
              )..show(context);
            }
          }
        },
        child: Text(
          'submit',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
      )
    ],
  );
} //end

class ProductImage extends StatefulWidget {
  final Function callBack;
  final String image;

  const ProductImage(this.callBack, {Key key, @required this.image})
      : super(key: key);

  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File _imageFile;
  String _image;
  final _picker = ImagePicker();

  @override
  void initState() {
    _image = widget.image;
    super.initState();
  }

  @override
  void dispose() {
    _imageFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildPickerImage(),
          _buildPreviewImage(),
        ],
      ),
    );
  }

  dynamic _buildPreviewImage() {
    if ((_image == null || _image.isEmpty) && _imageFile == null) {
      return SizedBox();
    }

    final container = (Widget child) => Container(
      color: Colors.grey[100],
      margin: EdgeInsets.only(top: 4),
      alignment: Alignment.center,
      height: 350,
      child: child,
    );

    return _image != null
        ? container(Image.network('${API.RENTALROOM_IMAGE}/$_image'))
        : Stack(
      children: [
        container(Image.file(_imageFile)),
        _buildDeleteImageButton(),
      ],
    );
  }

  OutlinedButton _buildPickerImage() => OutlinedButton.icon(
    icon: Icon(Icons.image),
    label: Text('image'),
    onPressed: () {
      _modalPickerImage();
    },
  );

  void _modalPickerImage() {
    final buildListTile =
        (IconData icon, String title, ImageSource source) => ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        _pickImage(source);
      },
    );

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildListTile(
                Icons.photo_camera,
                "Take a picture from camera",
                ImageSource.camera,
              ),
              buildListTile(
                Icons.photo_library,
                "Choose from photo library",
                ImageSource.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImage(ImageSource source) {
    _picker
        .getImage(
      source: source,
      imageQuality: 70,
      maxHeight: 500,
      maxWidth: 500,
    )
        .then((file) {
      if (file != null) {
        setState(() {
          _imageFile = File(file.path);
          _image = null;
          widget.callBack(_imageFile);
        });
      }
    }).catchError((error) {
      //todo
    });
  }

  Positioned _buildDeleteImageButton() => Positioned(
    right: 0,
    child: IconButton(
      onPressed: () {
        setState(() {
          _imageFile = null;
          widget.callBack(null);
        });
      },
      icon: Icon(
        Icons.clear,
        color: Colors.black54,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
  );
}
