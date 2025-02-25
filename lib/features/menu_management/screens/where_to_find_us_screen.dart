import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/di/injection_container.dart' as di;
import 'package:katkoot_elwady/core/utils/location_manager.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/pagination_list.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/menu_management/entities/where_to_find_us_state.dart';
import 'package:katkoot_elwady/features/menu_management/models/supplier.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/where_to_find_us_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/city_drop_down.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/single_category_drop_down.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/where_to_find_us_supplier_item.dart';
import 'package:katkoot_elwady/features/user_management/models/city.dart';

class WhereToFindUsScreen extends StatefulWidget {
  static const routeName = "./where_to_find_us_screen";

  @override
  _WhereToFindUsScreenState createState() => _WhereToFindUsScreenState();
}

class _WhereToFindUsScreenState extends State<WhereToFindUsScreen>
    with AutomaticKeepAliveClientMixin {
  final _whereToFindUsViewModelProvider = StateNotifierProvider<
      WhereToFindUsViewModel, BaseState<WhereToFindUsState?>>((ref) {
    return WhereToFindUsViewModel(ref.read(di.repositoryProvider));
  });

  late final _suppliersDataProvider = Provider<List<Supplier>>((ref) {
    print('suppliersss');
    return ref.watch(_whereToFindUsViewModelProvider).data?.suppliers ?? [];
  });

  late final _suppliersNoDataProvider = Provider<bool>((ref) {
    return ref.watch(_whereToFindUsViewModelProvider).data?.hasNoData ?? false;
  });

  late final _markersProvider = Provider<Set<Marker>>((ref) {
    return ref.watch(_whereToFindUsViewModelProvider).data?.markers ?? {};
  });

  late final _citiesDataProvider = Provider<List<City>>((ref) {
    return ref.watch(_whereToFindUsViewModelProvider).data?.cities ?? [];
  });

  late final _categoriesDataProvider = Provider<List<Category>>((ref) {
    return ref.watch(_whereToFindUsViewModelProvider).data?.categories ?? [];
  });

  late final _selectedCityProvider = Provider<City?>((ref) {
    return ref.watch(_whereToFindUsViewModelProvider).data?.selectedCity;
  });

  late final _selectedCategoryIdProvider = Provider<int?>((ref) {
    return ref.watch(_whereToFindUsViewModelProvider).data?.selectedCategoryId;
  });

  GoogleMapController? _controller;
  MinMaxZoomPreference zoomLevel = MinMaxZoomPreference(3, 25);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    getScreenData();
  }

  Future getScreenData() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context, listen: false)
          .read(_whereToFindUsViewModelProvider.notifier)
          .getScreenData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.LIGHT_BACKGROUND,
        key: _scaffoldKey,
        appBar: CustomAppBar(
          showNotificationsButton: true,
          title: 'where_to_find_us'.tr(),
          showDrawer: true,
          hasbackButton: true,
          // onBackClick: () => context.read(di.contentProvider).state =
          //     DrawerItemType.drawer.index
        ),
        // drawer: NavigationDrawer(),
        body: SafeArea(
          child: Stack(children: [
            Column(
              children: [
                _buildMapView(),
                _buildFilterButtonsView(),
                _buildSuppliersView()
              ],
            ),
            Consumer(
              builder: (_, watch, __) {
                return ScreenHandler(
                  screenProvider: _whereToFindUsViewModelProvider,
                  noDataMessage: "str_no_data".tr(),
                  onDeviceReconnected: getScreenData,
                  noDataWidget: NoDataWidget(),
                );
              },
            ),
          ]),
        ));
  }

  Future<LatLng?> getControllerLatLng() async {
    return await _controller?.getLatLng(ScreenCoordinate(x: 0, y: 0));
  }

  Widget _buildMapView() {
    return Consumer(builder: (_, ref, __) {
      var markers = ref.watch(_markersProvider);
      City? selectedCity = ProviderScope.containerOf(context, listen: false)
          .read(_selectedCityProvider);
      List<Supplier>? suppliers =
          ProviderScope.containerOf(context, listen: false)
              .read(_suppliersDataProvider);

      var bounds = selectedCity == null || (suppliers?.isEmpty ?? true)
          ? markers
          : ref
              .watch(_whereToFindUsViewModelProvider.notifier)
              .getSelectedCityMarkers();

      LatLng centerLatlng = LatLng(
          (LocationManager.boundsFromLatLngList(bounds).northeast.latitude +
                  LocationManager.boundsFromLatLngList(bounds)
                      .southwest
                      .latitude) /
              2,
          (LocationManager.boundsFromLatLngList(bounds).northeast.longitude +
                  LocationManager.boundsFromLatLngList(bounds)
                      .southwest
                      .longitude) /
              2);

      // _controller?.animateCamera(CameraUpdate.newLatLngBounds(
      //     LocationManager.boundsFromLatLngList(bounds), 50));
      _controller
          ?.animateCamera(CameraUpdate.newLatLngZoom((centerLatlng), 13));

      // _controller?.moveCamera(CameraUpdate.zoomTo(10));
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              markers: markers,
              minMaxZoomPreference: zoomLevel,
              zoomGesturesEnabled: true,
              initialCameraPosition:
                  CameraPosition(target: LatLng(30.013056, 31.208853), zoom: 5),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) async {
                _controller = controller;
              },
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: GestureDetector(
                onTap: () {
                  ProviderScope.containerOf(context, listen: false)
                      .read(_whereToFindUsViewModelProvider.notifier)
                      .resetSelectedCity();
                  ProviderScope.containerOf(context, listen: false)
                      .read(_whereToFindUsViewModelProvider.notifier)
                      .getSuppliers();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsetsDirectional.only(top: 10, end: 10),
                  child: Icon(
                    Icons.my_location,
                    color: AppColors.Dark_spring_green,
                    size: 30,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: AppColors.SHADOW_GREY,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildSuppliersView() {
    return Expanded(
      child: Stack(
        children: [
          Consumer(builder: (_, ref, __) {
            var suppliers = ref.watch(_suppliersDataProvider);

            return PaginationList(
              padding: const EdgeInsets.symmetric(vertical: 5),
              itemBuilder: (context, index) {
                var supplier = suppliers[index];
                return WhereToFindUsSupplierItem(supplier: supplier);
              },
              itemCount: suppliers.length,
              onLoadMore: () =>
                  ProviderScope.containerOf(context, listen: false)
                      .read(_whereToFindUsViewModelProvider.notifier)
                      .getSuppliers(showLoading: false, fromPagination: true),
              hasMore: ProviderScope.containerOf(context, listen: false)
                  .read(_whereToFindUsViewModelProvider.notifier)
                  .hasNext,
              loading: ProviderScope.containerOf(context, listen: false)
                  .read(_whereToFindUsViewModelProvider)
                  .isLoading,
            );
          }),
          Consumer(builder: (_, ref, __) {
            var noData = ref.watch(_suppliersNoDataProvider);

            return noData ? NoDataWidget() : Container();
          }),
        ],
      ),
    );
    ;
  }

  _buildFilterButtonsView() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Consumer(builder: (_, ref, __) {
              var cities = ref.watch(_citiesDataProvider);
              var selectedCity = ref.watch(_selectedCityProvider);
              return CityDropDown(
                cities: cities,
                selectedCity: selectedCity != null
                    ? cities
                        .firstWhere((element) => element.id == selectedCity.id)
                    : null,
                onChange: (city) {
                  ProviderScope.containerOf(context, listen: false)
                      .read(_whereToFindUsViewModelProvider.notifier)
                      .getSuppliers(city: city);
                },
              );
            }),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Consumer(builder: (_, ref, __) {
              var categories = ref.watch(_categoriesDataProvider);
              var selectedCategoryId = ref.watch(_selectedCategoryIdProvider);
              print(selectedCategoryId);
              return SingleCategoryDropDown(
                categories: categories,
                selectedCategory: categories.isNotEmpty
                    ? categories.firstWhere(
                        (element) => element.id == selectedCategoryId,
                        orElse: () => categories[0])
                    : null,
                onChange: (category) {
                  ProviderScope.containerOf(context, listen: false)
                      .read(_whereToFindUsViewModelProvider.notifier)
                      .getSuppliers(categoryId: category.id);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
