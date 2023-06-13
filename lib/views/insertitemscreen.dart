import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_5/views/user.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io' as io;

class InsertItemScreen extends StatefulWidget {
  final User user;
  const InsertItemScreen({super.key, required this.user});

  @override
  State<InsertItemScreen> createState() => _InsertItemScreenState();
}

class _InsertItemScreenState extends State<InsertItemScreen> {
  io.File? _image1;
  io.File? _image2;
  io.File? _image3;
  var pathAsset = "assets/images/camera.png";
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth, cardwitdh;
  final TextEditingController _itemnameEditingController =
      TextEditingController();
  final TextEditingController _itemdescEditingController =
      TextEditingController();
  final TextEditingController _itempriceEditingController =
      TextEditingController();
  final TextEditingController _itemqtyEditingController =
      TextEditingController();
  final TextEditingController _stateEditingController = TextEditingController();
  final TextEditingController _localityEditingController =
      TextEditingController();
  String? selectedType = null;
  List<String> itemlist = [
    "item b",
    "item c",
    "item d",
    "item e",
    "item f",
    "item g",
    "item h",
    "item i",
    "Other",
  ];
  late Position _currentPosition;

  String useraddress = "";
  String itemname = "";
  String itemdesc = "";
  String itemprice = "";
  String itemqty = "";
  String state = "";
  String latitude = "";
  String longitude = "";
  String itemtype = "";
  String locality = "";
  String image1 = "";

  List<Asset> _images = [];

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Insert New Item"), actions: [
        IconButton(
            onPressed: () {
              _determinePosition();
            },
            icon: const Icon(Icons.refresh))
      ]),
      body: Column(children: [
        Flexible(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                _selectFromGallery();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Card(
                  child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image1 == null
                              ? AssetImage(pathAsset)
                              : FileImage(_image1!) as ImageProvider,
                          fit: BoxFit.contain,
                        ),
                      )),
                ),
              ),
            )),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(children: [
                      const Icon(Icons.type_specimen),
                      const SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        height: 60,
                        child: DropdownButton(
                          //sorting dropdownoption
                          // Not necessary for Option 1
                          value: selectedType,
                          onChanged: (newValue) {
                            setState(() {
                              selectedType = newValue.toString();
                              print(selectedType);
                            });
                          },
                          items: itemlist.map((selectedType) {
                            return DropdownMenuItem(
                              value: selectedType,
                              child: Text(
                                selectedType,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Item name must be longer than 3 characters"
                                : null,
                            onFieldSubmitted: (v) {},
                            controller: _itemnameEditingController, //
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: 'Item Name',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.abc),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),
                      )
                    ]),
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty
                            ? "Item description must be longer than 10"
                            : null,
                        onFieldSubmitted: (v) {},
                        maxLines: 4,
                        controller: _itemdescEditingController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: 'Item Description',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(),
                            icon: Icon(
                              Icons.description,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),
                    Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) => val!.isEmpty
                                  ? "Product price must contain value"
                                  : null,
                              onFieldSubmitted: (v) {},
                              controller: _itempriceEditingController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Item Price',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.money),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                        ),
                        Flexible(
                          flex: 5,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) => val!.isEmpty
                                  ? "Quantity should be more than 0"
                                  : null,
                              controller: _itemqtyEditingController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Item Quantity',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.numbers),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                        ),
                      ],
                    ),
                    Row(children: [
                      Flexible(
                        flex: 5,
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Current State"
                                : null,
                            enabled: false,
                            controller: _stateEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: 'Current State',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.flag),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),
                      ),
                      Flexible(
                        flex: 5,
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Current Locality"
                                : null,
                            controller: _localityEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: 'Current Locality',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.map),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),
                      ),
                    ]),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenWidth / 1.2,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            insertDialog();
                          },
                          child: const Text("Insert Item")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<Object> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
    _currentPosition = await Geolocator.getCurrentPosition();

    _getAddress(_currentPosition);
    return await Geolocator.getCurrentPosition();
  }

  _getAddress(Position pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isEmpty) {
      _localityEditingController.text = "Changlun";
      _stateEditingController.text = "Kedah";
      latitude = "6.443455345";
      longitude = "100.05488449";
    } else {
      _localityEditingController.text = placemarks[0].locality.toString();
      _stateEditingController.text =
          placemarks[0].administrativeArea.toString();
      latitude = _currentPosition.latitude.toString();
      longitude = _currentPosition.longitude.toString();
    }
    setState(() {});
  }

  Future<void> _selectFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1200,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      io.File imageFile = io.File(pickedFile.path);
      _image1 = imageFile;
      cropImage();
    } else {
      print('No image selected.');
    }
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _image1!.path,
      aspectRatioPresets: [
        // CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        //CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio3x2,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      io.File imageFile = io.File(croppedFile.path);
      _image1 = imageFile;
      int? sizeInBytes = _image1?.lengthSync();
      double sizeInMb = sizeInBytes! / (1024 * 1024);
      print(sizeInMb);

      setState(() {});
    }
  }

  void insertDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }
    if (_image1 == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please take picture")));
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Insert your item?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //insertItem();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );




    void insertItem() {
      String itemname = _itemnameEditingController.text;
      String itemdesc = _itemdescEditingController.text;
      String itemprice = _itempriceEditingController.text;
      int itemqty = _itemqtyEditingController.text as int;
      String state = _stateEditingController.text;
      String locality = _localityEditingController.text;
      String base64Image1 = base64Encode(_image1!.readAsBytesSync());
      String base64Image2 = base64Encode(_image2!.readAsBytesSync());
      String base64Image3 = base64Encode(_image2!.readAsBytesSync());
      
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Please Wait"),
            content: Text("Adding your new items..."),
          );
        },
      );
      
      try {
        http.post(
            Uri.parse("http://192.168.56.1/bartlet/php/insert_item.php"),
            body: {
              "userid": widget.user.id.toString(),
              "itemname": itemname,
              "itemdesc": itemdesc,
              "itemprice": itemprice,
              "itemqty": itemqty,
              "itemtype": selectedType,
              "latitude": latitude,
              "longitude": longitude,
              "state": state,
              "locality": locality,
              "image1": base64Image1,
              "image2": base64Image2,
              "image3": base64Image3,
            }).then((response) {
          print(response.body);
          if (response.statusCode == 200) {
            var jsondata = jsonDecode(response.body);
            if (jsondata['status'] == 'success') {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Insert Success")));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Insert Failed")));
            }
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Insert Failed")));
            Navigator.pop(context);
          }
        });
      } on TimeoutException catch (_) {
        print("Time out");
      }

      void _determinePosition() async {
        bool serviceEnabled;
        LocationPermission permission;
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location permissions are permanently denied.');
        }
        _currentPosition = await Geolocator.getCurrentPosition();

        //_getAddress(_currentPosition);
        //return await Geolocator.getCurrentPosition();
      }

      _getAddress(Position pos) async {
        List<Placemark> placemarks =
            await placemarkFromCoordinates(pos.latitude, pos.longitude);
        if (placemarks.isEmpty) {
          _localityEditingController.text = "Changlun";
          _stateEditingController.text = "Kedah";
          latitude = "6.443455345";
          longitude = "100.05488449";
        } else {
          _localityEditingController.text = placemarks[0].locality.toString();
          _stateEditingController.text =
              placemarks[0].administrativeArea.toString();
          latitude = _currentPosition.latitude.toString();
          longitude = _currentPosition.longitude.toString();
        }
        setState(() {});
      }
    }
  }
}
