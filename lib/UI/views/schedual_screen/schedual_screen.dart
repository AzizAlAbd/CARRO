import 'package:cars_app/Core/Cubits/schedual_cubit/schedual_cubit.dart';
import 'package:cars_app/Core/Models/appointments_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/views/schedual_screen/localWidgets/appointment_card.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animate_do/animate_do.dart' as animate;

class SchedualScreen extends StatefulWidget {
  static const String routeName = '/SchedualScreen';

  const SchedualScreen({super.key});

  @override
  State<SchedualScreen> createState() => _SchedualScreenState();
}

class _SchedualScreenState extends State<SchedualScreen> {
  List<AppointmentData> recived = [];
  List<AppointmentData> sent = [];

  @override
  void initState() {
    context.read<SchedualCubit>().getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          MyAppBar(isHome: false, title: 'My Schedual', showSearchBar: false),
      body: BlocConsumer<SchedualCubit, SchedualState>(
        listener: (context, state) async {
          if (state is DeleteAppointmentLoading) {
            Loader.show(status: EasyLoadingConfig.loadingText);
          }

          if (state is DeleteAppointmentSucceeded) {
            await context.read<SchedualCubit>().getAppointments();
            Loader.dismiss();
          }
          if (state is DeleteAppointmentFailed) {
            Loader.dismiss();
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
          if (state is SchedualLoading) {
            return Center(
              child: LoadingWidget(),
            );
          }
          if (state is SchedualFailed) {
            return MyErrorWidget(
              error: state.error,
              func: () {
                context.read<SchedualCubit>().getAppointments();
              },
            );
          }
          if (state is SchedualEmpty) {
            return Center(
              child: Text('No Appointments!'),
            );
          }
          if (state is SchedualLoaded) {
            recived = state.recivedAppointment;
            sent = state.sentAppointment;
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: recived.isNotEmpty,
                    child: buildSection(recived, 'Recived Appointments'),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Visibility(
                    visible: sent.isNotEmpty,
                    child: buildSection(sent, 'Sent Appointments'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  buildSection(List<AppointmentData> data, String title) {
    return Column(
      children: [
        animate.FadeIn(
            duration: Duration(milliseconds: 900),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 17.sp,
                  color: secondColor,
                  fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: 2.h,
        ),
        ...List.generate(
            data.length,
            (index) => animate.SlideInRight(
                  delay: Duration(milliseconds: index * 200),
                  child: AppointmentCard(
                    appointment: data[index],
                    isReceived: title == 'Recived Appointments' ? true : false,
                  ),
                ))
      ],
    );
  }
}
