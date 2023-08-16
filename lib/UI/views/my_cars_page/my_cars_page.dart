import 'package:cars_app/Core/Cubits/my_cars_cubit/my_cars_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/views/my_cars_page/localWidgets/my_car_card.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animate_do/animate_do.dart';

class MyCarsPage extends StatefulWidget {
  const MyCarsPage({super.key});

  @override
  State<MyCarsPage> createState() => _MyCarsPageState();
}

class _MyCarsPageState extends State<MyCarsPage>
    with AutomaticKeepAliveClientMixin {
  List<CarData>? myCars;
  @override
  void initState() {
    context.read<MyCarsCubit>().getMyCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<MyCarsCubit, MyCarsState>(
      listener: (context, state) async {
        if (state is carDeleteLoading) {
          Loader.show(status: EasyLoadingConfig.loadingText);
        }

        if (state is carDeleteSucceeded) {
          await context.read<MyCarsCubit>().getMyCars();
          Loader.dismiss();
        }
        if (state is carDeleteFailed) {
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
        if (state is MyCarsLoading) {
          return Center(
            child: LoadingWidget(),
          );
        }
        if (state is MyCarsFailed) {
          return MyErrorWidget(
            error: state.error,
            func: () {
              context.read<MyCarsCubit>().getMyCars();
            },
          );
        }
        if (state is MyCarsEmpty) {
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/noCars.svg',
                width: 40.w,
                height: 12.h,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text('No Cars Added Yet')
            ],
          );
        }
        if (state is MyCarsLoaded) {
          myCars = state.mycars;
        }
        return SlideInUp(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return MyCarCard(car: myCars![index]);
            },
            itemCount: myCars!.length,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
