import 'package:flutter/material.dart';

class TxtFeild extends StatelessWidget {
  var hinttxt;
  double wdt;
  Widget sfxicn;

  var prfxic;

  var changeValdt;

  var cntrlr;

  var pwdstr;

  var keytype;

  var eble;

  var onSaved;

  var readonly;

  TxtFeild(
      {this.hinttxt,
      this.wdt,
      this.sfxicn,
      this.prfxic,
      this.changeValdt,
      this.cntrlr,
      this.pwdstr,
      this.keytype,
      this.eble,
      this.onSaved,
      this.readonly});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      width: wdt,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0XFFD3DEEA))),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: TextFormField(
          readOnly: readonly,
          onSaved: onSaved,
          enabled: eble,
          keyboardType: keytype,
          obscureText: pwdstr,
          controller: cntrlr,
          onChanged: changeValdt,
          decoration: InputDecoration(
              hintText: hinttxt,
              prefixIcon: prfxic,
              suffixIcon: sfxicn,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: Color(0XFFD3DEEA)),
              border: InputBorder.none),
          cursorColor: Color(0XFF2F363D),
          style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFF2F363D)),
        ),
      ),
    );
  }
}
