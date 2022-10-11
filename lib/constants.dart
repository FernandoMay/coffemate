import 'package:flutter/cupertino.dart';

const primaryColor = Color(0xFF3C2317);
const secondaryColor = Color(0xFF628E90);
const bgLightColor = Color(0xFFF5EFE6);
const lightColor = Color(0xFFB4CDE6);
const dangerColor = Color(0xFF850E35);
const successColor = Color(0xFF2EB086);
const textColor = Color(0xFF0F0F0F);
const greyLightColor = Color(0xFFE6E6E6);
const brownDark = Color(0xFF532E1C);
const brownLight = Color(0xFFC5A880);
const primaryGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      secondaryColor,
      primaryColor,
    ]);

const tsH3Blue = TextStyle(
  fontFamily: "Roboto",
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
  color: secondaryColor,
);

const tsH2Blue = TextStyle(
  fontFamily: "Roboto",
  fontSize: 17.0,
  fontWeight: FontWeight.w500,
  color: secondaryColor,
);

const tsH1Blue = TextStyle(
  fontFamily: "Roboto",
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: secondaryColor,
);

const tsH4Black = TextStyle(
  fontFamily: "Roboto",
  fontSize: 25.0,
  fontWeight: FontWeight.w400,
  color: textColor,
);

const tsH3Black = TextStyle(
  fontFamily: "Roboto",
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
  color: textColor,
);

const tsH2Black = TextStyle(
  fontFamily: "Roboto",
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: textColor,
);

const tsH1Black = TextStyle(
  fontFamily: "Roboto",
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: textColor,
);

const tsH2White = TextStyle(
  fontFamily: "Roboto",
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  color: greyLightColor,
);

const tsH4White = TextStyle(
    fontFamily: "Roboto",
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
    color: greyLightColor);

const tsH4Green = TextStyle(
  fontFamily: "Roboto",
  fontSize: 28.0,
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

void showCupertinoSnackBar({
  required BuildContext context,
  required String message,
  int durationMillis = 2400,
}) {
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 8.0,
      left: 8.0,
      right: 8.0,
      child: CupertinoPopupSurface(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          child: Text(
            message,
            style: CupertinoTheme.of(context).textTheme.actionTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
  Future.delayed(
    Duration(milliseconds: durationMillis),
    overlayEntry.remove,
  );
  Overlay.of(Navigator.of(context).context)?.insert(overlayEntry);
}
