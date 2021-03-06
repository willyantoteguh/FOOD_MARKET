part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = "009432".toColor();
Color greyColor = "8D92A3".toColor();

TextStyle greyFontStyle = GoogleFonts.varela().copyWith(color: greyColor);
TextStyle blackTextFont = GoogleFonts.varela()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackTextFont2 = GoogleFonts.varela()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackTextFont3 = GoogleFonts.varela().copyWith(color: Colors.black);

Widget loadingIndicator = SpinKitFadingCircle(
  size: 45,
  color: mainColor,
);
