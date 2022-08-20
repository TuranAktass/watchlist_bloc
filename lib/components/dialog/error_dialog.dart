import 'package:flutter/material.dart';
import 'package:watchlist/feat/home/view/home_view/home_view.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(errorMessage),
      ),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => errorMessage.contains("Please Verify your email")
              ? Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const WatchlistHomeView()),
                  (Route<dynamic> route) => false)
              : Navigator.of(context).pop(),
        )
      ],
    );
  }
}
