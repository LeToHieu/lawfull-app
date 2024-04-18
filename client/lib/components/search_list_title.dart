import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchListTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  SearchListTitle({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              width: 250,
              child: Text(title, overflow: TextOverflow.ellipsis, maxLines: 3),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Divider(
                thickness: 1,
                color: Colors.grey[400],
              ),
            )
          ],
        ),
      ),
    );
  }
}
