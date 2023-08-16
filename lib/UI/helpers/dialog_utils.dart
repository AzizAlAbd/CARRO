import 'package:cars_app/UI/widgets/our_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  // static Future<void> showErrorDialog(
  //   BuildContext context, {
  //   required String content,
  //   bool preventBackword = false,
  //   String title = 'خطأ',
  //   String okText = 'اعادة المحاولة',
  //   String? cancelText,
  //   Function? okTexetFunc,
  //   Function? cancelTextFunc,
  // }) {
  //   return showGeneralDialog(
  //     context: context,
  //     transitionBuilder: (ctx, a1, a2, child) {
  //       var curve = Curves.easeInOut.transform(a1.value);
  //       return Transform.scale(
  //         scale: curve,
  //         child: OurDialog(
  //           title: title,
  //           content: content,
  //           icon: Icons.error,
  //           circleColor: mainColor,
  //           preventBackword: preventBackword,
  //           okText: okText,
  //           cancelText: cancelText,
  //           okColor: mainColor,
  //           okTexetFunc: okTexetFunc ?? () => Navigator.pop(context),
  //           cancelTextFunc: cancelTextFunc,
  //         ),
  //       );
  //     },
  //     transitionDuration: const Duration(milliseconds: 300),
  //     pageBuilder: (BuildContext context, Animation<double> animation,
  //         Animation<double> secondaryAnimation) {
  //       return Container();
  //     },
  //   );
  // }

  static Future<void> ourAlertDialog(BuildContext context,
      {required Icon icon,
      required String content,
      bool preventBackword = false,
      String buttonText = 'Cancel',
      Function? buttonFunc}) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: OurDialog(
              contentText: content,
              dialogIcon: icon,
              firstButtonText: buttonText,
              cancelButtonFunc: buttonFunc,
              preventBackword: preventBackword),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Container();
      },
    );
  }

  static Future<void> questionDialog(
    BuildContext context, {
    required Icon icon,
    required String content,
    required Function buttonFuction,
    bool preventBackword = true,
  }) {
    return showGeneralDialog(
      context: context,
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: OurDialog(
            contentText: content,
            dialogIcon: icon,
            secondButtonText: 'Yes',
            secoundButtonFunc: buttonFuction,
            firstButtonText: 'No',
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Container();
      },
    );
  }

//   static Future<void> showTryAgainDialog(
//     BuildContext context, {
//     required final String? content,
//     final Color? okColor,
//     final String? okText = 'اعادة المحاولة',
//     required final Function? okTexetFunc,
//   }) {
//     return showGeneralDialog(
//       context: context,
//       transitionBuilder: (ctx, a1, a2, child) {
//         var curve = Curves.easeInOut.transform(a1.value);
//         return Transform.scale(
//           scale: curve,
//           child: TryAgainDialog(
//             content: content!,
//             okText: okText,
//             okColor: okColor ?? mainColor,
//             okTexetFunc: okTexetFunc ?? () => Navigator.pop(context),
//           ),
//         );
//       },
//       transitionDuration: const Duration(milliseconds: 300),
//       pageBuilder: (BuildContext context, Animation<double> animation,
//           Animation<double> secondaryAnimation) {
//         return Container();
//       },
//     );
//   }
}
