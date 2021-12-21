// Demonstrates a MessageBox from the console

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

void main() {
  final result = using((Arena arena) {
    final message =
        'This is not really an error, but we are pretending for the sake '
                'of this test.\n\nResource error.\nDo you want to try again?'
            .toNativeUtf16(allocator: arena);
    final caption = 'Dart MessageBox Test'.toNativeUtf16(allocator: arena);
    return MessageBox(
        NULL,
        message,
        caption,
        MB_ICONWARNING | // Warning
            MB_CANCELTRYCONTINUE | // Action button
            MB_DEFBUTTON2 // Second button is the default
        );
  });

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
