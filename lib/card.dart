import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:some_client/models/models.dart';

import 'cardmark.dart';

class CardWidget extends HookWidget {
  final VoidCallback onMarkTap;
  final CardColor color;
  const CardWidget({super.key, required this.onMarkTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 900,
      child: Card(
        color: Color(color.cardColor),
        elevation: 4,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.height * 0.3,
          bottom: MediaQuery.of(context).size.height * 0.15,
        ),
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
        child: Wrap(
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          spacing: 60.0,
          runSpacing: 20.0,
          children: <Widget>[
            for (int i = 0; i < 8; i++)
              CardMarkWidget(
                color: Color(color.markColor),
                onTap: onMarkTap,
                iconData: Icons.add,
                isMarked: false,
              ),
          ],
        ),
      ),
    );
  }
}
