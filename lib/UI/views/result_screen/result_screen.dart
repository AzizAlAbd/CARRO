import 'package:cars_app/Core/Cubits/search_cubit/search_cubit.dart';
import 'package:cars_app/Core/Models/home_model.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/widgets/cars_card.dart';
import 'package:cars_app/UI/widgets/error_widget.dart';
import 'package:cars_app/UI/widgets/filter_dialog.dart';
import 'package:cars_app/UI/widgets/filter_icon.dart';
import 'package:cars_app/UI/widgets/input_field.dart';
import 'package:cars_app/UI/widgets/loading_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResultScreen extends StatefulWidget {
  static const routeName = '/ResultScreen';
  final String? searchText;

  ResultScreen({super.key, this.searchText});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final searchController = TextEditingController();
  List<CarData> result = [];
  @override
  void initState() {
    String model = context.read<SearchCubit>().state.model;
    print('model  : $model');
    searchController.text = model;
    context.read<SearchCubit>().search();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: mainColor,
        leadingWidth: 10.w,
        leading: IconButton(
          icon: Icon(CupertinoIcons.xmark),
          onPressed: () {
            context.read<SearchCubit>().clear();
            Navigator.of(context).pop();
          },
        ),
        title: SizedBox(
          width: 80.w,
          child: InputField(
              icon: Icons.search,
              controller: searchController,
              hint: 'Search for specific model',
              onEditingComplete: () {
                if (searchController.text.isNotEmpty) {
                  context
                      .read<SearchCubit>()
                      .saveModel(model: searchController.text);

                  context.read<SearchCubit>().search();
                }
                FocusManager.instance.primaryFocus?.unfocus();
              }),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 3.w),
              child: FilterICon(ontap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return FilterDialog(
                      onSearch: () {
                        Navigator.of(context).pop();
                        context.read<SearchCubit>().search();
                      },
                    );
                  },
                );
              }))
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.status == SearchStatus.loading) {
            return Center(
              child: LoadingWidget(),
            );
          }
          if (state.status == SearchStatus.failed) {
            return MyErrorWidget(
              error: state.error,
              func: () {
                context.read<SearchCubit>().search();
              },
            );
          }
          if (state.status == SearchStatus.succeeded) {
            result = state.result;
          }
          return result.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 15.h,
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: SvgPicture.asset('assets/images/search.svg'),
                      ),
                      Text(
                        'No Results :(',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 2.h,
                        left: 4.w,
                        right: 4.w,
                      ),
                      child: CarCard(car: result[index]),
                    );
                  },
                  itemCount: result.length,
                );
        },
      ),
    );
  }
}
