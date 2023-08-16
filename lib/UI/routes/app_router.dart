import 'package:cars_app/Core/Models/profile_model.dart';
import 'package:cars_app/UI/views/add_car_screen/add_car_screen.dart';
import 'package:cars_app/UI/views/brand_cars_screen/brand_cars_screen.dart';
import 'package:cars_app/UI/views/car_details_screen.dart/car_details_screen.dart';
import 'package:cars_app/UI/views/edit_profile_screen/edit_profile_screen.dart';
import 'package:cars_app/UI/views/home_screen/home_screen.dart';
import 'package:cars_app/UI/views/login_screen/login_screen.dart';
import 'package:cars_app/UI/views/my_fav_screen/my_fav_screen.dart';
import 'package:cars_app/UI/views/notifications_screen/notifications_screen.dart';
import 'package:cars_app/UI/views/profile_screen/profile_screen.dart';
import 'package:cars_app/UI/views/result_screen/result_screen.dart';
import 'package:cars_app/UI/views/schedual_screen/schedual_screen.dart';
import 'package:cars_app/UI/views/search_screen/search_screen.dart';
import 'package:cars_app/UI/views/singup_screen/signup_screen.dart';
import 'package:cars_app/UI/views/view_all_screen/view_all_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AddCarScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AddCarScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case CarDetailsScreen.routeName:
        String? carID = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => CarDetailsScreen(
                  carID: carID,
                ));
      case NotificationsScreen.routeName:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());
      case SchedualScreen.routeName:
        return MaterialPageRoute(builder: (_) => SchedualScreen());
      case MyFavScreen.routeName:
        return MaterialPageRoute(builder: (_) => MyFavScreen());
      case EditProfileScreen.routeName:
        ProfileData searchText = settings.arguments as ProfileData;
        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(
                  data: searchText,
                ));
      case SearchScreen.routeName:
        String searchText =
            settings.arguments == null ? '' : settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => SearchScreen(
                  searchText: searchText,
                ));
      case ResultScreen.routeName:
        String searchText =
            settings.arguments == null ? '' : settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ResultScreen(
                  searchText: searchText,
                ));
      case BrandCarsScreen.routeName:
        Map<String, dynamic> args = settings.arguments == null
            ? {}
            : settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => BrandCarsScreen(
                  title: args['title'],
                  id: args['id'],
                ));
      case ViewAllScreen.routeName:
        String title =
            settings.arguments == null ? '' : settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ViewAllScreen(
                  title: title,
                ));
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
