import 'package:cars_app/Core/Cubits/add_car_cubit/add_car_cubit.dart';
import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Cubits/my_cars_cubit/my_cars_cubit.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/dialog_utils.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/helpers/snackbar_utils.dart';
import 'package:cars_app/UI/views/add_car_screen/localWidgets/image_container.dart';
import 'package:cars_app/UI/widgets/button.dart';
import 'package:cars_app/UI/widgets/input_field.dart';
import 'package:cars_app/UI/widgets/my_app_bar.dart';
import 'package:cars_app/UI/widgets/my_dropdown_menu.dart';
import 'package:cars_app/UI/widgets/my_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddCarScreen extends StatefulWidget {
  static const routeName = '/AddCarScreen';
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  String? brand;
  String? location;
  CarType carType = CarType.forSelling;
  final formKey = GlobalKey<FormState>();
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final distanceController = TextEditingController();
  final descriptionController = TextEditingController();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList.length.toString());
    setState(() {});
  }

  void deleteOneImage(image) {
    setState(() {
      imageFileList.remove(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Button(
          text: 'Add',
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (imageFileList.isEmpty) {
                showSnackBar(
                    context, 'Choose images of the car first', secondColor);
              } else {
                List<String> images = [];
                imageFileList.forEach((element) {
                  images.add(element.path);
                });
                context.read<AddCarCubit>().addCar(
                    images: images,
                    forSelling: carType == CarType.forRenting ? false : true,
                    brand: brand!,
                    model: modelController.text,
                    location: location!,
                    price: priceController.text,
                    odometer: distanceController.text,
                    description: descriptionController.text);
              }
            }
          },
          buttonWidth: 100.w,
          buttonColor: secondColor,
        ),
      ),
      appBar: MyAppBar(
        title: 'Add Car',
        showSearchBar: false,
      ),
      body: BlocListener<AddCarCubit, AddCarState>(
        listener: (context, state) async {
          if (state is AddCarLoading) {
            Loader.show(status: EasyLoadingConfig.loadingText);
          }

          if (state is AddCarSucceeded) {
            await context.read<MyCarsCubit>().getMyCars();
            Loader.dismiss();
            Navigator.pop(context);
          }
          if (state is AddCarFailed) {
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
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 8.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    imageFileList.isEmpty ? selectImages() : {};
                  },
                  child: Container(
                    width: 100.w,
                    height: 15.h,
                    padding: EdgeInsets.only(left: 2.w, right: 2.w),
                    decoration: BoxDecoration(
                        color: grayColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15.Q)),
                    child: imageFileList.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_rounded,
                                color: secondColor,
                                size: 30.Q,
                              ),
                              Text('Add photos for your car')
                            ],
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                ...imageFileList.map((e) {
                                  return ImageContainer(
                                      image: e, deleteOneImage: deleteOneImage);
                                }),
                                SizedBox(
                                  width: 1.w,
                                ),
                                InkWell(
                                  onTap: selectImages,
                                  child: Text(
                                    'Add more',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyRadioButton(
                        value: CarType.forSelling,
                        groupValue: carType,
                        title: 'For Selling',
                        onChanged: (value) {
                          setState(() {
                            carType = value;
                          });
                        }),
                    MyRadioButton(
                        value: CarType.forRenting,
                        groupValue: carType,
                        title: 'For Renting',
                        onChanged: (value) {
                          setState(() {
                            carType = value;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      BlocBuilder<AppCubit, AppState>(
                        builder: (context, state) {
                          List<String> brands = state.brands;
                          return MyDropdownMenu(
                              value: brand,
                              hint: 'Choose the brand',
                              validator: (value) {
                                if (value == null) {
                                  return 'Choose the brand please';
                                }
                                return null;
                              },
                              onChange: (value) {
                                setState(() {
                                  brand = value;
                                });
                              },
                              menu: brands);
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      InputField(
                          hint: 'Model of The Car',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter the model please';
                            }
                            return null;
                          },
                          controller: modelController),
                      SizedBox(
                        height: 2.h,
                      ),
                      MyDropdownMenu(
                          value: location,
                          hint: 'Choose location of the car',
                          validator: (value) {
                            if (value == null) {
                              return 'Choose the location please';
                            }
                            return null;
                          },
                          onChange: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                          menu: governrates),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 65.w,
                            child: InputField(
                                hint: 'Price ',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter the price please';
                                  }
                                  return null;
                                },
                                controller: priceController),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            carType == CarType.forSelling ? 'S.P' : 'S.P / Day',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey, fontSize: 17.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 65.w,
                            child: InputField(
                                hint: 'Odometer',
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter the odometer please';
                                  }
                                  return null;
                                },
                                controller: distanceController),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            'KM',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey, fontSize: 17.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      InputField(
                        multiLine: true,
                        controller: descriptionController,
                        hint: 'Description (optional)',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
