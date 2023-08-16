import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Cubits/search_cubit/search_cubit.dart';

import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/widgets/button.dart';
import 'package:cars_app/UI/widgets/my_dropdown_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilterDialog extends StatefulWidget {
  final Function onSearch;
  const FilterDialog({super.key, required this.onSearch});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? carType;
  String? carBrand;
  String? priceRange;
  String? odometerRange;
  String? location;

  @override
  void initState() {
    final state = context.read<SearchCubit>().state;
    carType = state.type.isNotEmpty ? state.type : null;
    carBrand = state.brand.isNotEmpty ? state.brand : null;
    priceRange = state.priceRange.isNotEmpty ? state.priceRange : null;
    odometerRange = state.meterRange.isNotEmpty ? state.meterRange : null;
    location = state.location.isNotEmpty ? state.location : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        titlePadding: EdgeInsets.only(top: 2.h),
        title: Center(
            child: Text(
          'Filter',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        )),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildDropDownRow(
                  dropdownmenue: MyDropdownMenu(
                      value: carType,
                      onChange: (value) {
                        setState(() {
                          carType = value;
                        });
                      },
                      menu: ['For Selling', 'For Renting'],
                      hint: 'Car Type'),
                  icon: Icons.car_crash),
              SizedBox(
                height: 1.h,
              ),
              BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  List<String> brands = [];
                  if (state.status == AppStatus.succeeded) {
                    brands = state.brands;
                  }
                  return buildDropDownRow(
                      dropdownmenue: MyDropdownMenu(
                          value: carBrand,
                          onChange: (value) {
                            setState(() {
                              carBrand = value;
                            });
                          },
                          menu: brands,
                          hint: 'Car Brand'),
                      icon: Icons.directions_car);
                },
              ),
              SizedBox(
                height: 1.h,
              ),
              buildDropDownRow(
                  dropdownmenue: MyDropdownMenu(
                      value: location,
                      onChange: (value) {
                        setState(() {
                          location = value;
                        });
                      },
                      menu: governrates,
                      hint: 'Car Location'),
                  icon: Icons.location_on_sharp),
              SizedBox(
                height: 1.h,
              ),
              buildDropDownRow(
                  dropdownmenue: MyDropdownMenu(
                      value: priceRange,
                      onChange: (value) {
                        setState(() {
                          priceRange = value;
                        });
                      },
                      menu: [
                        '100000 -> 500000',
                        '1000000 -> 5000000',
                        '1000000 -> 10000000',
                        '10000000 -> 60000000'
                      ],
                      hint: 'Price Range'),
                  icon: Icons.monetization_on_rounded),
              SizedBox(
                height: 1.h,
              ),
              buildDropDownRow(
                  dropdownmenue: MyDropdownMenu(
                      value: odometerRange,
                      onChange: (value) {
                        setState(() {
                          odometerRange = value;
                        });
                      },
                      menu: [
                        '100000 -> 500000',
                        '1000000 -> 5000000',
                        '1000000 -> 10000000',
                        '10000000 -> 60000000'
                      ],
                      hint: 'Odometer Range'),
                  icon: Icons.merge_type_rounded),
              SizedBox(
                height: 3.h,
              ),
              Button(
                onPressed: () {
                  context.read<SearchCubit>().saveFilter(
                      type: carType ?? '',
                      brand: carBrand ?? '',
                      priceRange: priceRange ?? "",
                      meterRange: odometerRange ?? "",
                      location: location ?? "");
                  widget.onSearch();
                },
                text: 'Search',
                buttonHight: 2.h,
                buttonWidth: 30.w,
                buttonColor: secondColor,
              )
            ],
          ),
        ]);
  }

  buildDropDownRow({required Widget dropdownmenue, required IconData icon}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28.Q,
          color: secondColor,
        ),
        SizedBox(
          width: 4.w,
        ),
        SizedBox(width: 55.w, child: dropdownmenue)
      ],
    );
  }
}
