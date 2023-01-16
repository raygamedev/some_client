import 'package:flutter/material.dart';

class CardMarkWidget extends StatefulWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final Color color;
  bool isMarked = false;

  CardMarkWidget(
      {super.key,
      required this.onTap,
      required this.color,
      required this.iconData,
      this.isMarked = false});

  @override
  State<CardMarkWidget> createState() => _CardMarkWidgetState();
}

class _CardMarkWidgetState extends State<CardMarkWidget> {
  @override
  Widget build(BuildContext context) {
    double size = 93.0;

    return InkResponse(
      onTap: widget.isMarked ? null : widget.onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            image: widget.isMarked
                ? const DecorationImage(
                    scale: 1.3,
                    image: AssetImage('assets/images/coffeeBeanIcon.png'))
                : null,
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ]),
      ),
    );
  }
}
