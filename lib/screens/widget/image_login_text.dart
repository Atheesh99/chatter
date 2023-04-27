import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageLoginText extends StatelessWidget {
  const ImageLoginText(
      {Key? key,
      required this.imagepath,
      required this.text,
      required this.title})
      : super(key: key);
  final String imagepath;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          imagepath,
          width: size.width * 0.9,
          height: size.height * 0.41,
        ),
        Text(
          text,
          style: GoogleFonts.frankRuhlLibre(
              fontSize: 43,
              color: textBlack,
              fontWeight: FontWeight.w700,
              letterSpacing: 1),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        kHeight30,
      ],
    );
  }
}
