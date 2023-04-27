import 'package:chatter/const/color.dart';
import 'package:chatter/screens/widget/search.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  SearchIcon(icon: Icons.search, size: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
