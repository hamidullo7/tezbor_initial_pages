import 'package:flutter/material.dart';

TextButton customFlatButton(
    {required Future<void> onPressed(),
    required String label,
    OutlinedBorder? shape,
    Color? color,
    Color? textColor,
    double? width,
    double? height,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    double? fontSize,
    TextAlign? textAlign,
    Color? disabledColor,
    Key? key}) {
  ButtonStyle flatButtonStyle = TextButton.styleFrom(
    minimumSize: Size(width ?? 88, height ?? 36),
    backgroundColor: color,
    disabledBackgroundColor: disabledColor,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: shape ??
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
  );
  return TextButton(
    key: key,
    style: flatButtonStyle,
    onPressed: onPressed,
    child: Text(label,
        textAlign: textAlign,
        style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
            overflow: overflow,
            fontSize: fontSize)),
  );
}
