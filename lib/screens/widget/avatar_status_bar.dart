import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';

import 'package:flutter/cupertino.dart';

class AvatarstatusBar extends StatelessWidget {
  final double? size;
  final Image? image;

  const AvatarstatusBar({
    Key? key,
    this.size = 56,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          itemCount: 8,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          separatorBuilder: (context, index) => kWidth20,
          itemBuilder: (context, index) {
            ///////////////////////////// pending//////////////////////////////
            return Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: textGrey),
                shape: BoxShape.circle,
              ),
              child: image,
            );
            // Avatar(
            //   image: Image.asset('assets/google_icon.png'),
            // );
          },
        ),
      ),
    );
  }
}
