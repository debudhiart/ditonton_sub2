import 'package:flutter/material.dart';

import 'package:ditonton/common/constants.dart';

// ignore: must_be_immutable
class EmptyMessage extends StatelessWidget {
  IconData icon;
  String title;

  EmptyMessage({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: kMikadoYellow,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
