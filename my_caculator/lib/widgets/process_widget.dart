import 'package:flutter/material.dart';

class ProcessWidget extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color backGroundColor;
  final VoidCallback onTap;
  final double left;
  final double right;
  const ProcessWidget(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backGroundColor,
      required this.left,
      required this.right,
      required this.onTap});

  @override
  State<ProcessWidget> createState() => _ProcessWidgetState();
}

class _ProcessWidgetState extends State<ProcessWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * .2,
                height: height * .1,
      margin: EdgeInsets.only(left: widget.left, right: widget.right),
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll<Color>(widget.backGroundColor),
          overlayColor:
              WidgetStateColor.resolveWith((states) => Colors.white),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
