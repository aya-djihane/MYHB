import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myhb_app/appColors.dart';


class CustomButton extends StatefulWidget {
  double? width;
  String value;
  Color color;
  final VoidCallback? onTap;

  CustomButton({required this.width,required this.value,this.onTap,this.color=AppColors.darkGrey,Key? key,t}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          width: widget.width,
          height: 50,
          decoration: ShapeDecoration(
            color: widget.color.withOpacity(.6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child:Center(
            child: Text(
              widget.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Glassio',
                fontWeight: FontWeight.w600,
              ) ,
            ),
          )),
    );
  }
}