import 'package:flutter/material.dart';

class DetailsRecord extends StatelessWidget {
  final String label;
  final String value;
  final Widget button;

  DetailsRecord({this.label, this.value = '', this.button});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(label),
          ),
          Text(':'),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Row(
                    children: this.button != null
                        ? [
                            Text(value != null ? value : ''),
                            SizedBox(width: 8.0),
                            Expanded(child: this.button)
                          ]
                        : [
                            Expanded(
                              child: Text(value != null ? value : ''),
                            ),
                          ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
