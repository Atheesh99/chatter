import 'package:chatter/const/color.dart';
import 'package:chatter/const/size.dart';
import 'package:chatter/screens/widget/call_history_item.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                'Call',
                style: GoogleFonts.frankRuhlLibre(
                    fontSize: 28,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    color: textWhite),
              ),
            ),
            kHeight20,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(6),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: textWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 35, top: 20),
                      child: Text(
                        'Recent',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: textBlack),
                      ),
                    ),
                    kHeight20,
                    Expanded(child: CallHistoryItem()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
