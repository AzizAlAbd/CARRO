import 'package:cars_app/Core/Cubits/add_car_cubit/add_car_cubit.dart';
import 'package:cars_app/Core/Cubits/app_cubit/app_cubit.dart';
import 'package:cars_app/Core/Cubits/authentication_cubit/authentication_cubit.dart';
import 'package:cars_app/Core/Cubits/avatar_cubit/avatar_cubit.dart';
import 'package:cars_app/Core/Cubits/bloc_observer.dart';
import 'package:cars_app/Core/Cubits/brand_cars_cubit/brand_cars_cubit.dart';
import 'package:cars_app/Core/Cubits/car_detailes_cubit/car_details_cubit.dart';

import 'package:cars_app/Core/Cubits/home_cubit/home_cubit.dart';
import 'package:cars_app/Core/Cubits/log_in_cubit/log_in_cubit.dart';
import 'package:cars_app/Core/Cubits/my_cars_cubit/my_cars_cubit.dart';
import 'package:cars_app/Core/Cubits/my_fav_cubit/my_fav_cubit.dart';
import 'package:cars_app/Core/Cubits/notifications_cubit/notifications_cubit.dart';
import 'package:cars_app/Core/Cubits/profile_cubit/profile_cubit.dart';
import 'package:cars_app/Core/Cubits/schedual_cubit/schedual_cubit.dart';
import 'package:cars_app/Core/Cubits/search_cubit/search_cubit.dart';
import 'package:cars_app/Core/Cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:cars_app/Core/Cubits/view_all_cubit/view_all_cubit.dart';
import 'package:cars_app/Core/Services/app_repo.dart';
import 'package:cars_app/Core/Services/auth_repo.dart';
import 'package:cars_app/Core/Services/brand_cars_repo.dart';
import 'package:cars_app/Core/Services/car_details_repo.dart';
import 'package:cars_app/Core/Services/fav_repo.dart';
import 'package:cars_app/Core/Services/home_repo.dart';
import 'package:cars_app/Core/Services/my_cars_repo.dart';
import 'package:cars_app/Core/Services/notifications_repo.dart';
import 'package:cars_app/Core/Services/profile_repo.dart';
import 'package:cars_app/Core/Services/schedula_repo.dart';
import 'package:cars_app/Core/Services/search_repo.dart';
import 'package:cars_app/Core/Services/view_all_repo.dart';
import 'package:cars_app/Core/Storage/secure_storage.dart';
import 'package:cars_app/UI/helpers/constants.dart';
import 'package:cars_app/UI/helpers/easy_loading_config.dart';
import 'package:cars_app/UI/routes/app_router.dart';
import 'package:cars_app/UI/views/login_screen/login_screen.dart';
import 'package:cars_app/app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white.withOpacity(0)));
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
  EasyLoadingConfig.config();
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SecureStorage>(
          create: (context) => SecureStorage(),
        ),
        RepositoryProvider<AuthRepo>(
          create: (context) => AuthRepo(),
        ),
        RepositoryProvider<HomeRepo>(
          create: (context) => HomeRepo(),
        ),
        RepositoryProvider<MyCarsRepo>(
          create: (context) => MyCarsRepo(),
        ),
        RepositoryProvider<ProfileRepo>(
          create: (context) => ProfileRepo(),
        ),
        RepositoryProvider<AppRepo>(
          create: (context) => AppRepo(),
        ),
        RepositoryProvider<FavRepo>(
          create: (context) => FavRepo(),
        ),
        RepositoryProvider<CarDetailsRepo>(
          create: (context) => CarDetailsRepo(),
        ),
        RepositoryProvider<NotificationsRepo>(
          create: (context) => NotificationsRepo(),
        ),
        RepositoryProvider<SchedualRepo>(
          create: (context) => SchedualRepo(),
        ),
        RepositoryProvider<SearchRepo>(
          create: (context) => SearchRepo(),
        ),
        RepositoryProvider<ViewAllRepo>(
          create: (context) => ViewAllRepo(),
        ),
        RepositoryProvider<BrandCarsRepo>(
          create: (context) => BrandCarsRepo(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>(
            lazy: false,
            create: (context) => AuthenticationCubit(
                repo: RepositoryProvider.of<AuthRepo>(context),
                storage: RepositoryProvider.of<SecureStorage>(context))
              ..appStarted(),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(
                repo: RepositoryProvider.of<AuthRepo>(context),
                storage: RepositoryProvider.of<SecureStorage>(context)),
          ),
          BlocProvider<LogInCubit>(
            create: (context) => LogInCubit(
                repo: RepositoryProvider.of<AuthRepo>(context),
                storage: RepositoryProvider.of<SecureStorage>(context)),
          ),
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(
                repo: RepositoryProvider.of<AppRepo>(context),
                storage: RepositoryProvider.of<SecureStorage>(context)),
          ),
          BlocProvider<HomeCubit>(
            create: (context) => HomeCubit(
                repo: RepositoryProvider.of<HomeRepo>(context),
                storage: RepositoryProvider.of<SecureStorage>(context)),
          ),
          BlocProvider<MyCarsCubit>(
              create: (context) => MyCarsCubit(
                    repo: RepositoryProvider.of<MyCarsRepo>(context),
                  )),
          BlocProvider<AvatarCubit>(
            create: (context) => AvatarCubit(
                repo: RepositoryProvider.of<ProfileRepo>(context),
                storage: RepositoryProvider.of<SecureStorage>(context)),
          ),
          BlocProvider<AddCarCubit>(
            create: (context) => AddCarCubit(
              repo: RepositoryProvider.of<MyCarsRepo>(context),
            ),
          ),
          BlocProvider<MyFavCubit>(
            create: (context) => MyFavCubit(
              repo: RepositoryProvider.of<FavRepo>(context),
            ),
          ),
          BlocProvider<CarDetailsCubit>(
            create: (context) => CarDetailsCubit(
              repo: RepositoryProvider.of<CarDetailsRepo>(context),
            ),
          ),
          BlocProvider<NotificationsCubit>(
            create: (context) => NotificationsCubit(
              repo: RepositoryProvider.of<NotificationsRepo>(context),
            ),
          ),
          BlocProvider<SchedualCubit>(
            create: (context) => SchedualCubit(
              repo: RepositoryProvider.of<SchedualRepo>(context),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              repo: RepositoryProvider.of<ProfileRepo>(context),
              storage: RepositoryProvider.of<SecureStorage>(context),
            ),
          ),
          BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(
              repo: RepositoryProvider.of<SearchRepo>(context),
            ),
          ),
          BlocProvider<BrandCarsCubit>(
            create: (context) => BrandCarsCubit(
              repo: RepositoryProvider.of<BrandCarsRepo>(context),
            ),
          ),
          BlocProvider<ViewAllCubit>(
            create: (context) => ViewAllCubit(
              repo: RepositoryProvider.of<ViewAllRepo>(context),
            ),
          ),
        ],
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationUnauthenticated) {
              Loader.dismiss();

              Navigator.of(MyApp.navigatorKey.currentState!.context)
                  .pushNamedAndRemoveUntil(
                      LoginScreen.routeName, (Route<dynamic> route) => false);
            }
            // if (state is AuthenticationAuthenticated) {
            //   Loader.dismiss();
            //   BlocProvider.of<LeaveCountCubit>(context).init();
            // }
          },
          child: BlocListener<AuthenticationCubit, AuthenticationState>(
            listenWhen: (previous, current) {
              print('previous state is $previous');
              return previous is AuthenticationAuthenticated;
            },
            listener: (context, state) {
              if (state is AuthenticationUnauthenticated) {
                print('here');
                MyApp.navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (route) => true);
              }
            },
            child: ResponsiveSizer(builder: (context, orientation, deviceType) {
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: appTheme,
                onGenerateRoute: AppRouter.generateRoute,
                builder: EasyLoading.init(),
                home: const AppWrapper(),
                navigatorKey: MyApp.navigatorKey,
              );
            }),
          ),
        ),
      ),
    );
  }
}
