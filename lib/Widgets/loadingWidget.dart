import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: SpinKitDoubleBounce(
      color: Colors.black,
    ),
  );
}

linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: SpinKitWave(
      color: Colors.black,
    ),
  );
}
