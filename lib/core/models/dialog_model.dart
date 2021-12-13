import 'package:flutter/material.dart';

class DialogRequest {
  DialogRequest(
      {@required this.title,
      @required this.description,
      @required this.buttonTitle,
      this.cancelTitle,
      this.onOkayClicked});

  final String title;
  final String description;
  final String buttonTitle;
  final String cancelTitle;
  final Function onOkayClicked;
}

class DialogResponse {
  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });

  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;
}
