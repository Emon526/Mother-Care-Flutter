import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/mammogramnote.dart';
import 'result.dart';

class MemmographyPrediction extends StatefulWidget {
  const MemmographyPrediction({super.key});

  @override
  State<MemmographyPrediction> createState() => _MemmographyPredictionState();
}

class _MemmographyPredictionState extends State<MemmographyPrediction> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memmography Prediction'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MammogramNote(),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2.0,
                    strokeAlign: StrokeAlign.outside,
                    style: BorderStyle.solid,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: _image == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Waiting for Image',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                            ),
                          ),
                          ElevatedButton.icon(
                            label: const Text('Upload Image'),
                            onPressed: pickImage,
                            icon: const Icon(Icons.photo_camera_outlined),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              _image == null
                  ? GestureDetector(
                      onTap: () {},
                      child: RichText(
                        text: const TextSpan(
                          text: 'What is ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: 'Mammogram?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        ElevatedButton.icon(
                          label: const Text('Change Image'),
                          onPressed: pickImage,
                          icon: const Icon(Icons.photo_camera_outlined),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PredictionResult(
                                  image: _image!,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.description_outlined,
                          ),
                          label: const Text('Get Prediction Result'),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        _image = File(image.path);
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }
}
