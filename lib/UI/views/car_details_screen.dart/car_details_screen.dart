import 'package:cars_app/Core/Cubits/car_detailes_cubit/car_details_cubit.dart';
import 'package:cars_app/Core/Cubits/my_fav_cubit/my_fav_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/helpers/snackbar_utils.dart';
import 'package:cars_app/UI/views/car_details_screen.dart/localWidgets/car_info_widget.dart';
import 'package:cars_app/UI/widgets/button.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarDetailsScreen extends StatefulWidget {
  static const routeName = '/CarDetailsScreen';
  final String carID;
  CarDetailsScreen({super.key, required this.carID});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  int ImageCounter = 1;
  double ratingValue = 0;
  CarData? car;
  bool fav = false;
  bool isRated = false;
  bool isAppointmentedRequested = false;

  @override
  void initState() {
    context.read<CarDetailsCubit>().getDetalis(id: widget.carID);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarDetailsCubit, CarDetailsState>(
      listener: (context, state) {
        if (state is CarRatingloading || state is CarAppointmentLoading) {
          Loader.show(status: EasyLoadingConfig.loadingText);
        }
        if (state is CarAppointmentSucceeded) {
          Loader.dismiss();
          setState(() {
            isAppointmentedRequested = true;
          });
          showSnackBar(context,
              'You have made an request to check on this car!', secondColor);
        }
        if (state is CarRatingSucceeded) {
          Loader.dismiss();
          setState(() {
            isRated = true;
          });
          showSnackBar(context, 'You have rated this car!', secondColor);
        }
        if (state is CarAppointmentFailed) {
          Loader.dismiss();
          DialogUtils.ourAlertDialog(context,
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 100,
              ),
              content: state.error);
        }
        if (state is CarRatingFailed) {
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
        if (state is CarDetailsLoading) {
          return Center(
            child: LoadingWidget(),
          );
        }
        if (state is CarDetailsFailed) {
          return MyErrorWidget(
            error: state.error,
            func: () {
              context.read<CarDetailsCubit>().getDetalis(id: widget.carID);
            },
          );
        }
        if (state is CarDetailsSucceeded) {
          if (car == null) {
            car = state.car;

            fav = state.car.isLiked!;

            isRated = state.car.isRated!;
            isAppointmentedRequested = state.car.isAppointmentRequested!;
          }
        }
        return Scaffold(
            extendBody: true,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 1.h, right: 2.w, left: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(
                    icon: fav
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    buttonWidth: 18.w,
                    onPressed: () async {
                      await context
                          .read<MyFavCubit>()
                          .toggleFav(id: widget.carID, fav: fav);
                      setState(() {
                        fav = !fav;
                        print('er');
                      });
                    },
                    borderColor: fav ? secondColor : null,
                    buttonColor: fav ? Colors.white : secondColor,
                    textColor: fav ? secondColor : Colors.white,
                  ),
                  Button(
                    text: isAppointmentedRequested
                        ? "Already have an appointment"
                        : 'Make an appointment',
                    buttonWidth: 75.w,
                    enable: !isAppointmentedRequested,
                    onPressed: () {
                      _datepiker();
                    },
                    buttonColor:
                        isAppointmentedRequested ? Colors.grey : secondColor,
                  )
                ],
              ),
            ),
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: mainColor,
                  centerTitle: true,
                  expandedHeight: 35.h,
                  floating: true,
                  stretch: true,
                  actions: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 1.5.h, horizontal: 2.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20.Q)),
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Text(
                        '$ImageCounter / ${car!.images.length}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                  elevation: 6,
                  flexibleSpace: Card(
                    margin: EdgeInsets.all(0),
                    // margin: EdgeInsets.only(top: 15.h, right: 3.w, left: 3.w),
                    elevation: 4,
                    child: Container(
                      height: 100.h,
                      child: car!.images.length == 1
                          ? CachedNetworkImage(
                              imageUrl: car!.images[0],
                              fit: BoxFit.cover,
                            )
                          : ImageSlideshow(
                              indicatorColor: secondColor,
                              // autoPlayInterval: 5000,
                              isLoop: true,
                              onPageChanged: (value) {
                                setState(() {
                                  ImageCounter = value + 1;
                                });
                              },
                              children: [
                                  ...car!.images.map((e) => CachedNetworkImage(
                                        imageUrl: e,
                                        fit: BoxFit.cover,
                                      ))
                                ]),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                      padding: EdgeInsets.only(
                          top: 2.h, left: 3.w, right: 3.w, bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildBasicInfo(context),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                              width: 80.w,
                              height: 1.h,
                              child: Divider(
                                thickness: 2,
                              )),
                          SizedBox(
                            height: 1.h,
                          ),
                          CarInfoWidget(
                            car: car!,
                          )
                        ],
                      ))
                ]))
              ],
            ));
      },
    );
  }

  void showRatingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            width: 80.w,
            padding:
                EdgeInsets.only(top: 1.h, bottom: 2.h, left: 5.w, right: 5.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.Q)),
            margin: EdgeInsets.only(bottom: 1.h, left: 3.w, right: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 14.h,
                    width: 100.w,
                    child: Image.asset('assets/images/star.jpg')),
                Text('Do you like this car ?',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Rate this Car',
                ),
                SizedBox(
                  height: 2.h,
                ),
                RatingStars(
                  starCount: 5,
                  value: ratingValue,
                  starSize: 24,
                  valueLabelColor: Colors.white,
                  valueLabelTextStyle: TextStyle(
                      fontSize: 14.sp,
                      color: secondColor,
                      backgroundColor: Colors.white),
                  animationDuration: Duration(milliseconds: 1000),
                  onValueChanged: (value) {
                    updated(state, value);
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                      borderColor: secondColor,
                      buttonColor: Colors.white,
                      textColor: secondColor,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Button(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context
                            .read<CarDetailsCubit>()
                            .rateCar(id: car!.id, rate: ratingValue.toInt());
                      },
                      text: 'Submit',
                      buttonColor: secondColor,
                    )
                  ],
                )
              ],
            ),
          );
        });
      },
    );
  }

  Future<Null> updated(StateSetter updateState, double value) async {
    updateState(() {
      ratingValue = value;
    });
  }

  void _datepiker() {
    showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now()
          .add(Duration(days: 1)), //editMode absenceFrom>currentDay
      lastDate: DateTime.now().add(const Duration(days: 60)),
      helpText: 'Please Select The Date',
    ).then((value) {
      if (value == null) {
        return;
      }
      _timePicker(value);
    });
  }

  void _timePicker(DateTime selectedDate) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), //createMode
    ).then((value) {
      if (value == null) {
        //createMode & user cancel the TimePicker //in editMode we shoudn't do anything
        return;
      }
      DateTime fullDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, value.hour, value.minute);
      context
          .read<CarDetailsCubit>()
          .takeAppointment(id: car!.id, date: fullDate.toString());
    });
  }

  Widget buildBasicInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          car!.model,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  car!.rate!.toDouble().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 20.sp, color: Colors.black),
                ),
                SizedBox(
                  width: 2.w,
                ),
                ...buildStars(rating: car!.rate!.toDouble(), size: 28.Q),
              ],
            ),
            isRated
                ? Text(
                    "You've rated this car",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: grayColor),
                  )
                : GestureDetector(
                    onTap: () {
                      showRatingSheet();
                    },
                    child: Text(
                      'Rate This Car',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: grayColor),
                    ),
                  )
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Icon(Icons.car_crash_rounded, color: secondColor, size: 30.Q),
            SizedBox(
              width: 3.w,
            ),
            Text(
              car!.forSale ? 'Selling' : 'Renting',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.black, fontSize: 16.sp),
            )
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Icon(
              Icons.monetization_on_rounded,
              color: secondColor,
              size: 30.Q,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              'Price:',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.black, fontSize: 16.sp),
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              '${car!.price} S.P/Day',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 18.sp, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> buildStars({required double rating, required double size}) {
    List<Widget> widgets = [];
    int value = rating.floor();
    double pointValue = rating - value;
    double rest = 5 - rating;
    if (value == 0 && pointValue == 0) {
      for (var i = 0; i < 5; i++) {
        widgets.add(
          Icon(
            Icons.star_border_outlined,
            color: Colors.grey,
            size: size,
          ),
        );
      }
      return widgets;
    }
    if (value == 0 && pointValue != 0) {
      for (var i = 0; i < 5; i++) {
        if (i == 0) {
          widgets.add(
            Icon(
              Icons.star_half_rounded,
              color: Colors.amber,
              size: size,
            ),
          );
        } else {
          widgets.add(
            Icon(
              Icons.star_border_outlined,
              color: Colors.grey,
              size: size,
            ),
          );
        }
      }
      return widgets;
    } else {
      for (var i = 0; i < value; i++) {
        widgets.add(
          Icon(
            Icons.star_rate_rounded,
            color: Colors.amber,
            size: size,
          ),
        );
      }
      if (pointValue != 0) {
        widgets.add(
          Icon(
            Icons.star_half_rounded,
            color: Colors.amber,
            size: size,
          ),
        );
      }
      for (var i = 0; i < rest.floor(); i++) {
        widgets.add(
          Icon(
            Icons.star_border_outlined,
            color: Colors.grey,
            size: size,
          ),
        );
      }
      return widgets;
    }
  }
}
