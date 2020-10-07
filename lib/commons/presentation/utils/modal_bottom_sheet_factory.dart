import 'package:flutter/material.dart';

abstract class ModalBottomSheetFactory {
  static Future<T> showDismissible<T>(
    BuildContext context,
    Widget child,
    VoidCallback onClosePressed,
  ) {
    return showModalBottomSheet<T>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      builder: (_) =>
          ModalBottomSheetFactory.createDismissible(child, onClosePressed),
    );
  }

  static Widget createDismissible(
    Widget child,
    VoidCallback onClosePressed,
  ) {
    return Builder(
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 16.0,
              ),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: onClosePressed,
              ),
            ),
            child,
          ],
        );
      },
    );
  }
}
