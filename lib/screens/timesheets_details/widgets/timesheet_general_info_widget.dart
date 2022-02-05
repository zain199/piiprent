import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piiprent/helpers/colors.dart';

class GeneralInformationWidget extends StatelessWidget {
  final String imageIcon;
  final String name;
  final String value;

  const GeneralInformationWidget(
      {this.imageIcon, this.name, this.value, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 17),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            imageIcon,
            width: 10,
            height: 12,
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                fontFamily: GoogleFonts.roboto().fontFamily,
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.lightBlack,
                fontSize: 14,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
