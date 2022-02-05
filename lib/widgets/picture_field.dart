import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piiprent/helpers/validator.dart';

class PictureField extends StatefulWidget {
  const PictureField({
    Key key,
    this.label,
    this.onSaved,
    this.validator,
  }) : super(key: key);
  final String label;
  final Function onSaved;
  final Function validator;

  @override
  _PictureFieldState createState() => _PictureFieldState();
}

class _PictureFieldState extends State<PictureField> {
  final ImagePicker _picker = ImagePicker();
  Uint8List _imageBytes;
  String _value;
  String _error;

  @override
  initState() {
    _value = null;
    super.initState();
  }

  _takePicture() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      _value = 'data:image/jpeg;base64,${base64.encode(bytes)}';

      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  Widget emptyPicture() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.person,
          size: 48,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget picturePreview() {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        shape: BoxShape.circle,
        image: _imageBytes != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(_imageBytes),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${widget.label} ${widget.validator == requiredValidator ? '*' : ''}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Row(
            children: [
              FormField(
                builder: (FormFieldState state) {
                  return _imageBytes != null
                      ? picturePreview()
                      : emptyPicture();
                },
                onSaved: (String initValue) {
                  widget.onSaved(_value);
                },
                validator: (String value) {
                  print('value $value');
                  if (widget.validator != null) {
                    var error = widget.validator(_value);

                    setState(() {
                      _error = error;
                    });

                    return error;
                  }

                  return null;
                },
              ),
              SizedBox(
                width: 16,
              ),
              ElevatedButton(
                onPressed: _takePicture,
                child: Text(
                  translate('button.take_photo'),
                ),
              )
            ],
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _error,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
