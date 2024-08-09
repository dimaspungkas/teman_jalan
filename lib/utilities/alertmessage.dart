import 'package:flutter/material.dart';
import 'package:teman_jalan/utilities/colors.dart';
import 'package:teman_jalan/utilities/range.dart';

class CustomAlertDialog extends StatelessWidget {
  final int type;
  final Color bgColor;
  final String title;
  final String message;
  final String okBtnText;
  final String noBtnText;
  final Function? onOkPressed;
  final Function? onNoPressed;
  final double circularBorderRadius;

  CustomAlertDialog({
    super.key,
    required this.type, //1=confirm message , 2=error message , 3=success message ,4=info
    required this.title,
    required this.message,
    this.circularBorderRadius = 15.0,
    this.bgColor = Colors.white,
    this.okBtnText = "OK",
    this.noBtnText = "NO",
    this.onOkPressed,
    this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    Icon alertIcon = const Icon(Icons.not_interested_outlined);
    //confirm message
    if (type == 1) {
      alertIcon = const Icon(
        Icons.exit_to_app,
        size: 55,
        color: primaryBlue,
      );
      //error message
    } else if (type == 2) {
      alertIcon = const Icon(
        Icons.cancel_outlined,
        size: 55,
        color: primaryRed,
      );
      //success message
    } else if (type == 3) {
      alertIcon = const Icon(
        Icons.check_circle_outline_rounded,
        size: 55,
        color: primaryGreen,
      );
      //info message
    } else if (type == 4) {
      alertIcon = const Icon(
        Icons.info_outline_rounded,
        size: 55,
        color: Colors.lightBlue,
      );
    }
    return AlertDialog(
      title: Container(alignment: Alignment.center, child: alertIcon),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: sizeMd),
      ),
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circularBorderRadius)),
      actions: <Widget>[
        onOkPressed == null
            ? Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: sizeMd),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            : ElevatedButton(
                child: Text(noBtnText),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onNoPressed != null) {
                    onNoPressed!();
                  }
                },
              ),
        onOkPressed == null
            ? Container()
            : ElevatedButton(
                child: Text(
                  okBtnText,
                  style: const TextStyle(fontSize: sizeMd),
                ),
                onPressed: () {
                  if (onOkPressed != null) {
                    onOkPressed!();
                  }
                },
              )
      ],
    );
  }
}
