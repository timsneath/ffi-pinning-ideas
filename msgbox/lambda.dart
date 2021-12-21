// Demonstrates a MessageBox from the console

import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

// Need a version of this for each combination of allocated variables, no?
Object withWin32String2(String str1, String str2,
    Object Function(Pointer<Utf16> str1, Pointer<Utf16> str2) action) {
  final pStr1 = str1.toNativeUtf16();
  final pStr2 = str2.toNativeUtf16();
  try {
    return action(pStr1, pStr2);
  } finally {
    free(pStr1);
    free(pStr2);
  }
}

void main() {
  final message =
      'This is not really an error, but we are pretending for the sake '
      'of this test.\n\nResource error.\nDo you want to try again?';
  final caption = 'Dart MessageBox Test';
  final result = withWin32String2(
      message,
      caption,
      (Pointer<Utf16> str1, Pointer<Utf16> str2) => MessageBox(
          NULL,
          str1,
          str2,
          MB_ICONWARNING | // Warning
              MB_CANCELTRYCONTINUE | // Action button
              MB_DEFBUTTON2 // Second button is the default
          ));

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
  }
}
