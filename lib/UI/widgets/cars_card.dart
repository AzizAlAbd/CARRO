import 'package:cars_app/Core/Cubits/my_fav_cubit/my_fav_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/views/car_details_screen.dart/car_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarCard extends StatefulWidget {
  final CarData car;
  const CarCard({super.key, required this.car});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  bool liked = false;

  @override
  void initState() {
    liked = widget.car.isLiked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 1.5.h),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.Q)),
            elevation: 4,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(CarDetailsScreen.routeName,
                      arguments: widget.car.id);
                },
                child: Container(
                    height: 28.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.Q),
                        border: Border.all(color: secondColor, width: 1)),
                    child: Column(children: [
                      Stack(children: [
                        Container(
                          height: 19.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.Q),
                                  topLeft: Radius.circular(20.Q)),
                              border: Border.all(color: secondColor, width: 1),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      widget.car.images[0]),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 12.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white.withOpacity(0.9),
                              ),
                              child: IconButton(
                                  onPressed: () async {
                                    await context.read<MyFavCubit>().toggleFav(
                                        id: widget.car.id, fav: liked);
                                    setState(() {
                                      liked = !liked;
                                    });
                                  },
                                  icon: Icon(
                                    liked
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    color: secondColor,
                                    size: 28.Q,
                                  )),
                            ),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        widget.car.model,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 16.sp, color: mainColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 0.8.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: secondColor,
                              ),
                              Text(
                                widget.car.rate!.toDouble().toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 15.sp, color: mainColor),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_rounded,
                                color: secondColor,
                              ),
                              Text(
                                widget.car.price.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 15.sp, color: mainColor),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.car_crash_rounded,
                                color: secondColor,
                              ),
                              Text(
                                widget.car.forSale ? 'Selling' : 'Renting',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: 15.sp, color: mainColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ])))));
  }
}
