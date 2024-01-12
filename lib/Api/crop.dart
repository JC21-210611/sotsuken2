import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Crop{
  const Crop(this.image, {Key? key});
    final XFile image;

  //トリミングメソッド
  static Future<Null> cropImage(XFile image,Function(File?) onImageCropped)async{
    File? imageFile = File(image.path);
    if(imageFile != null){
      File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        //android側の設定
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        //ios側の設定
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ),
      );
      if (croppedFile != null) {
        onImageCropped(croppedFile);
      }
    }
  }

  //クリアメソッド
  static void clearImage(Function(File?) onImageCleared) {
    onImageCleared(null);
  }
}