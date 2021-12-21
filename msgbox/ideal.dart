// Demonstrates a MessageBox from the console

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

// Doesn't work, obviously
void main() {
  final pinned message =
      'This is not really an error, but we are pretending for the sake '
      'of this test.\n\nResource error.\nDo you want to try again?';
  final pinned caption = 'Dart MessageBox Test';

  final result = MessageBox(
      NULL,
      message.ptr,
      caption.ptr,
      MB_ICONWARNING | // Warning
          MB_CANCELTRYCONTINUE | // Action button
          MB_DEFBUTTON2 // Second button is the default
      );

  switch (result) {
    case IDCANCEL:
      print('Cancel pressed');
      break;
    case IDTRYAGAIN:
      print('Try Again pressed');
      break;
    case IDCONTINUE:
      print('Continue pressed');
      break;

    // Pinned memory is automatically freed when it goes out of scope?
  }
}
