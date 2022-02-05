import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/widgets/form_field.dart';

class AddressField extends StatefulWidget {
  final Function onSaved;
  final Function validator;

  AddressField({
    this.onSaved,
    this.validator,
  });

  @override
  _AddressFieldState createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  StreamController<String> _addressStreamController = StreamController();
  Map<String, dynamic> _address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Field(
          readOnly: true,
          label: translate('field.address'),
          validator: widget.validator,
          onSaved: (String value) {
            widget.onSaved(_address);
          },
          setStream: _addressStreamController.stream,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            child: Text('Choose Address'),
            onPressed: () {
              Navigator.pushNamed(context, '/address').then((value) {
                if (value != null) {
                  _addressStreamController
                      .add((value as Map<String, dynamic>)['streetAddress']);
                  var newadd = (value as Map<String, dynamic>)['streetAddress'];
                  print("street address : $newadd}");
                  setState(() {
                    _address = (value as Map<String, dynamic>)['address'];
                    print("address : $_address");
                  });
                }
              });
            },
          ),
        )
      ],
    );
  }
}
