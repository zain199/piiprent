import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:piiprent/helpers/enums.dart';
import 'package:piiprent/widgets/filter_dialog.dart';

class FilterDialogButton extends StatefulWidget {
  final String from;
  final String to;
  final Function onClose;

  FilterDialogButton({
    this.from,
    this.to,
    @required this.onClose,
  });

  @override
  _FilterDialogButtonState createState() => _FilterDialogButtonState();
}

class _FilterDialogButtonState extends State<FilterDialogButton> {
  DateTime _from;
  DateTime _to;

  get hasData {
    return _from != null || _to != null;
  }

  @override
  void initState() {
    if (widget.from != null) {
      _from = DateTime.parse(widget.from);
    }

    if (widget.to != null) {
      _to = DateTime.parse(widget.to);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _showDialog,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.filter_list,
            color: Colors.blue,
          ),

          // TODO: implement showing functionality
          hasData
              ? Positioned(
                  top: -2.0,
                  right: -2.0,
                  child: Container(
                    alignment: Alignment.topRight,
                    height: 12.0,
                    width: 12.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red[300],
                      border: Border.all(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  _onClose(dynamic event) {
    if (event == FilterDialogResult.Submit) {
      widget.onClose({
        "from": _from != null ? DateFormat('yyyy-MM-dd').format(_from) : null,
        "to": _to != null ? DateFormat('yyyy-MM-dd').format(_to) : null,
      });
    } else if (event == FilterDialogResult.Clear) {
      widget.onClose({"from": null, "to": null});
      setState(() {
        _from = null;
        _to = null;
      });
    } else {
      widget.onClose({"from": widget.from, "to": widget.to});
    }
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(FilterDialogResult.Clear);
            },
            child: Text(translate('button.clear')),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(FilterDialogResult.Submit);
            },
            // color: Colors.blueAccent,
            child: Text(translate('button.submit')),
          ),
        ],
        title: Text(translate('dialog.choose_dates')),
        contentPadding: const EdgeInsets.all(8.0),
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 10.0,
        ),
        content: FilterDialog(
          from: _from,
          to: _to,
          onChange: (Map<String, DateTime> data) {
            setState(() {
              _from = data["from"];
              _to = data["to"];
            });
          },
        ),
      ),
    ).then(_onClose);
  }
}
