// const String kCountryCode = "+234";
import 'package:flutter/material.dart';

final kPasswordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
final kEmailRegExp = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
final kNameRegExp = RegExp(r"^[A-Za-z\s]+$");
final kAddressRegExp = RegExp(r"^[A-Za-z0-9'.\-\s,]+$");
final kPhoneRegExp = RegExp(r"^\d{11}$");
final kAccountNumberRegExp = RegExp(r"^\d{10}$");
final kPriceRegExp = RegExp(r"^[0-9]*$");

const kEmpty = '';
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
