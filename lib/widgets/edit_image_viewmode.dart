import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_editor_app/models/text_info.dart';
import 'package:image_editor_app/widgets/default_button.dart';
import '../screens/edit_image_screen.dart';

abstract class EditImage extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;

  saveToGallery(BuildContext context) {
    setState(() {
      screenshotController.capture().then((Uint8List? image) {
       // saveImage();
      }).catchError((err) {
        // ignore: avoid_print
        print(err);
      });
    });
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot$time";
  //  await requestPermission(Permission.storage);
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  setCurrentIndex(context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected For Styling',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addNewText(context) {
    setState(() {
      texts.add(TextInfo(
          text: textEditingController.text,
          left: 0,
          top: 0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          textAlign: TextAlign.left));
      Navigator.of(context).pop();
    });
  }

  addNewDialogBox(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add New Text'),
              content: TextField(
                controller: textEditingController,
                maxLines: 5,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.edit,
                  ),
                  hintText: "Your Text is here",
                  filled: true,
                ),
              ),
              actions: <Widget>[
                DefaultButton(
                    backgroundColor: Colors.black,
                    child: const Text('Back'),
                    onPressed: Navigator.of(context).pop,
                    textColor: Colors.white),
                DefaultButton(
                    backgroundColor: Colors.red,
                    child: const Text('Add'),
                    onPressed: () => addNewText(context),
                    textColor: Colors.white)
              ],
            ));
  }
}
