import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class Dropdown<T> extends StatefulWidget {
  const Dropdown({
    Key key,
    this.label,
    this.future,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.multiple,
    this.hint,
    this.items,
    this.initialvalue,
    this.funchange,
    @required this.renderFn,
    @required this.compareFn,
  }) : super(key: key);

  final String label;
  final Function future;
  final Function onChanged;
  final Function validator;
  final Function onSaved;
  final bool multiple;
  final List<T> items;
  final Function renderFn;
  final Function compareFn;
  final String hint;
  final bool funchange;
  final String initialvalue;

  @override
  DropdownState<T> createState() => DropdownState<T>();
}

class DropdownState<T> extends State<Dropdown> {
  Future<List<T>> _fetchOptions(String query) async {
    try {
      List list = await widget.future({'search': query});

      if (list.isEmpty) {
        return [];
      }

      return list;
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _multipleDropDown() {
    return DropdownSearch<T>.multiSelection(
      hint: "Select skill",
      validator: widget.validator,
      isFilteredOnline: true,
      mode: Mode.DIALOG,
      onFind: widget.future != null
          ? (text) async {
              return await _fetchOptions(text);
            }
          : null,
      itemAsString: widget.renderFn,
      onChanged: (List<T> value) {
        if (widget.onChanged != null) {
          widget.onChanged(value);
          widget.funchange;
        }
      },
      onSaved: (List<T> value) {
        if (widget.onSaved != null) {
          widget.onSaved(value);
        }
      },
      searchDelay: Duration(milliseconds: 800),
      showSearchBox: widget.items == null,
      items: widget.items as List<T>,
      dropDownButton: Icon(
        Icons.arrow_drop_down,
        color: Color(0XFF2196F3),
      ),
      dropdownSearchDecoration: InputDecoration(
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontFamily: "Roboto",
            color: Color(0XFFD3DEEA)),
        contentPadding: EdgeInsets.only(
          left: 20,
          bottom: 12,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      searchFieldProps: TextFieldProps(
        readOnly: true,
        style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0XFF2F363D)),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: "Roboto",
              color: Color(0XFFD3DEEA)),
          counterStyle: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFF2F363D)),
          contentPadding: EdgeInsets.only(
            left: 20,
            bottom: 12,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
      compareFn: widget.compareFn,
      showSelectedItems: widget.compareFn != null,
    );
  }

  Widget _singleValueDropdown() {
    return DropdownSearch<T>(
      validator: widget.validator,
      isFilteredOnline: true,
      mode: Mode.DIALOG,
      onFind: (text) async {
        return await _fetchOptions(text);
      },
      itemAsString: widget.renderFn,
      onChanged: (T instance) {
        if (widget.onChanged != null) {
          widget.onChanged(instance);
        }
      },
      onSaved: (T instance) {
        if (widget.onSaved != null) {
          widget.onSaved(instance);
        }
      },
      searchDelay: Duration(milliseconds: 800),
      showSearchBox: widget.items == null,
      items: widget.items as List<T>,
      dropDownButton: Icon(
        Icons.arrow_drop_down,
        color: Color(0XFF2196F3),
      ),
      dropdownSearchDecoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontFamily: "Roboto",
            color: Color(0XFFD3DEEA)),
        contentPadding: EdgeInsets.only(
          left: 20,
          bottom: 12,
        ),
        counterStyle: TextStyle(
            fontFamily: "Roboto",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0XFF2F363D)),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              fontFamily: "Roboto",
              color: Color(0XFFD3DEEA)),
          counterStyle: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFF2F363D)),
          contentPadding: EdgeInsets.only(
            left: 20,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
      compareFn: widget.compareFn,
      showSelectedItems: widget.compareFn != null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.multiple == true
        ? _multipleDropDown()
        : _singleValueDropdown();
  }
}

