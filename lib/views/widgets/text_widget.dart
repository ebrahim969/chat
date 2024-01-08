import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget({required String txt , double fontsize = 12 , FontWeight fontWeight = FontWeight.normal , Color color = kPrimaryColor}){
  return Text(txt , style: GoogleFonts.poppins(fontSize: fontsize , fontWeight: fontWeight , color: color),textAlign: TextAlign.start, );
}