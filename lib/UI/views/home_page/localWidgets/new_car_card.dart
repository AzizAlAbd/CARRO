import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/views/car_details_screen.dart/car_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewCarCard extends StatelessWidget {
  final CarData car;
  const NewCarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(4.0.Q),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(CarDetailsScreen.routeName, arguments: car.id);
            },
            borderRadius: BorderRadius.circular(10),
            splashColor: mainColor,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(car.images[0]),
                        fit: BoxFit.cover)),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.black54,
                  ),
                  width: 100.w,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 3, right: 3),
                  child: SizedBox(
                    width: 70.w,
                    child: Text(
                      car.model,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}
