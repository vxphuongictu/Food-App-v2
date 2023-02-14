import 'dart:io';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';


class MyCycleAvatar extends StatefulWidget
{

  Image ? avatar;

  MyCycleAvatar({this.avatar});

  @override
  State<MyCycleAvatar> createState() {
    return _MyCycleAvatar();
  }
}


class _MyCycleAvatar extends State<MyCycleAvatar>
{

  File ? _profilePicFile;
  late String avatar_uri = 'https://haycafe.vn/wp-content/uploads/2022/02/Anh-Avatar-Doremon-dep-ngau-cute.jpg';

  void _changeImage(File ? file) async {
    if (file == null) return;
    setState(() {
      _profilePicFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.0,
      height: 100.0,
      child: Stack(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                color: cnf.colorMainStreamBlue.toColor(),
                borderRadius: const BorderRadius.all(Radius.circular(100.0))
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: avatar(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget avatar()
  {
    return EditableImage(

      // Define the method that will run on the change process of the image.
      onChange: (file) => _changeImage(file),

      // Define the source of the image.
      image: _profilePicFile != null
          ? Image.file(_profilePicFile!, fit: BoxFit.cover)
          : Image.network(this.avatar_uri.toString(), fit: BoxFit.cover),

      // Define the size of EditableImage.
      size: 90.0,

      // Define the Theme of image picker.
      imagePickerTheme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: Colors.white,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white70,
        iconTheme: const IconThemeData(color: Colors.black87),

        // Define the default font family.
        fontFamily: 'Georgia',
      ),

      // Define the border of the image if needed.
      imageBorder: Border.all(color: Colors.black87, width: 2.0),

      // Define the border of the icon if needed.
      editIconBorder: Border.all(color: Colors.black87, width: 2.0),
    );
  }
}