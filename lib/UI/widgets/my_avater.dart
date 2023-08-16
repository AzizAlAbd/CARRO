import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Cubits/avatar_cubit/avatar_cubit.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyAvatar extends StatelessWidget {
  final bool showEdit;
  const MyAvatar({super.key, this.showEdit = false});

  buildAvatarCircle(String avatar) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(80.Q),
      child: Container(
        // backgroundImage: AssetImage('assets/images/jujutsu.jpg'),
        decoration: BoxDecoration(
            image: !avatar.isEmpty
                ? DecorationImage(
                    image: CachedNetworkImageProvider(avatar),
                    fit: BoxFit.cover)
                : null,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2)),
        width: 27.w,
        height: 27.w,

        child: avatar.isEmpty
            ? Icon(
                Icons.person,
                size: 60.Q,
                color: mainColor,
              )
            : null,
      ),
    );
  }

  void pickImage(BuildContext context) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      BlocProvider.of<AvatarCubit>(context).uploadAvatar(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        String avatar = state.avatar;
        return showEdit
            ? Stack(children: [
                buildAvatarCircle(avatar),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => pickImage(context),
                    child: CircleAvatar(
                      child: Icon(Icons.edit),
                    ),
                  ),
                )
              ])
            : buildAvatarCircle(avatar);
      },
    );
  }
}
