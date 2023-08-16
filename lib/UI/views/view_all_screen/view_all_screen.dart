import 'package:cars_app/Core/Cubits/view_all_cubit/view_all_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/widgets/cars_card.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewAllScreen extends StatefulWidget {
  static const routeName = '/ViewAllScreen';
  final String title;
  const ViewAllScreen({super.key, required this.title});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  List<CarData> cars = [];
  @override
  void initState() {
    context
        .read<ViewAllCubit>()
        .getCars(isTopRated: widget.title == 'Top Rated');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.title),
      body: BlocBuilder<ViewAllCubit, ViewAllState>(
        builder: (context, state) {
          if (state is ViewAllLoading) {
            return Center(
              child: LoadingWidget(),
            );
          }
          if (state is ViewAllFailed) {
            return MyErrorWidget(
              error: state.error,
              func: () {
                context
                    .read<ViewAllCubit>()
                    .getCars(isTopRated: widget.title == 'Top Rated');
              },
            );
          }
          if (state is ViewAllLoaded) {
            cars = state.cars;
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(
                      left: 4.w,
                      right: 4.w,
                      top: index == 0 ? 1.h : 0.h,
                      bottom: index == 9 ? 2.h : 1.h),
                  child: CarCard(car: cars[index]));
            },
            itemCount: cars.length,
          );
        },
      ),
    );
  }
}
