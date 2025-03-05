import 'package:flutter/material.dart';

const EdgeInsets ksmall = EdgeInsets.all(8);
const EdgeInsets kmedium = EdgeInsets.all(16);
const EdgeInsets klarge = EdgeInsets.all(24);

const double kdefaultPadding = 20;

const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

const kDoubleSizedBox = SizedBox(
  height: kDefaultPadding * 2,
);

const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

final regex = RegExp(r'[!@#\$&*~]');

BoxDecoration whiteThing() {
  return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding * 1.5),
          topRight: Radius.circular(kDefaultPadding * 1.5)));
}
