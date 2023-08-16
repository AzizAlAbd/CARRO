import 'package:carousel_slider/carousel_slider.dart';
import 'package:cars_app/Core/Cubits/home_cubit/home_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/views/home_page/localWidgets/new_car_card.dart';
import 'package:cars_app/UI/views/home_page/localWidgets/home_sec.dart';
import 'package:cars_app/UI/widgets/cars_card.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart' as animate;
import 'package:responsive_sizer/responsive_sizer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with AutomaticKeepAliveClientMixin {
  int i = 0;
  HomeData? data;
  @override
  void initState() {
    context.read<HomeCubit>().getHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(
            child: LoadingWidget(),
          );
        }
        if (state is HomeFailed) {
          return MyErrorWidget(
            error: state.error,
            func: () {
              context.read<HomeCubit>().getHome();
            },
          );
        }
        if (state is HomeLoaded) {
          data = state.data;
        }
        return SingleChildScrollView(
            child: Padding(
          // padding: EdgeInsets.all(0),
          padding: EdgeInsets.only(top: 3.h, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeSection(
                  bodyWidget: CarouselSlider(
                      items: [
                        ...data!.whatSNew.map((e) => NewCarCard(
                              car: e,
                            ))
                      ],
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2,
                        enlargeCenterPage: true,
                        viewportFraction: 0.8,
                        onPageChanged: (index, reason) {
                          setState(() {
                            i = index;
                          });
                        },
                        // initialPage: 1,
                      )),
                  label: "What's New"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ...List.generate(widget.packages.length, (index) => buildDot(index)
                  ...List.generate(
                      data!.whatSNew.length, (index) => buildDot(index))
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                ),
                child: animate.SlideInUp(
                  child: HomeSection(
                      bodyWidget: Center(
                        child: Column(
                          children: [
                            ...data!.topRated.map((e) => CarCard(
                                  car: e,
                                ))
                            // CarCard(),
                            // CarCard(image: 'assets/images/Suzuki.png'),
                            // CarCard(
                            //   image: 'assets/images/ex1.png',
                            // )
                          ],
                        ),
                      ),
                      sublabel: 'view all',
                      label: "Top Rated"),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                ),
                child: animate.SlideInUp(
                  child: HomeSection(
                      bodyWidget: Center(
                        child: Column(
                          children: [
                            ...data!.popular.map((e) => CarCard(
                                  car: e,
                                ))
                          ],
                        ),
                      ),
                      sublabel: 'view all',
                      label: "Popular"),
                ),
              )
            ],
          ),
        ));
      },
    );
  }

  Widget buildDot(int index) {
    return Padding(
        padding: EdgeInsets.only(right: 0.5.w),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 1.7.w,
          width: index == i ? 5.w : 1.5.w,
          decoration: BoxDecoration(
              color: index == i ? secondColor : Colors.grey,
              borderRadius: BorderRadius.circular(50)),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
