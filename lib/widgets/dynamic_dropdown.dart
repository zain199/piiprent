import 'package:flutter/material.dart';

import 'form_field.dart';

class DynamicDropdown extends StatefulWidget {
  final String label;
  final Function future;
  final Function onChange;

  DynamicDropdown({this.label, this.future, this.onChange});

  @override
  _DynamicDropdownState createState() => _DynamicDropdownState();
}

class _DynamicDropdownState extends State<DynamicDropdown> {
  bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Field(
            label: widget.label,
            onFocus: () {
              setState(() {
                _isOpen = true;
              });
            },
          ),
          _isOpen
              ? Container(
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                      border: Border.all(
                          width: 1,
                          color: Colors.grey[700],
                          style: BorderStyle.solid)),
                  child: FutureBuilder(
                    future: widget.future(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        List<dynamic> data = snapshot.data;

                        return ListView(
                          shrinkWrap: true,
                          children: data
                              .map(
                                (data) => ListTile(
                                  title: Text(data.name),
                                  onTap: () => widget.onChange(data.id),
                                ),
                              )
                              .toList(),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
