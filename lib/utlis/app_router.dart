import 'package:counter/utlis/app_routes.dart';
import 'package:counter/view_models/add_new_card_cubit/add_new_card_cubit.dart';
import 'package:counter/view_models/product_details_cubit/porduct_details_cubit.dart';
import 'package:counter/views/pages/add_new_card_page.dart';
import 'package:counter/views/pages/check_out_page.dart';
import 'package:counter/views/pages/choose_location_page.dart';
import 'package:counter/views/pages/home_page.dart';
import 'package:counter/views/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class AppRouter {
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutes.homeRoute:
//         return MaterialPageRoute(builder: (_) => HomePage());
//       case AppRoutes.foodDetailsRoute:
//         final String productId = settings.arguments as String;
//         return MaterialPageRoute(
//           builder:
//               (_) => BlocProvider(
//                 create: (context) {
//                   final cubit=PorductDetailsCubit();
//                   cubit.getProductDetailsData(productId);
//                   return cubit;
//                 },
//                 child: ProductDetailsPage(productId: productId),
//               ),
//         );
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(body: Center(child: Text("data"))),
//         );
//     }
//   }
// }
class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.foodDetailsRoute:
        final String productId = settings.arguments as String;

        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) {
                  final cubit = PorductDetailsCubit();
                  cubit.getProductDetailsData(productId);
                  return cubit;
                },
                child: ProductDetailsPage(productId: productId),
              ),
        );
      case AppRoutes.checkoutRoute:
        return MaterialPageRoute(builder: (_) => CheckOutPage());
      case AppRoutes.addNewCard:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (context) => AddNewCardCubit(),
                child: AddNewCardPage(),
              ),
        );
      case AppRoutes.choseLocation:
        return MaterialPageRoute(builder: (_) => ChooseLocationPage());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Text("empty")));
    }
  }
}
