import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/image_constant.dart';

class ImagePickerSection extends StatefulWidget {
  final Function(List<File>) onImagesPicked; // Callback for selected images

  ImagePickerSection({required this.onImagesPicked});

  @override
  _ImagePickerSectionState createState() => _ImagePickerSectionState();
}

class _ImagePickerSectionState extends State<ImagePickerSection> {
  final ImagePicker _picker = ImagePicker();
  List<File>? _imageFiles;

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _imageFiles = selectedImages.map((xFile) => File(xFile.path)).toList();
      });
      widget.onImagesPicked(_imageFiles!); // Notify parent
    }
  }

  Future<void> _captureImage() async {
    final XFile? capturedImage = await _picker.pickImage(source: ImageSource.camera);
    if (capturedImage != null) {
      setState(() {
        _imageFiles = [File(capturedImage.path)];
      });
      widget.onImagesPicked(_imageFiles!); // Notify parent
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles!.removeAt(index);
    });
    widget.onImagesPicked(_imageFiles!); // Notify parent
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
              backgroundImage: _imageFiles != null && _imageFiles!.isNotEmpty
                  ? FileImage(_imageFiles![0]) // Use FileImage with File
                  : AssetImage(ImageConstant.addImageBackground) as ImageProvider<Object>, // Cast as ImageProvider<Object>
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
                  // child: const Icon(Icons.add_a_photo, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        if (_imageFiles != null)
          Wrap(
            children: _imageFiles!.asMap().entries.map((entry) {
              int index = entry.key;
              File image = entry.value;
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.file(
                      image,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.delete,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
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
                  _pickImages();
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
