import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/navigation_constants.dart';
import 'package:katkoot_elwady/features/app_base/entities/base_state.dart';
import 'package:katkoot_elwady/features/app_base/screens/screen_handler.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_no_data.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/menu_management/entities/navigation_item.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/contact_us_view_model.dart';
import 'package:katkoot_elwady/features/menu_management/view_models/navigation_drawer_mixin.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/contact_info_widget.dart';
import 'package:katkoot_elwady/features/menu_management/widgets/navigation_drawer.dart';
import 'package:katkoot_elwady/features/menu_management/models/contact_us_model.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:easy_localization/easy_localization.dart';
import 'package:collection/collection.dart';
import '../../../core/utils/extentions/string_captilize.dart';

class ContactUsScreen extends StatefulWidget with NavigationDrawerMixin {
  static const routeName = "./contact_us";

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> with AutomaticKeepAliveClientMixin {
  final _contactUsViewModelProvider =
      StateNotifierProvider<ContactUsViewModel, BaseState<ContactUsData?>>(
          (ref) {
    return ContactUsViewModel(ref.read(di.repositoryProvider));
  });

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          showNotificationsButton: true,
          showDrawer: true,
          hasbackButton: true,
          // onBackClick: () => context.read(di.contentProvider).state =
          //     DrawerItemType.drawer.index
      ),
      // drawer: NavigationDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 1.05,
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                            MediaQuery.of(context).size.height * 0.2,
                            horizontal:
                            MediaQuery.of(context).size.width * .18),
                        child: Image.asset(
                          "assets/images/bg_image.png",
                        )),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 35, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "contact_us".tr(),
                          textColor: AppColors.Liver,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                            height:
                            MediaQuery.of(context).size.height * 0.05),
                        Consumer(builder: (_, ref, __) {
                          var viewModel =
                          ref.watch(_contactUsViewModelProvider);
                          var viewmodelNotifier =
                          ref.watch(_contactUsViewModelProvider.notifier);

                          var data = viewModel.data;
                          return Column(
                            children: [
                              if (data?.address != null)
                                ContactUsInfoWidget(
                                  mode: ContactMode.ADDRESS,
                                  hasIcon: true,
                                  hasUnderlineBorder: true,
                                  title: data!.address?.value ?? "",
                                  onTap: () async => await viewmodelNotifier
                                      .handleContactRedirection(
                                      mode: ContactMode.ADDRESS,
                                      address: data.address),
                                ),
                              if (data?.phoneNumbers != null)
                                ...data!.phoneNumbers!
                                    .mapIndexed((i, e) =>
                                    ContactUsInfoWidget(
                                      index: i,
                                      mode: ContactMode.PHONE,
                                      hasIcon: i == 0 ? true : false,
                                      hasUnderlineBorder: i ==
                                          data.phoneNumbers!
                                              .length -
                                              1
                                          ? true
                                          : false,
                                      title: e?.phone ?? "",
                                      onTap: () async =>
                                      await viewmodelNotifier
                                          .handleContactRedirection(
                                        mode: ContactMode.PHONE,
                                        phoneNumber: e?.phone,
                                      ),
                                    ))
                                    .toList(),
                              if (data?.socialMediaLinks != null)
                                ...data!.socialMediaLinks!
                                    .map((e) => ContactUsInfoWidget(
                                  hasUnderlineBorder: true,
                                  hasIcon: true,
                                  mode: ContactMode.SOCIAL_LINK,
                                  title:
                                  e?.name?.capitalize() ?? "",
                                  SocialName: e?.name,
                                  onTap: () async =>
                                  await viewmodelNotifier
                                      .handleContactRedirection(
                                      mode: ContactMode
                                          .SOCIAL_LINK,
                                      url: e?.url),
                                ))
                                    .toList()
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (_, watch, __) {
                      return ScreenHandler(
                        screenProvider: _contactUsViewModelProvider,
                        noDataMessage: "str_no_data".tr(),
                        onDeviceReconnected: getData,
                        noDataWidget: NoDataWidget(),
                      );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    await Future.delayed(Duration.zero, () {
      ProviderScope.containerOf(context,
          listen: false).read(_contactUsViewModelProvider.notifier).getContactUsData();
    });
  }
}
