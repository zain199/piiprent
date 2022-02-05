import 'package:flutter/material.dart';

class ProfileGroup extends StatefulWidget {
  final String title;
  final Function onEdit;
  final List<Widget> content;
  final bool canEdit;
  final bool isEditing;

  ProfileGroup({
    this.title,
    this.onEdit,
    this.content,
    this.canEdit = false,
    this.isEditing = false,
  });

  @override
  _ProfileGroupState createState() => _ProfileGroupState();
}

class _ProfileGroupState extends State<ProfileGroup> {
  bool _showContent = false;

  _onTap() {
    setState(() {
      _showContent = !_showContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _onTap,
          child: Container(
            height: 44.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              border: Border.all(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.blueAccent,
              ),
            ),
            child: Row(
              children: [
                Text(widget.title, style: TextStyle(fontSize: 16.0)),
                Expanded(
                  child: SizedBox(),
                ),
                widget.canEdit
                    ? IconButton(
                        // Disabled for now
                        onPressed: widget.onEdit,
                        icon: Icon(
                          Icons.edit,
                          color: widget.isEditing
                              ? Colors.blue[400]
                              : Colors.black,
                        ),
                        iconSize: 22.0,
                      )
                    : SizedBox(),
                Icon(
                  _showContent
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 26.0,
                  color: Colors.grey[700],
                )
              ],
            ),
          ),
        ),
        Column(
          children: _showContent ? widget.content : [],
        )
      ],
    );
  }
}
