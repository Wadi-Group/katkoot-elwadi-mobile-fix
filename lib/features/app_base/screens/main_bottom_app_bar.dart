import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/features/app_base/screens/custom_drawer.dart';
import 'package:katkoot_elwady/features/category_management/screens/home_screen.dart';
import 'package:katkoot_elwady/features/menu_management/screens/edit_profile_screen.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/navigation_drawer.dart'
    as NDrawer;
import 'package:katkoot_elwady/features/search_management/screens/base_search_screen.dart';
import 'package:katkoot_elwady/features/user_management/screens/login_screen.dart';
import '../../../core/di/injection_container.dart' as di;

class MainBottomAppBar extends StatefulWidget {
  static const routeName = "./main_app_bar";

  @override
  _MainBottomAppBarState createState() => _MainBottomAppBarState();
}

class _MainBottomAppBarState extends State<MainBottomAppBar>
    with SingleTickerProviderStateMixin {
  late final _selectedIndexProvider = StateProvider<int>((ref) {
    return ref.watch(di.bottomNavigationViewModelProvider).data.selectedIndex;
  });

  late final TabController _tabController =
      TabController(vsync: this, length: 4);
  late final List<Widget> mainTabs = <Widget>[
    Navigator(onGenerateRoute: (RouteSettings settings) {
      return PageRouteBuilder(pageBuilder: (context, _, __) {
        // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
        navStack[0] = context;
        return HomeScreen();
      });
    }),
    Navigator(onGenerateRoute: (RouteSettings settings) {
      return PageRouteBuilder(pageBuilder: (context, _, __) {
        // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
        navStack[1] = context;
        return BaseSearchScreen();
      });
    }),
    Navigator(onGenerateRoute: (RouteSettings settings) {
      return PageRouteBuilder(pageBuilder: (context, _, __) {
        // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
        navStack[2] = context;
        bool userIsLoggedIn = ProviderScope.containerOf(context, listen: false)
            .read(di.userViewModelProvider.notifier)
            .isUserLoggedIn();
        return userIsLoggedIn
            ? EditProfileScreen()
            : LoginScreen(
                nextRoute: MaterialPageRoute(
                    builder: (context) => EditProfileScreen()),
              );
      });
    }),
    Navigator(onGenerateRoute: (RouteSettings settings) {
      return PageRouteBuilder(pageBuilder: (context, _, __) {
        // use page PageRouteBuilder instead of 'PageRouteBuilder' to avoid material route animation
        navStack[3] = context;
        return NDrawer.NavigationDrawer();
      });
    }),
  ];

  final List<BuildContext?> navStack = List.generate(
      4,
      (index) =>
          null); // one buildContext for each tab to store history  of navigation

  final List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
        backgroundColor: AppColors.Dark_spring_green,
        label: '',
        icon: Icon(Icons.home_outlined)),
    BottomNavigationBarItem(
      backgroundColor: AppColors.Dark_spring_green,
      label: '',
      icon: Icon(Icons.search),
    ),
    BottomNavigationBarItem(
      backgroundColor: AppColors.Dark_spring_green,
      label: '',
      icon: Icon(Icons.person_outlined),
    ),
    BottomNavigationBarItem(
      backgroundColor: AppColors.Dark_spring_green,
      label: '',
      icon: Icon(Icons.menu_sharp),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    ProviderScope.containerOf(context, listen: false)
        .refresh(di.bottomNavigationViewModelProvider.notifier)
        .setController(_tabController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Consumer(
        builder: (_, ref, __) {
          int selectedIndex = ref.watch(_selectedIndexProvider);
          return Scaffold(
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: mainTabs,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.white,
              unselectedItemColor: AppColors.white.withOpacity(0.4),
              backgroundColor: AppColors.Dark_spring_green,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 30,
              items: bottomNavigationBarItems,
              currentIndex: selectedIndex,
              onTap: (index) {
                onBottomNavigationItemTap(index);
              },
            ),
          );
        },
      ),
      onWillPop: () async {
        if (Navigator.of(navStack[_tabController.index]!).canPop()) {
          print('can pop');
          Navigator.of(navStack[_tabController.index]!).pop();
          ProviderScope.containerOf(context, listen: false)
              .read(_selectedIndexProvider.state)
              .state = _tabController.index;
          return false;
        } else {
          if (_tabController.index == 0) {
            print('can not pop zero index');
            ProviderScope.containerOf(context, listen: false)
                .read(_selectedIndexProvider.state)
                .state = _tabController.index;
            SystemChannels.platform
                .invokeMethod('SystemNavigator.pop'); // close the app
            return true;
          } else {
            print('can not pop non zero index');
            _tabController.index =
                0; // back to first tap if current tab history stack is empty
            ProviderScope.containerOf(context, listen: false)
                .read(_selectedIndexProvider.state)
                .state = _tabController.index;
            return false;
          }
        }
      },
    );
  }

  void onBottomNavigationItemTap(int index) {
    if (index == _tabController.index &&
        Navigator.of(navStack[_tabController.index]!).canPop()) {
      Navigator.of(navStack[_tabController.index]!)
          .popUntil((route) => route.isFirst);
    } else {
      _tabController.index = index;
      ProviderScope.containerOf(context, listen: false)
          .read(_selectedIndexProvider.state)
          .state = index;
    }
  }
}
