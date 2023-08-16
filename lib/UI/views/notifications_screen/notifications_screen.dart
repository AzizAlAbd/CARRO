import 'package:cars_app/Core/Cubits/notifications_cubit/notifications_cubit.dart';
import 'package:cars_app/Core/Models/notifications_model.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';

import 'package:cars_app/UI/views/notifications_screen/localWidgets/notification_card.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/NotificationsScreen';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationData> data = [];

  @override
  void initState() {
    context.read<NotificationsCubit>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isHome: false,
        title: 'Notifications',
        showSearchBar: false,
      ),
      body: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is ReplayLoading) {
            Loader.show(status: EasyLoadingConfig.loadingText);
          }
          if (state is! ReplayLoading) {
            Loader.dismiss();
          }
          if (state is ReplaySucceeded) {
            context.read<NotificationsCubit>().getNotifications();
          }
          if (state is ReplayFailed) {
            DialogUtils.ourAlertDialog(context,
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 100,
                ),
                content: state.error);
          }
        },
        builder: (context, state) {
          if (state is NotificationsLoading) {
            return Center(
              child: LoadingWidget(),
            );
          }
          if (state is NotificationsFailed) {
            return MyErrorWidget(
              error: state.error,
              func: () {
                context.read<NotificationsCubit>().getNotifications();
              },
            );
          }
          if (state is NotificationsEmpty) {
            return Center(
              child: Text('No Notifications!'),
            );
          }
          if (state is NotificationsLoaded) {
            data = state.nots;
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return NotificationCard(not: data[index]);
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
