import 'package:counter/utlis/app_color.dart';
import 'package:counter/view_models/cart_cubit/cart_cubit.dart';
import 'package:counter/view_models/home_cubit/home_cubit.dart';
import 'package:counter/views/pages/cart_page.dart';
import 'package:counter/views/pages/favorite_page.dart';
import 'package:counter/views/pages/home_page.dart';
import 'package:counter/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              "https://scontent-hbe1-1.cdninstagram.com/v/t51.2885-19/451382748_1043107513938378_868927710872673827_n.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=scontent-hbe1-1.cdninstagram.com&_nc_cat=106&_nc_oc=Q6cZ2QHn37S7hcSV4_rtutqM68NXXKbmU8IxLHbhhsDsl7rMkdrXqOwIbgQ2BYPXKWoXGqQ&_nc_ohc=3QbyTlExCBQQ7kNvwHHahPw&_nc_gid=-lDHPRJBtpNX_XaeXRG8RQ&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AffJuchz8lKRQsCHO8MA4Wq0clB9rpylhSqT1A2dwy1OpQ&oe=68FFD7F3&_nc_sid=7a9f4b"
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ali Muhammad',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              'Let\'s do shopping',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.grey),
            ),
          ],
        ),

        actions: [
          if (currentIndex == 0) ...[
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          ],
           if(currentIndex==2)...[
             IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag)),
          ]
        ],
      ),
      body: PersistentTabView(
        onTabChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        stateManagement: false,
        tabs: [
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) {
                final cubit = HomeCubit();
                cubit.getData();
                return cubit;

                
              },
              child: HomePage(),
            ),
            item: ItemConfig(icon: Icon(Icons.home), title: "Home",activeForegroundColor: AppColors.primary),
          ),
          PersistentTabConfig(
            screen: FavoritePage(),
            item: ItemConfig(icon: Icon(Icons.favorite), title: "Favorite",activeForegroundColor: AppColors.primary),
          ),
          PersistentTabConfig(
            screen: BlocProvider(
              create: (context) {
                final cubit = CartCubit();
                cubit.getCartData();
                return cubit;
              },
              child: CartPage(),
            ),
            item: ItemConfig(icon: Icon(Icons.card_travel), title: "Cart",activeForegroundColor: AppColors.primary),
          ),
          PersistentTabConfig(
            screen: ProfilePage(),
            item: ItemConfig(icon: Icon(Icons.person), title: "Profile",activeForegroundColor: AppColors.primary),
          ),
        ],

        navBarBuilder:
            (navBarConfig) => Style6BottomNavBar(navBarConfig: navBarConfig),
      ),
    );
  }
}
