import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:piiprent/helpers/validator.dart';

class FormSelect extends StatefulWidget {
  final List<Option> options;
  final int columns;
  final bool multiple;
  final Function onSave;
  final Function onChanged;
  final String title;
  final Function validator;

  FormSelect({
    this.options,
    this.columns,
    @required this.multiple,
    this.onSave,
    this.title,
    this.onChanged,
    this.validator,
  });

  @override
  _FormSelectState createState() => _FormSelectState();
}

class _FormSelectState extends State<FormSelect> {
  List<Option> _multipleValue = [];
  Option _value;
  String _error;

  List<List<Option>> _data;

  @override
  void initState() {
    super.initState();

    List<List<Option>> data = [];
    int row = 0;
    if (widget.options != null) {
      for (int i = 0; i < widget.options.length; i++) {
        Option option = widget.options[i];

        if (i % widget.columns == 0) {
          data.add([option]);

          if (i != 0) {
            row++;
          }
        } else {
          data.elementAt(row).add(option);
        }
      }
    }

    _data = data;
  }

  _selectOption(Option option) {
    if (widget.multiple) {
      if (_multipleValue.contains(option)) {
        _multipleValue.remove(option);
      } else {
        _multipleValue.add(option);
      }
    } else {
      _value = option;
    }

    setState(() {
      _value = _value;
    });

    if (widget.onChanged != null) {
      if (widget.multiple) {
        widget.onChanged(
          _multipleValue.map((Option option) => option.value).toList(),
        );
      } else {
        widget.onChanged(_value);
      }
    }
  }

  _buildOption(Option option) {
    return GestureDetector(
      onTap: () => _selectOption(option),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _value == option || _multipleValue.contains(option)
              ? Colors.blue
              : Colors.white,
          border: Border.all(
            color: _value == option || _multipleValue.contains(option)
                ? Colors.blue
                : Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                translate(option.label),
                style: TextStyle(
                  fontSize: 16.0,
                  color: _value == option || _multipleValue.contains(option)
                      ? Colors.white
                      : Colors.grey[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasScroll = _data.length > 3 && widget.columns == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            '${widget.title} ${widget.validator == requiredValidator ? '*' : ''}', //
            style: TextStyle(color: Colors.grey[600], fontSize: 16.0),
          ),
        ),
        SizedBox(
          height: 4.0,
        ),
        FormField(
          onSaved: (String initValue) {
            if (widget.onSave != null) {
              if (widget.multiple) {
                widget.onSave(_multipleValue);
              } else {
                widget.onSave(_value);
              }
            }
          },
          validator: (String value) {
            if (widget.validator != null) {
              var error;
              if (widget.multiple) {
                error = widget.validator(_multipleValue);
              } else {
                error = widget.validator(_value);
              }

              setState(() {
                _error = error;
              });

              return error;
            }

            return null;
          },
          builder: (FormFieldState state) => Container(
            margin:
                hasScroll ? const EdgeInsets.symmetric(horizontal: 8.0) : null,
            padding: hasScroll
                ? const EdgeInsets.all(4.0)
                : const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              border: hasScroll ? Border.all(color: Colors.grey[400]) : null,
              borderRadius: hasScroll
                  ? BorderRadius.all(
                      Radius.circular(4.0),
                    )
                  : null,
            ),
            height: hasScroll ? 160 : null,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _data.map((e) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: e.map((e) {
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: _buildOption(e),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              _error,
              style: TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}

class Option {
  final dynamic value;
  final String title;
  final String translateKey;

  const Option({
    @required this.value,
    @required this.title,
    this.translateKey,
  });

  String get label {
    return translateKey ?? title;
  }
}
