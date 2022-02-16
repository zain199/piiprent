import 'package:flutter/material.dart';

class HomeScreenButton extends StatefulWidget {
  final Icon icon;
  final String text;
  final Color color;
  final String path;
  final Stream stream;
  final Function update;

  HomeScreenButton({
    this.icon,
    this.text,
    this.color,
    this.path,
    this.stream,
    this.update,
  });

  @override
  _HomeScreenButtonState createState() => _HomeScreenButtonState();
}

class _HomeScreenButtonState extends State<HomeScreenButton> {
  @override
  void initState() {
    super.initState();
    if (widget.update != null) {
      widget.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
            child: Row(
              children: [
                widget.icon != null
                    ? Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: widget.icon,
                      )
                    : SizedBox(
                        height: 35.0,
                      ),
                Expanded(child: Text(widget.text, style: TextStyle(color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,)),
              ],
            ),
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          widget.stream != null
              ? StreamBuilder(
                  stream: widget.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data) {
                      return Positioned(
                        top: 3.0,
                        right: 3.0,
                        child: Container(
                          alignment: Alignment.topRight,
                          height: 16.0,
                          width: 16.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red[300],
                            border: Border.all(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                        ),
                      );
                    }

                    return Container(
                      width: 0.0,
                      height: 0.0,
                    );
                  },
                )
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
        ],
      ),
      onTap: () => Navigator.pushNamed(context, widget.path),
    );
  }
}
