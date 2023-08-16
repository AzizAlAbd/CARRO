import 'package:cars_app/Core/Cubits/my_fav_cubit/my_fav_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/widgets/cars_card.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class MyFavScreen extends StatefulWidget {
  static const String routeName = '/MyFavScreen';
  const MyFavScreen({super.key});

  @override
  State<MyFavScreen> createState() => _MyFavScreenState();
}

class _MyFavScreenState extends State<MyFavScreen> {
  List<CarData>? data;

  @override
  void initState() {
    context.read<MyFavCubit>().getFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isHome: false,
        showSearchBar: false,
        title: "My Favorites",
      ),
      body: BlocBuilder<MyFavCubit, MyFavState>(
        builder: (context, state) {
          if (state is MyFavLoading) {
            return Center(
              child: LoadingWidget(),
            );
          }
          if (state is MyFavFailed) {
            return MyErrorWidget(
              error: state.error,
              func: () {
                context.read<MyFavCubit>().getFav();
              },
            );
          }
          if (state is MyFavLoaded) {
            data = state.cars;
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                ),
                child: CarCard(car: data![index]),
              );
            },
            itemCount: data!.length,
          );
        },
      ),
    );
  }
}
