import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../scenes/authentication/sign_in/model/login_model.dart';
import '../../constants/endpoints.dart';
import '../../constants/image_constant.dart';

class SingleImagePickerSection extends StatefulWidget {
  final Function(File) onImagePicked; // Callback for the selected image
  final LoginModel loginModel;

  const SingleImagePickerSection(
      {super.key, required this.onImagePicked, required this.loginModel});

  @override
  _SingleImagePickerSectionState createState() =>
      _SingleImagePickerSectionState();
}

class _SingleImagePickerSectionState extends State<SingleImagePickerSection> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _imageFile = File(selectedImage.path);
      });
      widget
          .onImagePicked(_imageFile!); // Notify parent with the selected image
    }
  }

  Future<void> _captureImage() async {
    final XFile? capturedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      setState(() {
        _imageFile = File(capturedImage.path);
      });
      widget
          .onImagePicked(_imageFile!); // Notify parent with the captured image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: _imageFile != null
                  ? FileImage(
                      _imageFile!) // Use FileImage with the selected File
                  : (widget.loginModel.photo != null &&
                          widget.loginModel.photo!.isNotEmpty
                      ? NetworkImage(
                          "${Endpoints.imageBaseURL}${widget.loginModel.photo}")
                      : AssetImage(ImageConstant.profile)
                          as ImageProvider<Object>),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _showImageSourceActionSheet(context),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(ImageConstant.addImageIcon),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _captureImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
