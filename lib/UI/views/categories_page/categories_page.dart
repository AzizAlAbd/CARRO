import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Models/brands_model.dart';

import 'package:cars_app/UI/views/categories_page/localWidgets/brandCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:animate_do/animate_do.dart' as animate;

class CategoriesPage extends StatefulWidget {
  static const routeName = '/CategoriesScreen';
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 10.h, top: 2.h),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          List<BrandData> brands = state.brandsData;
          return animate.SlideInUp(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2.7 / 2,
                mainAxisSpacing: 1.h,
                crossAxisSpacing: 1.w,
              ),
              itemBuilder: (BuildContext context, int index) {
                return BrandCard(
                  data: brands[index],
                  index: index,
                );
              },
              itemCount: brands.length,
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
