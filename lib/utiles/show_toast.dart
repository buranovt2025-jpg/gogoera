import 'package:era_shop/utiles/Theme/my_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> displayToast({required String message, bool? isBottomToast}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: isBottomToast == true ? ToastGravity.BOTTOM : ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: MyColors.primaryPink,
    textColor: MyColors.white,
    fontSize: 16.0,
  );
}
