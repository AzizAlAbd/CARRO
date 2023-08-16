import 'package:cars_app/Core/Cubits/brand_cars_cubit/brand_cars_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/widgets/cars_card.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BrandCarsScreen extends StatefulWidget {
  static const routeName = '/BrandCarsScreen';
  final String title;
  final String id;
  const BrandCarsScreen({super.key, required this.id, required this.title});

  @override
  State<BrandCarsScreen> createState() => _BrandCarsScreenState();
}

class _BrandCarsScreenState extends State<BrandCarsScreen> {
  List<CarData> cars = [];
  @override
  void initState() {
    context.read<BrandCarsCubit>().getCars(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: widget.title),
      body: BlocBuilder<BrandCarsCubit, BrandCarsState>(
        builder: (context, state) {
          if (state is BrandCarsLoading) {
            return Center(
              child: LoadingWidget(),
            );
          }
          if (state is BrandCarsFailed) {
            return MyErrorWidget(
              error: state.error,
              func: () {
                context.read<BrandCarsCubit>().getCars(id: widget.id);
              },
            );
          }
          if (state is BrandCarsLoaded) {
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
