import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  ListTitle({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
        child: Container(
          padding: EdgeInsets.all(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.comment),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 200,
                    child: Text(title,
                        overflow: TextOverflow.ellipsis, maxLines: 3),
                  ),
                ],
              ),
              Icon(Icons.navigate_next),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
